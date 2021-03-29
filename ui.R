
# === Start ===
# 主程式 AI-圖檔去背功能應用 (ui)
# 維護者: VIncent Chang
# 更新日期: 2021-03-14
# === End ===

# VIncent Chang


# https://stackoverflow.com/questions/39580060/r-shiny-how-to-display-a-pdf-file-generated-in-downloadhandler


# loading
img_loading_small <- 'https://daattali.com/shiny/ddpcr/_w_2eb8ab369268f7dcff09c84f099520b620a2bc028bc4bb81/ajax-loader-bar.gif?tdsourcetag=s_pctim_aiomsg' # Loading Logo
img_loading_Page <- 'https://www.zsg.000111.com.tw/images/loading.gif'

img_loading_Infinity_1 <- 'Loading/Infinity_1.gif'
img_loading_Infinity_2 <- 'Loading/Infinity_2.gif'
img_loading_Infinity_3 <- 'Loading/Infinity_3.gif'
img_loading_Infinity_4 <- 'Loading/Infinity_4.gif'


ui <- shinyUI(
      tagList(
        # navbarPage-title(color)
        tags$style(type = 'text/css','.navbar-default .navbar-brand {color:#FFFFFF ; background-color:#3399CC ; font-size:16px ; font-weight:bold;}'),
        tags$style(HTML(".navbar.navbar-default.navbar-static-top{color:#FFFFFF ; background-color:#3399CC ; font-size:16px}; font-weight:bold;")), # background-color：主題條碼顏色
        # Loading message
        useShinyjs(),
        div(id = "loading-content", "Loading" , img(src=img_loading_small) , div( img(src=img_loading_Page) )
            , style="font-size:32px ; float:left
            ; position: absolute ; background: #000000 ;color: #FFFFFF ; padding: 15% 0 0 0
            ; opacity: 1.0; z-index: 10000 ; top:0%; left:0% ; right:0% ; width: 100%; height: 400%
            ; text-align: center; font-weight:bold"),

    navbarPage(inverse = F
              , id='tabs'
              # , header = tags$head(includeCSS("www/styles.css"))
              # , footer = p("Wellcome to my web dashboard", style = "background-color:#F0F0F0;color:#000000;font-size:24px;text-align: center;")
              , title = div(tags$a(img(src='removebg_image.png', height = 35 , width= 35) , href= "https://vincent-chang.shinyapps.io/02-Shinyio_AI_Removebg/" , target="_self")
                          , style = "position: relative; top: -5px;",'AI-圖片去背功能應用') # Navigation bar
              , windowTitle  = 'AI-圖檔去背功能應用' # title for browser tab
              , collapsible = T #tab panels collapse into menu in small screens
              , selected = "AI_removebg"
              , fluid = T # TRUE to use a fluid layout. FALSE to use a fixed layout.
      ,
            # 1.範例說明 ==================================================
              tabPanel(HTML("<i class='glyphicon glyphicon-book' style='font-size:16px'></i> 範例說明"),value="Description",
                       tags$style(HTML(".nav > li > a[data-value='Description'] {background-color:#3399CC;color:#FFFFFF;font-size:16px; font-weight:bold;}
                                      .navbar-default .navbar-nav > .active > a[data-value='Description'] {background:#336699;color:#FFFFFF;font-size:16px; font-weight:bold;}
                                      .nav a:hover[data-value='Description'] {background-color: #336699 !important; color:#FCFCFC!important;  font-weight:bold;}"
                                       # 1.background-color:當游標是在第一個分頁時，其他分頁的背景顏色。
                                       # 2.background：背景顏色、color：字體顏色
                                       # 3.background-color：游標移過去顯示的背景顏色、color：字體顏色 (註：後面接!important，顏色才能覆蓋)
                       )),
                    # 範例說明：
                      fluidRow(
                              # 去背景相關資訊
                              mainPanel(actionButton("Submit","去除背景相關資訊", icon = icon("book",lib = "glyphicon"), style="color:#000000 ; background-color: #D0D0D0 ; font-size:14px ; font-weight:bold ")),br(),br(),br(),
                              uiOutput("pickerInput"),
                              uiOutput("image_EX"),
                              uiOutput("arrow_graph"),
                              uiOutput("image_EX_Removebg")),
                      hr() # 我是分隔線
                ),
            # 2.AI 去背影      ==================================================
            # 3.主頁面(超連結) ==================================================
               tabPanel(HTML("<i class='glyphicon glyphicon-picture' style='style='background-color:#3399CC;color:#FFFFFF;font-size:16px' ></i> Remove_bg
                             </a><li><a href='https://vincent-chang.shinyapps.io/01-Shinyio_home_page/' target='_self' data-value='AI_removebg' style='background-color:#3399CC;color:#FFFFFF; font-size:16px'><i class='glyphicon glyphicon-home' style='background-color:#3399CC;color:#FFFFFF; font-size:16px'></i> 主頁面 ")
                        , value="AI_removebg",
                       # HTML-tags
                       tags$style(HTML(".nav > li > a[data-value='AI_removebg'] {background-color:#3399CC;color:#FFFFFF;font-size:16px; font-weight:bold;}
                                      .navbar-default .navbar-nav > .active > a[data-value='AI_removebg'] {background:#336699;color:#FFFFFF;font-size:16px; font-weight:bold;}
                                      .nav a:hover[data-value='AI_removebg'] {background-color: #336699 !important; color:#FCFCFC!important;  font-weight:bold;}"
                       )),
                     # 1、操作介面：
                      fluidRow(column(8,
                                        # Title (div - > CSS)
                                        div("實際應用：", style = "width: 40% ;padding: 5px ; line-height: 1.6 ; font-size:20px ; font-weight: bold ; color: #f5f5f5; background-color: #6C6C6C") ,
                                        hr(), # 我是分隔線
                                        # 1.fileInput (image)
                                        sidebarPanel(width = 4,
                                                      div(shiny::icon('photo-video'),"圖片背景消除"
                                                          , style = "width: 100% ; font-size:24px  ; font-weight: bold  ; color: #008B8B; background-color: #F0F0F0 ; text-align: center;"),
                                                      # 2.fileInput (上傳.jpg/.png)
                                                      fileInput(inputId = "upload"
                                                              , label = ""
                                                              , buttonLabel = div(id = 'Click_button' , shiny::icon('images'),"上傳圖片....", style = "width: 30% ;margin-left: 10px; color:#005AB5; font-weight: bold")
                                                              , placeholder = "請上傳.jpg / .png"
                                                              , accept = c('image/png', 'image/jpeg','image/jpg') )
                                                        ),
                                       column(3,withSpinner(uiOutput("image"))),
                                       shinyjs::hidden(column(2,id = "id_image_info", textOutput("image_info",inline = T) ) )
                                    ) # column close
                        ) # fluidRow close
                      , br(),br(),
                      fluidRow(column(12,
                                        # 3.downloadButton
                                          actionButton("Search", label = "去除背景" , icon = icon("send",lib = "glyphicon")
                                            , style="margin-left: 12px; font-size:16px ;color: #FCFCFC; background-color: #930000;  font-weight:bold ;")
                        )),
                      hr(), # 我是分隔線
                     # 2、去背結果：
                      fluidRow(column(12,
                                     shinyjs::useShinyjs(),  # Include shinyjs
                                     shinyjs::hidden(column(5,id = "Removebg_Output",  uiOutput("Removebg") ))
                      )),
                      br(),br(),br(),br(),hr()
                )

      ) # navbarPage close

        # ==== Footer ====
        # Copyright warning 020 by Shubhram Pandey. Proudly created with Wix.com
        , tags$footer(column(3, div(shiny::icon('registered') , paste0("Copyright 2016 ~ 2021 @ Vincent Chang")) ),
                      column(6),
                      column(3,div(shiny::icon('database') , paste0("Data last modified at：",Sys.time()+60*60*8) ) ),
                      # column(1,tags$a(href='https://vincent-chang.shinyapps.io/20210119_Shinyio_Test_4/', p("Data Analysis Department", style = "color: #f5f5f5; text-decoration: none"), target="_blank" )),
                      style = "
                             position:fixed;
                             text-align:left;
                             left: 0;
                             bottom:0;
                             width:100%;
                             z-index:1000;
                             height:25px; /* Height of the footer */
                             color: #f5f5f5;
                             padding: 5px;
                             font-weight: bold;
                             background-color: #6C6C6C"
            )
        # ==== End ====

        ) # tagList close
  ) # shinyUI close


