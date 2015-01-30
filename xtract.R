# efg, 2014-12-30

setwd("C:/Data/US-Government/Census-Bureau/Missouri-Census-Data-Center/Census-Tracts/")
sink("xtract.txt", split=TRUE)

library(stringr)

s <- readLines("xtract-RAW.txt")
header <- s[1:2]

s <- s[-2]  # remove second header line

writeLines(s, "TempFile")
d <- read.delim("TempFile", quote="", as.is=TRUE)
file.remove("TempFile")

dim(d)
# [1] 73056  1045

# textConnection is terribly slow for huge file
# but will work with header info
connector <- textConnection(header)
info <- read.delim(connector, header=FALSE, as.is=TRUE)
close(connector)

info <- data.frame(t(info), stringsAsFactors=FALSE)
names(info) <- c("Line1", "Line2")
info$Line2 <- str_trim(info$Line2)

write.csv(info, "xtract-info.csv", row.names=FALSE)

sink()
