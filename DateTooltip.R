library(ggvis)
library(shiny)
dat<- matrix(rnorm(100),ncol=5)
dat<- as.data.frame(dat)
dat$Date=seq(as.Date("2018-01-01"), as.Date("2018-01-20"),by='days')
dat$id= 1:dim(dat)[1]


myhover<- function(x){
  if(is.null(x)) return(NULL)
  row<- dat[dat$id==x$id,]
  paste('Date: ',as.Date(x$Date/86400000,origin='1970-01-01'),br(),'Data:',format(x$V1))
  #paste0(names(row), ": ", format(row), collapse = "<br />")
  paste0(row$id,row$V1)
}
dat %>% ggvis(~Date,~V1) %>% layer_points() %>% add_tooltip(myhover,'hover')



