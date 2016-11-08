library(RPostgreSQL)
library(plyr)
library(broom)
library(ggplot2)
library(caroline)

loc = "data/go_reg/"

################################
# READ DATA
################################

files <- list.files(path = loc, pattern = ".*.txt")

agency_id <- as.character(read.csv(paste0(loc,"agency.txt"),header=T)[,1])

tables <- NULL
for (i in 1:length(files)) {
  tables[i] <- strsplit(files[i],'[.]')[[1]][1]
  temp <- read.csv(paste0(loc,files[i]), header=T)
  temp$agency_id <- agency_id
  assign(tables[i],temp)
  rm(temp)
}

################################
# CONNECT FROM POSTGRESQL
################################
drv <- dbDriver("PostgreSQL")
source("connect/connect.R")

dbWriteTable(con, c("gtfs","agency"), agency, append = T)
# dbWriteTable2(con, c("gtfs","agency"), agency, append = T, add.id = F)

for (t in tables) {

}