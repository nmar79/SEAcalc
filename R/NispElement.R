#' Calculate NISP for each element of a taxon for each layer/context
#'
#' Reads a zooarchaeological database and returns a .csv file with counts of elements (in rows) by layers/contexts (in columns). 
#' @param data a data frame with zooarchaeological data. Should contain "layer", "taxon", "element", and "zone" columns. 
#' @param taxon the name of a target taxon
#' @return NISP per element for a by layer/context, as a csv file and a data frame object.
#' @examples 
#' NispElement(read.csv("my_data.csv"))
#' @export

NispElement <- function(data, taxon){
  
#ancillary vars
selected_taxon <- taxon
NISP_df_in <- data[which(data$taxon == taxon),]

elements <- unique(data$element)

empty_cat <- which(elements == "")
if (is.na(empty_cat) == FALSE){elements <- elements[!elements %in% ""]}

NISPs <- 1:length(elements)
layers <- unique(data$layer)
NISP_df_out <- data.frame(elements)

for (j in 1:length(layers)){
  
  temp_df <- NISP_df_in[which(NISP_df_in$layer == layers[j]),]
  
  for (i in 1:length(elements)){
    
    NISPs[i] <- length(grep(elements[i],temp_df$element))
    
  }
  
  NISP_df_out <- cbind(NISP_df_out, NISPs)
  
}

#add a totals column

for (i in 1:length(elements)){
  
  NISPs[i] <- length(grep(elements[i],NISP_df_in$element))
  
}

NISP_df_out <- cbind(NISP_df_out, NISPs)


#rename NISP_out_df columns
temp <- 1:length(layers)
for (i in 1:length(layers)){temp[i] <- paste0("Context_",layers[i])}
colnames(NISP_df_out) <- c("Element", temp, "All")

nisp_element_df <<- NISP_df_out
write.csv(NISP_df_out,"nisp_element_df")

}
