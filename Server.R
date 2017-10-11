library(shiny)
library(ggplot2)
library(googleVis)
library(stringr)
library(scales)
library(DT)
library(maps)
library(leaflet)
library(plotly)
library(data.table)


shinyServer(function(input, output) ({
  
  #output$corr <- renderPlot({corrplot(VGdataCor, method = 'pie', order = 'hclust')
  #})
  #output$score  <- renderPlot({ggplot(VGdata, aes_string(x=input$rate, y=input$sale)) +geom_point(
    #aes(color = Genre)) + geom_smooth() + ylim(c(0,15)) + ggtitle("Review Scores versus Unit Sales(in millions)")})
#  output$orders<- renderPlot({orders %>% 
#      ggplot(aes(x=order_hour_of_day)) + 
#      geom_histogram(stat="count",fill="red")})
  #output$avgGscore <- renderPlot({ggplot(genreAvgScore, aes(x=Genre, y=scores, fill = type, group =type)) + geom_bar(
    #stat='identity', position = 'dodge') + ggtitle('Average Genre Review Scores')})
 # output$wordc <- renderPlot({comparison.cloud(BestSellerM, colors=brewer.pal(length(levels(BestSeller$Genre)), "Paired"), scale=c(3,0.5), title.size = 1)})
  #output$ConsoleComp <- renderPlot({ggplot(bigThree, aes(x=factor(1), y=Total_Sales, fill = companyPlatform)) + geom_bar(stat = 'Identity')+ coord_polar(theta='y')+ theme(axis.title.y=element_blank(),
  #                                                                                                                                                                         axis.text.y=element_blank(),
  #                                                                                                                                                                         axis.ticks.y=element_blank(),
 #                                                                                                                                                                          axis.ticks.x=element_blank(),
  #                                                                                                                                                                         axis.text.x=element_blank())+ ggtitle('Distribution of Sales Across Regions') +ylab('Sales Distribution')})
 # output$ConsoleComp1 <- renderPlot({ggplot(bigThree, aes(x=factor(1), y=Total_Users, fill = companyPlatform)) + geom_bar(stat = 'Identity')+ coord_polar(theta='y')+ theme(axis.title.y=element_blank(),
     #                                                                                                                                                                       axis.text.y=element_blank(),
    #                                                                                                                                                                        axis.ticks.y=element_blank(),
     #                                                                                                                                                                       axis.ticks.x=element_blank(),
  #                                                                                                                                                                          axis.text.x=element_blank()) + ggtitle('Users Count Across Regions')+ylab('Number of User Reviews')})
 # output$topTwoGenre <- renderPlot({ggplot(YearTopTwoGenre, aes(x=Year_of_Release, y=total.genre.sales)) + geom_bar(stat='Identity', aes(fill=Genre))})
 # output$topTwoPlat <- renderPlot({ggplot(YearTopTwoPlat, aes(x=Year_of_Release, y=total.plat.sales)) + geom_bar(stat='Identity', position = 'stack', aes(fill=Platform))+xlab(
   # 'Year of Release') + ylab('Units Sold in Millions') + ggtitle('Top Two Console Games Sold')})
  output$orderdow <-renderPlot({
    orders %>%
      ggplot(aes(x=order_dow)) + 
      geom_histogram(stat="count",fill="blue")
    
  })
  output$order_d_m <-renderPlot({
    orders %>% 
      ggplot(aes(x=days_since_prior_order)) + 
      geom_histogram(stat="count",fill="red")
    
  })
  output$order_h_d <-renderPlot({
    x <- orders 
    bins <- input$bins
    orders %>% 
      ggplot(aes(x=order_hour_of_day)) + 
      geom_histogram(stat="count",fill="blue")
    
  })
  output$heat_map <-renderPlotly({
    plot_ly(x = orders_heat$order_dow, y = orders_heat$order_hour_of_day,z = orders_heat$Order_number, type = "heatmap")%>%
      layout(xaxis=list(type='category',title='Day of Week'),yaxis=list(title='Hour of Day'))
  })
  output$topcategory <-renderPlot({
    x <- orders 
    bins <- input$bins
    bestsell %>% 
      ggplot(aes(x=reorder(product_name,-count), y=count))+
      geom_bar(stat="identity",fill="red")+
      theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())
    
  })
  output$aveperson <-renderPlot({
    
    order_products__train %>% 
      group_by(order_id) %>% 
      summarize(n_items = last(add_to_cart_order)) %>%filter(n_items<=input$bins) %>%
      ggplot(aes(x=n_items))+
      geom_histogram(stat="count",fill="red") + 
      geom_rug()+
      coord_cartesian(xlim=c(0,80))
    
  })
  #output$radar <-renderPlot({ggradar(scaled_bigThree) +  ggtitle('Regional Performance of Consoles')})
  output$table <-renderDataTable({
    datatable(orders, rownames=FALSE) %>% 
      formatStyle(input$selected,  
                  background="skyblue", fontWeight='bold')})
  
})
)