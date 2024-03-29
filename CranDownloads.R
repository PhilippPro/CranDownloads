library(cranlogs)
library(data.table)

packages = c("mlr", "mlr3", "caret", "radiant", "tscount", "ggplot2", "data.table", "rattle", "OOBCurve", "quantregRanger", "mlrMBO", "rBayesianOptimization", "tuneRanger", "varImp", "measures", "keras", 
  "randomForest", "xgboost", "randomForestSRC", "ranger", "Rborist", "e1071", "kernlab", "liquidSVM", "kknn", "RWeka", "ordinalForest", "bapred", "diversityForest", "blockForest")
dates = seq(as.Date("2016/7/1"), as.Date("2022/10/1"), by = "day")

downloads_all = matrix(NA, length(dates)-27, length(packages))

for(i in 28:length(dates)) { # moving window of 28 days (to delete the weekend peaks)
  print(i)
  downloads = cran_downloads(packages = packages, from = dates[i-27], to = dates[i])
  downloads = data.table(downloads)
  downloads = downloads[, sum(count), by = "package"]
  downloads_all[as.numeric(i-27),] = downloads$V1
}

colnames(downloads_all) = packages

pdf("cran_downloads.pdf")
par(mfrow = c(1,1))
plot(dates[28:length(dates)], downloads_all[,1], type = "l", ylim = c(0,70000), col = "blue", ylab = "Number of downloads in the last month", xlab = "data") #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,2], col = "green")
lines(dates[28:length(dates)], downloads_all[,3]/5, col = "red")
legend("topleft", c("mlr", "caret (divided by 5)"), col = c("blue", "red"), lty = 1)
abline(v = as.Date("2016-08-03"))
abline(v = as.Date("2016-08-08"))
abline(v = as.Date("2016-08-11"))
abline(v = as.Date("2016-08-16"))
abline(v = as.Date("2016-10-19"))
abline(v = as.Date("2017-02-07")) # CRAN release of version 2.10
abline(v = as.Date("2017-03-15")) # 2.11
abline(v = as.Date("2018-03-29")) # 2.12
abline(v = as.Date("2018-03-11")) # 2.12.1
abline(v = as.Date("2018-08-28")) # 2.13
dev.off()

plot(dates[28:length(dates)], downloads_all[,"OOBCurve"], type = "l", col = "blue", ylab = "Number of downloads in the last month", xlab = "data", ylim =  c(0,max(downloads_all[, "varImp"])))
lines(dates[28:length(dates)], downloads_all[,"quantregRanger"], col = "red")
lines(dates[28:length(dates)], downloads_all[,"tscount"], col = "violet")
lines(dates[28:length(dates)], downloads_all[,"tuneRanger"], col = "green")
lines(dates[28:length(dates)], downloads_all[,"varImp"], col = "black")
lines(dates[28:length(dates)], downloads_all[,"measures"], col = "orange")
legend("topleft", c("OOBCurve", "quantregRanger", "tscount", "tuneRanger", "varImp", "measures"),lty =1, col = c("blue", "red", "violet", "green", "black", "orange"))
#lines(dates[28:length(dates)], downloads_all[,"liquidSVM"], col = "orange")

plot(dates[28:length(dates)], downloads_all[,"mlrMBO"], type = "l", col = "blue", ylab = "Number of downloads in the last month", xlab = "data") #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,"rBayesianOptimization"], col = "red")

plot(dates[28:length(dates)], downloads_all[,"keras"], type = "l", col = "blue", ylab = "Number of downloads in the last month", xlab = "data") #,ylim = range(downloads_all))
#lines(dates[28:length(dates)], downloads_all[,"mxnet"], col = "red")

plot(dates[28:length(dates)], downloads_all[,"randomForest"], type = "l", col = "black", ylab = "Number of downloads in the last month", xlab = "data", ylim = c(0, max(downloads_all[,"randomForest"]))) #,ylim = range(downloads_all))
#plot(dates[28:length(dates)], downloads_all[,"xgboost"], col = "blue", type = "l", ylim = c(0, max(downloads_all[,"xgboost"])))
lines(dates[28:length(dates)], downloads_all[,"ranger"], col = "red")
lines(dates[28:length(dates)], downloads_all[,"randomForestSRC"], col = "orange")
lines(dates[28:length(dates)], downloads_all[,"Rborist"], col = "violet")
lines(dates[28:length(dates)], downloads_all[,"xgboost"], col = "blue")
legend("topleft", c("randomForest", "ranger", "randomForestSRC", "Rborist", "xgboost"),lty =1, col = c("black", "red", "orange", "violet", "blue"))


plot(dates[28:length(dates)], downloads_all[,"e1071"], type = "l", col = "black", ylab = "Number of downloads in the last month", xlab = "data", ylim = c(0, max(downloads_all[,"e1071"]))) #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,"kernlab"], col = "red")
lines(dates[28:length(dates)], downloads_all[,"liquidSVM"], col = "blue")
# make some advertisement
plot(dates[28:length(dates)], downloads_all[,"liquidSVM"], type = "l", col = "black", ylab = "Number of downloads in the last month", xlab = "data", ylim = c(0, max(downloads_all[,"liquidSVM"]))) #,ylim = range(downloads_all))

plot(dates[28:length(dates)], downloads_all[,"kknn"], type = "l", col = "black", ylab = "Number of downloads in the last month", xlab = "data", ylim = c(0, max(downloads_all[,"RWeka"]))) #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,"RWeka"], col = "red")

# Roman
plot(dates[28:length(dates)], downloads_all[,"ordinalForest"], type = "l", col = "black", ylab = "Number of downloads in the last month", xlab = "data", ylim = c(0, max(downloads_all[,"ordinalForest"]))) #,ylim = range(downloads_all))
#plot(dates[28:length(dates)], downloads_all[,"xgboost"], col = "blue", type = "l", ylim = c(0, max(downloads_all[,"xgboost"])))
lines(dates[28:length(dates)], downloads_all[,"bapred"], col = "red")
lines(dates[28:length(dates)], downloads_all[,"diversityForest"], col = "orange")
lines(dates[28:length(dates)], downloads_all[,"blockForest"], col = "violet")
legend("topleft", c("ordinalForest", "bapred", "diversityForest", "blockForest"),lty =1, col = c("black", "red", "orange", "violet"))

