# Prompt
options(prompt="\033[0;34mR\033[0;37m>\033[m ")
options(continue="\033[0;37m...\033[1;34m ")

# packages folder
switch(Sys.info()[['sysname']],
  Darwin = { .libPaths("/Users/gmac/local/R") },
  Linux  = { .libPaths("/home/egserver/local/R") }
  )

# default cran repo
local({
  r <- getOption("repos")
  r["CRAN"] <- "http://cran.utstat.utoronto.ca/"
  options(repos = r)
})

library(colorout)
library(lintr)
