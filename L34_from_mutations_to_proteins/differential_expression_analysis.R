library(DESeq2)
library(tximport)
library(tidyverse)
library(pheatmap)
library(clusterProfiler)
library(DOSE)
library(org.Hs.eg.db)


# Set conditions, e.g. cases/controls


dataset <- tibble(
  sample = c("control_rep1",
             "control_rep2",
             "control_rep3",
             "treatment_rep1",
             "treatment_rep2",
             "treatment_rep3"),
  condition = c(rep("control", 3),
                rep("case", 3))
)


# Read transcript to gene ID table
tx2gene <- read_tsv("results/salmon/salmon_tx2gene.tsv", col_names = FALSE, show_col_types = FALSE)
tx2gene$X2 <- paste(tx2gene$X2, tx2gene$X3, sep='_')


# Read quantification files (*.quant) from salmon pseudo-alignment
files <- file.path("results/salmon", dataset$sample, "quant.sf")
names(files) <- dataset$sample

txi <- tximport(files, type = "salmon", tx2gene = tx2gene)

colnames(txi$counts)
rownames(dataset) <- colnames(txi$counts)


dds <- DESeqDataSetFromTximport(txi, dataset, ~condition)


# Filter min counts >= 10
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]


# set base level to "control"
dds$condition <- relevel(dds$condition, ref = "control")


# Perform Differential Expression Analysis between cases and controls

dds <- DESeq(dds)


# Extract results table from the dds object
res <- results(dds)
head(results(dds, tidy=TRUE)) #let's look at the results table 

summary(res)
### Top Genes by padj
resOrdered <- res[order(res$padj),]


# Graphical representations of the main results

pdf("plots_maplot.pdf")
plotMA(res, ylim=c(-3,3))
abline(h=c(-1,1), col="dodgerblue", lwd=2)
dev.off()


pdf("plots_dispersion.pdf")
plotDispEsts(dds)
dev.off()


# plotcounts for the most de-regulated gene within the dataset
pdf("plots_counts.pdf")
plotCounts(dds, gene=which.min(res$padj), intgroup="condition")
dev.off() 


# Save results to tsv or RData files
resdata <- as_tibble(resOrdered)
resdata$gene <- rownames(resOrdered)
write_tsv(resdata, "deseq2_results.tsv")

save.image("deseq2_analysis.RData")


# CLUSTERING analysis

ntd <- normTransform(dds)
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:20]

df <- as.data.frame(colData(dds)[,c("condition")])



pdf("plots_heatmap.pdf")
pheatmap(assay(ntd)[select,],
         cluster_cols=FALSE, annotation_col=df$condition)
dev.off()


#Plot Principal Component Aanalysis
pdf("plots_pca.pdf")
plotPCA(ntd, intgroup=c("condition"))
dev.off()

save.image("deseq2_analysis.RData")


# Select the most significant genes by padj
universe <- AnnotationDbi::select(org.Hs.eg.db,
                                  keys = keys(org.Hs.eg.db),
                                  columns = c('ENTREZID','SYMBOL','ENSEMBL','ENSEMBLTRANS'),
                                  keytype = 'ENTREZID')

sig_genes <- resdata$gene[which(resdata$padj<0.05)]
entrez_genes_sig <- unique(universe[which(universe$ENSEMBL %in% sig_genes),]$ENTREZID)

pvalue_ens_genes <- resdata$padj[which(resdata$padj<0.05)]
names(pvalue_ens_genes)<-sig_genes

pvalue_entrez_genes <- resdata$padj[which(resdata$padj<0.05)]
names(pvalue_entrez_genes) <- entrez_genes_sig


# Gene Ontology Enrichment Analysis

ego <- enrichGO( gene = sig_genes,
                 universe = unique(tx2gene$GENEID),
                 OrgDb = org.Hs.eg.db,
                 keyType = 'ENSEMBL',
                 ont = "CC",
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.05)


pdf("plots_ego.pdf")
dotplot(ego, showCategory=30)
dev.off()

pdf("plots_network-ego.pdf")
cnetplot(ego, foldChange=resdata$log2FoldChange[which(resdata$padj<0.5)])
dev.off()

