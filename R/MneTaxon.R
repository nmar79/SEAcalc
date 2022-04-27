#' Calculate the number of diagnostic zones and the element MNE for a given taxon by layer/context
#' Reads a zooarchaeological database and returns a .csv file with counts; elements/zones in rows and layers/contexts in columns. 
#' @param data a data frame with zooarchaeological data. Should contain "layer", "taxon", "element", and "zone" columns. 
#' @param zones a data frame with "element", "zone", and "description" columns.
#' @param taxon the name of the taxon (or several taxa) for which zone counts and MNEs should be calculated.
#' @return MNE for each element by layer/context, as a dataframe object and a csv file; Count of diagnostic zones for the selected taxon by layer/context.
#' @examples 
#' MneTaxon(read.csv("my_data.csv"), read.csv("my_zone_list.csv"), c("capra","bovid_2"))
#' @export

MneTaxon <- function(data, zones, taxon){

#prepare var loops and receiving df
nzones <- length(zones$zone)
looper_1 <- 1:nzones
zone_col_ref <- which(colnames(zones) == "zone")
zone_col_dat <- which(colnames(data) == "zone")
zone_counts_df <- zones
taxon_data <- data[which(data$taxon == taxon),]
layers <- unique(data$layer)


#count zones per layer

for (i in 1:length(layers)){
  
  temp <- which(taxon_data$layer == layers[i])
  
  for (j in 1:nzones){
    looper_1[j] <- length(grep(zones[j,zone_col_ref],taxon_data[temp,zone_col_dat]))
  }
  zone_counts_df <- cbind(zone_counts_df,looper_1)
  looper_1 <- 1:nzones
}


#add a column for the summed layers

for (j in 1:nzones){
  looper_1[j] <- length(grep(zones[j,zone_col_ref],taxon_data[,zone_col_dat]))
}
zone_counts_df <- cbind(zone_counts_df,looper_1)

#rename df columns

colnames(zone_counts_df) <- c("element", "zone","description",layers, "total")

zone_counts_df <<- zone_counts_df
write.csv(zone_counts_df, "zone_counts.csv")


##get per-element MNEs

elements <- unique(zones$element)
MNE_df <- data.frame(elements)
MNE_vector <- 1:length(elements)

for (j in 4:(length(layers)+3)){
  
  for (i in 1:length(elements)){ 
    
    loop_element <- grep(elements[i], zone_counts_df$element)
    
    MNE_vector[i] <- max(zone_counts_df[loop_element,j])
    
  }
  
  MNE_df <- cbind(MNE_df,MNE_vector)
 
}

colnames(MNE_df) <- c("element",layers)

MNE_by_element <<- MNE_df
write.csv(MNE_df, "MNE_by_element.csv")

}
