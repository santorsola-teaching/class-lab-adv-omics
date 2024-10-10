so_consequences <- readRDS(
    url("https://raw.githubusercontent.com/lescai-teaching/datasets_reference_only/main/annotations/ranked_ensembl_consequences.RData", 
        "rb")
)

get_from_ann <- function(annotation, element){
    data <- unlist(str_split(annotation, "\\|"))
    return(data[element])
}

get_rank <- function(consequence){
    rank = so_consequences$rank[which(so_consequences$SO_term %in% consequence)]
    return(rank)
}

get_most_severe_index <- function(annotations_list){
    consequences = unlist(lapply(annotations_list, get_from_ann, element = 2))
    ranks = unlist(lapply(consequences, get_rank))
    most_severe = which(min(ranks) %in% ranks)
    return(most_severe[1])
}

get_most_severe_consequence <- function(annotations_list){
    consequence <- tryCatch(
        {
            index <- get_most_severe_index(annotations_list)
            get_from_ann(annotations_list[[index]], element = 2)
        },
        error=function(cond){
            return(NA)
        }
    )
    return(consequence)
}

get_most_severe_gene <- function(annotations_list){
    gene <- tryCatch(
        {
            index <- get_most_severe_index(annotations_list)
            get_from_ann(annotations_list[[index]], element = 4)
        },
        error=function(cond){
            return(NA)
        }
    )
    return(gene)
}

get_most_severe_ens <- function(annotations_list){
    ens <- tryCatch(
        {
            index <- get_most_severe_index(annotations_list)
            get_from_ann(annotations_list[[index]], element = 5)
        },
        error=function(cond){
            return(NA)
        }
    )
    return(ens)
}

get_most_severe_tr <- function(annotations_list){
    tr <- tryCatch(
        {
            index <- get_most_severe_index(annotations_list)
            get_from_ann(annotations_list[[index]], element = 7)
        },
        error=function(cond){
            return(NA)
        }
    )
    return(tr)
}

get_most_severe_aa_change <- function(annotations_list){
    aa_change <- tryCatch(
        {
            index <- get_most_severe_index(annotations_list)
            get_from_ann(annotations_list[[index]], element = 11)
        },
        error=function(cond){
            return(NA)
        }
    )
    return(aa_change)
}


get_most_severe_impact <- function(annotations_list){
    impact <- tryCatch(
        {
            index <- get_most_severe_index(annotations_list)
            get_from_ann(annotations_list[[index]], element = 3)
        },
        error=function(cond){
            return(NA)
        }
    )
    return(impact)
}

