
# === Start ===
# 主程式 AI-圖檔去背功能應用 (global)
# 維護者: VIncent Chang
# 更新日期: 2021-03-14
# === End ===

# VIncent Chang


#### ====== 1.Loading packages ====== ####

library(shiny)
library(httr)
library(png)
library(jpeg)
library(shinyjs)
library(base64enc)
library(shinyWidgets)
library(magrittr)
library(mime)
library(curl)
library(base64enc)
library(shinycssloaders) # Loading

#### ====== END ====== ####




#### ====== 2.Loading FN ====== ####


# 5.tabsetPanel fn
tabsetPanel_fn <- function(tabPanel_1 , Value_1 , tabPanel_2 , Value_2){

  tabsetPanel_Output <- tabsetPanel(

        # tabPanel.1
         tabPanel(HTML(sprintf("<i class='glyphicon glyphicon-picture' style='font-size:16px'></i> %s",Value_1)) ,value = Value_1,
                 tags$style(HTML(sprintf(".tabbable > .nav > li > a[data-value= '%s' ] {background-color:#ffffff; color:#003359; font-weight:bold}
                                 .tabbable > .nav > li[class=active] > a[data-value= '%s'] {background-color:#DFFFDF; color:#003359; font-weight:bold}"
                                 ,Value_1,Value_1)
                 )),tabPanel_1
           ),
         # tabPanel.2
         tabPanel(HTML(sprintf("<i class='glyphicon glyphicon-list' style='font-size:16px'></i> %s ",Value_2)) , value = Value_2,
                 tags$style(HTML(sprintf(".tabbable > .nav > li > a[data-value= '%s' ] {background-color:#ffffff; color:#003359; font-weight:bold}
                                 .tabbable > .nav > li[class=active] > a[data-value= '%s'] {background-color:#DFFFDF; color:#003359; font-weight:bold}"
                                 ,Value_2,Value_2)
                )),tabPanel_2
           )
    ) # tabsetPanel close

  return(tabsetPanel_Output)

}



#### ====== END ====== ####





