
# === Start ===
# 主程式 AI-圖檔去背功能應用 (Server)
# 維護者: VIncent Chang
# 更新日期: 2021-03-14
# === End ===

# VIncent Chang

server <- shinyServer(function(input, output) {


    #  範例說明： ==================================================

        # Note：去背景相關資訊
        observeEvent(input$Submit,{
          showModal(
            modalDialog(
                    　  easyClose = T # 按esc直接關閉
                      , fade = T # animation
                      , footer = modalButton("關閉")
                    　, size = c("l")

              　　     , div(p("AI-模型相關資訊"),style="text-align: center;color: #000000; font-weight:bold ; font-size:30px")
      #                  , div(p("廣告樣本："),style="color: #000000; font-weight:bold ; font-size:24px")
      #                  , div(p("1、排除安裝數等於「0」。"),style="color: #669933; font-weight:bold ; font-size:14px")
      #                  , div(p("2、排除impression小於「1,000」的廣告。"),style="color: #669933; font-weight:bold ; font-size:14px")
      #         　　     , div(p("3、排除次日ROI = 「-100%」的廣告。"),style="color: #669933; font-weight:bold ; font-size:14px")
      # 　　             , div(p("4、排除14日ROI = 「-100%」的廣告。"),style="color: #669933; font-weight:bold ; font-size:14px")
      #                  , div(p("5、排除14日ROI大於「0%」的廣告。"),style="color: #669933; font-weight:bold ; font-size:14px")
      #                  , div(p("註解：詳細廣告樣本篩選流程及統計方法，請參考第一次簡報"),style="color: #336699; font-weight:bold ; font-size:14px")
      #                  # 模型特徵值
      #                  , div(p("模型選取特徵值："),style="color: #000000; font-weight:bold ; font-size:24px")
      #                  , div(p("1、投放方式、系統、性別、年齡、地區。"),style="color: #990033; font-weight:bold ; font-size:14px")
      #                  , div(p("2、安裝、CR、CPI。"),style="color: #990033; font-weight:bold ; font-size:14px")
      #                  , div(p("3、14日留存、14日LTV。"),style="color: #990033; font-weight:bold ; font-size:14px")
      #                  , div(p("4、投放天數、Diff_1-7、Ratio_1-7、Ratio_7-14。"),style="color: #990033; font-weight:bold ; font-size:14px")
      #                  , div(p("預測變數(Y)：廣告60日ROI是否能回本 (是：1、否：0)。"),style="color: #996699; font-weight:bold ; font-size:14px")
      #                  , div(p("註解：模型特徵值挑選準則，請參考第一次簡報"),style="color: #336699; font-weight:bold ; font-size:14px")
      #                  # 訓練資料樣本、測試資料樣本
      #                  , div(p("建模樣本資訊："),style="color: #000000; font-weight:bold ; font-size:24px")
      #                  , div(p("1、Data：1002筆樣本《 回本：不回本 = 19.2% (192)：80.8% (810) 》。"),style="color: #CC6600; font-weight:bold ; font-size:14px")
      #                  , div(p("2、TrainingData：701筆樣本《 回本：不回本 = 19.2% (134)：80.8% (567) 》。"),style="color: #CC6600; font-weight:bold ; font-size:14px")
      #                  , div(p("3、TestData：301筆樣本《 回本：不回本 = 19.2% (58)：80.8% (243) 》。"),style="color: #CC6600; font-weight:bold ; font-size:14px")
                      , div('資訊尚待補充.....', style="height:400px ; font-size:50px ; padding: 150px ; background-color:#C4E1E1 ; color:#0066CC ; font-weight:bold;text-align:center;")
                      # , div(p("備註：資料來源："),style="color: #000000; font-weight:bold ; font-size:24px")
              , style="background-color: #ffffff")
            )　
        },ignoreInit = T)

        # 1、Selection (選擇圖片範例)：
        output$pickerInput <- renderUI({
           mainPanel(
                    pickerInput(
                        inputId = "Image_select",
                        label = p("選擇圖片範例：", style = "font-size:24px; color: #336666"),
                        options = list(style = "btn-primary"),
                        selected = 'Cat_3',
                        choices = list(
                                      '動物'  = c("兔子" = 'Rabbit_bro', "貓咪" = 'Cat_3','灰鸚' = 'Grey_Parrot'),
                                      '甜點'  = c("草莓蛋糕" = 'Cake',"咖啡" = "Coffee") ,
                                      '人物 + 飛機'  = c("Vincent Chang" = 'Vincent_aircraft') ,
                                      '人物'  = c("Cherry Chen" = "Cherry" ,"Vincent Chang" = "Vincent_zoo", "Lebron James" = 'lebron-james' , "Stephen curry" = 'Stephen_curry', "Ray Allen" = 'Ray_Allen') )
                    ), hr()
           )
        })
        # 2、.jpg (原圖) ：
        output$image_EX <- renderUI({
          filename_image <- input$Image_select %>% paste0('Image/',.,'.jpg')
          mainPanel(width = 5,
                    div(
                        div(p("去背前"), style = "width: 100% ; font-size:30px  ; font-weight: bold  ; color: #000000; background-color: #FFFFFF ; text-align: left;"),
                        img(src= filename_image , style = "margin-left: 10%; ; width:80% ; height:90% ;") , style = "margin :4% 0px 0px 1%; height:100% ; width: 90% ; background-color: #E8E8D0;")
                    )
        })

        # 2-1、arrow graph：
        output$arrow_graph <- renderUI({
          mainPanel(width = 2,
                    div(
                        img(src='arry.png', style = "background-color: #FFFFFF; width:70% ; height:a0% ;")
                      , style = "margin :60% 0px 0px 5%; height:100% ; width: 90% ; background-color: #FFFFFF;")
            )
          })
        # 3、.png (去背景)：
        output$image_EX_Removebg <- renderUI({
          filename_image <- input$Image_select %>% paste0('Image/',.,'.png')
          mainPanel(width = 5,
                    div(
                        div(p("去背後"), style = "width: 100% ; font-size:30px  ; font-weight: bold  ; color: #000000; background-color: #FFFFFF ; text-align: left;"),
                        img(src= filename_image,style = "margin-left: 10%; ; width:80% ; height:90% ; ") , style = "margin :4% 0px 0px 1% ; height:100% ; width: 90% ; background-color: #D1E9E9;")
                    )
        })




    #  實際操作： ==================================================

      # 1.原圖片；
          base64 <- reactive({
            inFile <- input[["upload"]]
            if(!is.null(inFile)){
               base64enc::dataURI(file = inFile$datapath, mime = "image/png")
            }
          })
        # UI_output (Original)
          output$image <- renderUI({
            if(!is.null(base64())){
                # div(p("Original"), style = "width: 100% ; font-size:30px  ; font-weight: bold  ; color: #000000; background-color: #FFFFFF ; text-align: left;"),
                img <- img(src= base64() , style = "margin :0% 0px 0px 5% ; height:100% ; width: 100% ;")
                return(img)
            }
          })
        # Original Image format (EX：480 x 480)
          output$image_info <- renderText({
              if(!is.null(base64())){
                  # 1.jpeg
                  if(input$upload$type == "image/jpeg"){
                      img = jpeg::readJPEG(input$upload$datapath)
                      dim <- img %>% dim()
                      height <- dim[1]
                      width  <- dim[2]
                      dim <- paste0('尺寸大小：', height , ' x ', width)
                      return(dim)
                  # 2.png
                  } else if(input$upload$type == "image/png"){
                      img = png::readPNG(input$upload$datapath)
                      dim <- img %>% dim()
                      height <- dim[1]
                      width  <- dim[2]
                      dim <- paste0('尺寸大小：', height , ' x ', width)
                      return(dim)
                  }
              } else{
                dim <- "無圖片資訊"
                print(dim %>% as.character %>% str())
                return(dim)
                }
          })


      # 2.AI-去除背景(removebg-api應用)；
          Removebg_img <- eventReactive(input$Search,{

                Removebg_img_file <- input$upload$datapath
                Removebg_img_file <- gsub("\\\\", "/", Removebg_img_file )
                print(Removebg_img_file)
                response = httr::POST(
                                  url = 'https://api.remove.bg/v1.0/removebg',
                                  body = list("image_file"= curl::form_file(Removebg_img_file, type = mime::guess_type(Removebg_img_file))),
                                  add_headers(c('X-Api-Key'='tpTaTPpLkAVrcaRyXQvKgzAd',
                                                'Content-Type'='multipart/form-data'
                                  )),
                                  encode = "multipart"
                                )
                # print(response)
                img = httr::content(response, as = "parsed" ,type = "image/png")

                # img = plot(as.raster(img))

                # Generate the PNG
                # Removebg_img <- png(img, width = 400, height = 300)
                # print(Removebg_img)
                # png
                # file_name_output <- paste0("remove_bg",".png")
                # Removebg_img <- png::readPNG(img)
                # print( Removebg_img )
                Removebg_img <- img
                # Removebg_img <- Removebg_img_file
                return(Removebg_img)

          })

          # Removebg_img format (EX：456 x 456)
            output$Removebg_img_info <- renderText({
                if(!is.null(Removebg_img() )){
                        img = Removebg_img()
                        dim <- img %>% dim()
                        height <- dim[1]
                        width  <- dim[2]
                        dim <- paste0('尺寸大小：', height , ' x ', width)
                        return(dim)
                } else{
                  dim <- "無圖片資訊"
                  return(dim)
                  }
            })

          # renderPlot
            output$Removebg_plot <- renderPlot({
                                     # https://bookdown.org/ndphillips/YaRrr/plot-margins.html
                                     par(mar = c(0, 0, 0, 0))
                                     img <- plot(as.raster(Removebg_img() ))
                                     return(img)
                                     })
          # downloadHandler ==========
            output$DownloadData <- downloadHandler(
                                  filename = function() {
                                    paste("Copyright@Vincent_Chang_", Sys.Date(), ".png", sep="")
                                  },
                                  content = function(file) {
                                  # png
                                  png::writePNG(Removebg_img(),file)
                                  }
              )
            #### == END == ####

          # UI_output (Removebg)
            output$Removebg <- renderUI({
                        fluidRow(column(12
                                        , div(
                                             div("Removed Background", downloadButton(outputId = "DownloadData",label = "Download Image", style="color: #6C6C6C; background-color: #B3D9D9; border-color: #2e6da4; font-weight: bold ")
                                                         , style = "width: 100% ; font-size:30px  ; font-weight: bold  ; color: #000000;background-color: #FFFFFF ; text-align: left;")
                                              , style = "margin :0% 0px 0px 0% ; height:100% ; width: 100% ; background-color: #FFFCEC;")
                                       , br()
                                       , column(12, withSpinner(plotOutput("Removebg_plot", width = "70%")) , textOutput("Removebg_img_info",inline = T) )
                                   ) # column close
                          ) # fluidRow close
            })



    # 上傳圖片再顯示尺寸：
      observeEvent(input$upload$datapath, {
          shinyjs::show("id_image_info")
      })
    # 按下查詢按鈕顯示 buttom
      observeEvent(input$Search, {
          shinyjs::show("Removebg_Output")
      })


  # Hide the loading message when the rest of the server function has executed
    library(shinyjs)
    shinyjs::hide(id = "loading-content", anim = TRUE, animType = 'fade' , time = 5.0 , selector = NULL )

})


