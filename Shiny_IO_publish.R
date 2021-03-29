

library(shiny)
library(rsconnect)
runApp('C:/Users/pc072/Desktop/Vincent/Data_Analysis/Shiny_UI/02-Shinyio_AI_Removebg')


rsconnect::setAccountInfo(name='vincent-chang', token='B775EC4D2DEA80F62ED2F7756C9BC189', secret='xCKtpZvHwHrPbFTwU8pVfx6IHOGo0QHT+mzRDIyL')


tmp.enc <- options()$encoding
options(encoding = "UTF-8")
deployApp(appDir = 'C:/Users/pc072/Desktop/Vincent/Data_Analysis/Shiny_UI/02-Shinyio_AI_Removebg',account = 'vincent-chang')
options(encoding = tmp.enc)

tmp.enc <- "native.enc"




