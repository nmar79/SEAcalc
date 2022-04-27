#' NispTaxon
#'
#' @description Calculate NISP by taxon for each layer/context. Reads a zooarchaeological database and returns a .csv file with taxain rows and layers/contexts in columns. 
#' @param data a data frame with zooarchaeological data. Should contain "layer", "taxon", "element", and "zone" columns. 
#' @return NISP per taxon by layer/context, as a csv file.
#' @examples 
#' NispTaxon(read.csv("my_data.csv"))
#' @export

NispTaxon <- function(data){
  
  #ancillary vars
  taxa <- unique(data$taxon)
  NISPtaxa <- 1:length(taxa)
  NISPtaxa_out <- data.frame(taxa)
  layers <- unique(data$layer)
  
  #main loop
  
  for (j in 1:length(layers)){
    
    temp_df <- data[which(data$layer == layers[j]),]
    
    for (i in 1:length(taxa)){
      
      NISPtaxa[i] <- length(grep(taxa[i],temp_df$taxon))
      
    }
    
    NISPtaxa_out <- cbind(NISPtaxa_out, NISPtaxa)
    
  }
  
  #totals column
  
  for (i in 1:length(taxa)){
    
    NISPtaxa[i] <- length(grep(taxa[i],data$taxon))
    
  }
  
  NISPtaxa_out <- cbind(NISPtaxa_out, NISPtaxa)
  
  #rename columns
  
  colnames(NISPtaxa_out) <- c("taxon",layers, "total")
  
  #output

  NISPtaxa_out <<- NISPtaxa_out
  write.csv(NISPtaxa_out, "NISP_by_taxon.csv")
  
  #cleanup
  
  rm(i,j,NISPtaxa,taxa)
}
