library(cranlogs)
library(data.table)
library(knitr)

downloads = cran_downloads(packages = c("randomForest", "xgboost", "randomForestSRC", "ranger", "Rborist"), from = "2016-03-01", to = "2016-03-31" )
downloads = data.table(downloads)
downloads = downloads[, sum(count), by = "package"]
downloads_new = cran_downloads(packages = c("randomForest", "xgboost", "randomForestSRC", "ranger", "Rborist"), from = "2017-03-01", to = "2017-03-31" )
downloads_new = data.table(downloads_new)
downloads_new = downloads_new[, sum(count), by = "package"]
downloads_new2 = cran_downloads(packages = c("randomForest", "xgboost", "randomForestSRC", "ranger", "Rborist"), from = "2018-03-01", to = "2018-03-31" )
downloads_new2 = data.table(downloads_new2)
downloads_new2 = downloads_new2[, sum(count), by = "package"]

downloads = cbind(downloads, downloads_new$V1, downloads_new2$V1, round(downloads_new2$V1/downloads_new$V1, 2))
colnames(downloads) = c("**package**", "**--march 2016**", "**--march 2017**", "**--march 2018**", "**--ratio of 2018/2017**")

kable(downloads, format = "markdown", padding = 2)
barplot(unlist(downloads_new2[,2]), names.arg = unlist(downloads[,1]), col = "blue")

downloads = cran_downloads(packages = c("h2o","ParallelForest", "bigrf"), from = "2016-03-01", to = "2016-03-31" )
downloads = data.table(downloads)
downloads = downloads[,sum(count), by = "package"]
downloads_new = cran_downloads(packages = c("h2o","ParallelForest", "bigrf"), from = "2017-03-01", to = "2017-03-31" )
downloads_new = data.table(downloads_new)
downloads_new = downloads_new[, sum(count), by = "package"]
downloads_new2 = cran_downloads(packages = c("h2o","ParallelForest", "bigrf"), from = "2018-03-01", to = "2018-03-31" )
downloads_new2 = data.table(downloads_new2)
downloads_new2 = downloads_new2[, sum(count), by = "package"]
downloads = cbind(downloads, downloads_new$V1, downloads_new2$V1, round(downloads_new2$V1/downloads_new$V1, 2))
colnames(downloads) = c("**package**", "**--march 2016**", "**--march 2017**", "**--march 2018**", "**--ratio of 2018/2017**")

kable(downloads, format = "markdown", padding = 2)

# catboost, lightgbm, tuneRanger,  remove bigrf
# partykit

downloads = cran_downloads(packages = c("rpart", "RRF", "obliqueRF", "rotationForest", 
  "rFerns", "randomUniformForest", "wsrf", "roughrf", "trimTrees", "extraTrees", "party", "partykit"  ), from = "2016-03-01", to = "2016-03-31" )
downloads = data.table(downloads)
downloads = downloads[,sum(count), by = "package"]
ordering = order(downloads$V1, decreasing = T)
downloads = downloads[ordering,]
downloads_new = cran_downloads(packages = c("rpart", "RRF", "obliqueRF", "rotationForest", 
  "rFerns", "randomUniformForest", "wsrf", "roughrf", "trimTrees", "extraTrees", "party", "partykit" ), from = "2017-03-01", to = "2017-03-31" )
downloads_new = data.table(downloads_new)
downloads_new = downloads_new[, sum(count), by = "package"]
downloads_new = downloads_new[ordering,]
downloads_new2 = cran_downloads(packages = c("rpart", "RRF", "obliqueRF", "rotationForest", 
  "rFerns", "randomUniformForest", "wsrf", "roughrf", "trimTrees", "extraTrees", "party" , "partykit" ), from = "2018-03-01", to = "2018-03-31" )
downloads_new2 = data.table(downloads_new2)
downloads_new2 = downloads_new2[, sum(count), by = "package"]
downloads_new2 = downloads_new2[ordering,]
downloads = cbind(downloads, downloads_new$V1, downloads_new2$V1, round(downloads_new2$V1/downloads_new$V1, 2))
colnames(downloads) = c("**package**", "**--march 2016**", "**--march 2017**", "**--march 2018**", "**--ratio of 2018/2017**")

kable(downloads, format = "markdown", padding = 2)
