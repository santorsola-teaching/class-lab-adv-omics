nextflow run nf-core/sarek -r 3.3.2 \
--input datasets_lesson33/germline/reads/sarek_samplesheet.csv \
--outdir results-in-you-bucket \
--igenomes_ignore true \
--genome GRCh38chr21 \
--tools haplotypecaller,snpeff \
--skip_tools haplotypecaller_filter \
--joint_germline \
--intervals datasets_lesson33/germline/chr21_intervals.list \
-c sarek_nextflow.config \
-profile gls

