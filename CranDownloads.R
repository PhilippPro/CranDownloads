library(cranlogs)
library(data.table)

packages = c("mlr", "caret", "radiant", "tscount", "ggplot2", "data.table", "rattle", "OOBCurve", "quantregRanger", "mlrMBO", "rBayesianOptimization", "tuneRanger", "varImp", "keras", "e1071", "kernlab", "liquidSVM")
dates = seq(as.Date("2016/7/1"), as.Date("2018/9/20"), by = "day")

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
plot(dates[28:length(dates)], downloads_all[,1], type = "l", col = "blue", ylab = "Number of downloads in the last month", xlab = "data") #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,2]/15, col = "red")
legend("topleft", c("mlr", "caret (divided by 15)"), col = c("blue", "red"), lty = 1)
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
#lines(dates[28:length(dates)], downloads_all[,"liquidSVM"], col = "orange")

plot(dates[28:length(dates)], downloads_all[,"mlrMBO"], type = "l", col = "blue", ylab = "Number of downloads in the last month", xlab = "data") #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,"rBayesianOptimization"], col = "red")

plot(dates[28:length(dates)], downloads_all[,"keras"], type = "l", col = "blue", ylab = "Number of downloads in the last month", xlab = "data") #,ylim = range(downloads_all))
#lines(dates[28:length(dates)], downloads_all[,"mxnet"], col = "red")

plot(dates[28:length(dates)], downloads_all[,"e1071"], type = "l", col = "black", ylab = "Number of downloads in the last month", xlab = "data", ylim = c(0, max(downloads_all[,"e1071"]))) #,ylim = range(downloads_all))
lines(dates[28:length(dates)], downloads_all[,"kernlab"], col = "red")
lines(dates[28:length(dates)], downloads_all[,"liquidSVM"], col = "blue")
# make some advertisement
