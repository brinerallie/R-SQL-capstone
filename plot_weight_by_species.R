# extracts species and weights for a given year from portal rodent 
# database; makes a fancy plot and saves the plot to a file

library(RSQLite)
library(ggplot2)

# get command-line arguments
#args <- commandArgs(TRUE)
#if (length(args)==0) {
#  stop("Script requires a year argument", call.=FALSE)
#} else if (length(args)==1) {
#  year <- args[1]
#}
year <- 1998
print(paste("Getting data for year",year))

# create a connection to the database
# 
myDB <- "/Users/alexandrabriner/Desktop/SQL_practice/portal_mammals.sqlite"
conn <- dbConnect(drv = SQLite(), dbname= myDB)

# some database functions for listing tables and fields
dbListTables(conn)
dbListFields(conn,"surveys")

# constructing a query
query_string <- "SELECT count(*) FROM surveys"
dbGetQuery(conn,query_string)
head(result)

# write a query that gets the non-null weights for 
# all species in this year
query_string <- "SELECT year,weight,species_id FROM surveys WHERE weight IS NOT NULL GROUP BY year"
result <- dbGetQuery(conn,query_string)
head(result)

# plot the data and save to a png file
ggplot(data =  result, aes(x = year, y = weight)) +
  geom_boxplot()
outputfilename <- ".png"
ggsave(outputfilename)
