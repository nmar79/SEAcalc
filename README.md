# SEAcalc
zooarchaeological bone count calculations for diagnostic zone data.

The package is built to analyze zooarchaeological data spreadsheet, in which there are three columns for taxon, element, and diagnostic zones present. The diagnostic zones I use are scan sites (Lyman 1984), so they are unique: for example, "TI5" would be the distal tibia. If using a system when the zone names are not unique (for example, Dobney and Rielly 1988, in which zone "1" occurs in each element, please make sure that you convert them to a unique notation (so zone "1" on the tibia would be "ti1", and zone "1" on the femur would be "fe1"). A supplementary database detailing the diagnostic zone system is required for the ZoneCount() function, which produces MNE and zone counts tables. 

To install the package, use 

devtools::install_github("nmar79/SEAcalc")
