# SEAcalc
zooarchaeological bone count calculations for diagnostic zone data.

The package is built to analyze zooarchaeological data spreadsheets in which there are four columns for layer, taxon, element, and diagnostic zones. The diagnostic zones I use are scan sites (Lyman 1984), so they are unique: for example, "TI5" would be the distal tibia. If using a system when the zone names are not unique (for example, Dobney and Rielly 1988, in which zone "1" occurs in each element, please make sure that you convert them to a unique notation (so zone "1" on the tibia would be "ti1", and zone "1" on the femur would be "fe1"). A supplementary database detailing the diagnostic zone system is required for the MneTaxon() function, which produces MNE and zone counts tables. 

To install the package, use 

devtools::install_github("nmar79/SEAcalc")

Database template example:

specimen    layer   taxon   element   zone      ....
NR-0001     4       capra   humerus   HU4,HU5
NR-0002     7       gazelle femur     FE1
.
.
.




