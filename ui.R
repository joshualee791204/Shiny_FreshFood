
library(shinydashboard)

shinyUI(dashboardPage(
  
  dashboardHeader(title = 'Instacart'),
  
  dashboardSidebar(
    sidebarUserPanel("Joshua Lee"),
    sidebarMenu(
      #menuItem("Intro", tabName = "markdown"),
      #menuItem("Correlation Matrix", tabName = "corr"),
      #menuItem("Genre Data Visualization", tabName = "Genre"),
      #menuItem("Best Seller Words by Genre", tabName = 'wordc'),
      menuItem('Fresh Food Delivery' , tabName = 'instscart'),
      menuItem("Order", tabName = 'order'),
      #menuItem("Orderdow", tabName = "orderdow"),
      #menuItem("Order Day of Month",tabName = 'order_d_m'),
      #menuItem("Order Hour of Day", tabName = "order_h_d"),
      menuItem("HeatMap", tabName = "heat_map"),
      menuItem("Top Category", tabName = "topcategory"),
      #menuItem("Orders", tabName = "orders"),
      menuItem("Average Product Purchased per person", tabName = "aveperson"),
      menuItem("Data", tabName = "data", icon = icon("database"))
      
    )
  ),
  
  dashboardBody(
    tabItems(
      #tabItem(tabName = "orderdow", fluidRow(box(title = "Order Number of Week", status = "primary",plotOutput('orderdow')),
      #                                       box(title ="Inputs",status ="warning",sliderInput("bins","Slider input:",0,6,1)))),
      #tabItem(tabName = "order_d_m", fluidRow(box(title = "Order Day of Month", status = "primary",plotOutput('order_d_m')),
      #                                       box(title ="Inputs",status ="warning",sliderInput("bins","Slider input:",0,30,1)))),
      #tabItem(tabName = "order_h_d", fluidRow(box(title = "Order Hour of Day", status = "primary",plotOutput('order_h_d')),
      #                                       box(title ="Inputs",status ="warning",sliderInput("bins","Slider input:",0,6,1)))),
      tabItem(tabName = "instscart", h1(img(src="instacart.jpg", height = 500))),
      tabItem(tabName = "heat_map", fluidRow(box(width =12,title = "Heatmap", status = "primary",plotlyOutput('heat_map')))),
      tabItem(tabName = "topcategory", fluidRow(box(width =12,title = "Top 10 Popular Products", status = "primary",plotOutput('topcategory')))),
      tabItem(tabName = "aveperson", fluidRow(box(width =10,title = "Average Number of Items do People Buy", status = "primary",plotOutput('aveperson')),
                                             box(title ="Inputs",status ="warning",sliderInput("bins","Slider input:",0,80,5)))),
      tabItem(tabName = "data","Data Base", fluidRow(box(width=12, DT::dataTableOutput("table")))),
      tabItem(tabName = "order", fluidRow(box(title = "Order Number of Week", status = "primary",plotOutput('orderdow')),
                                          box(title = "Order Hour of Day", status = "primary",plotOutput('order_h_d')),
                                          box(title = "Order Day of Month", status = "primary",plotOutput('order_d_m')))),
      
      tabItem(tabName = "orders", fluidRow(box(width =12, title="Regions",
                                               selectInput(inputId = "reg1",
                                                           label = "Region 1",
                                                           choices = list("North America" = 'NA_Sales',
                                                                          "Europe" = 'EU_Sales',
                                                                          "Japan" = 'JP_Sales',
                                                                          "other" = "Other_Sales",
                                                                          "Global" = "Global_Sales")),
                                               selectInput(inputId = "reg2",
                                                           label = "Region 2",
                                                           choices = list("North America" = 'NA_Sales',
                                                                          "Europe" = 'EU_Sales',
                                                                          "Japan" = 'JP_Sales',
                                                                          "other" = "Other_Sales",
                                                                          "Global" = "Global_Sales")))),
              h1(plotOutput('orders'))) 
              )
              ))
      )
