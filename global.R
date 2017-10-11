library(tidyr)
library(dplyr)
library(ggplot2)
library(scales)
library(shinydashboard)
library(RColorBrewer)
library(DT)
library(data.table)
library(plotly)




aisles = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/aisles.csv")
departments = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/departments.csv")
order_products__prior = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/order_products__prior.csv")
order_products__train = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/order_products__train.csv")
orders = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/orders.csv")
products = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/products.csv")
sample_submission = fread("/Users/joshualee/Downloads/bootcamp_trail/project shiny/sample_submission.csv")
orders <- orders %>% mutate(order_hour_of_day = as.numeric(order_hour_of_day), eval_set = as.factor(eval_set))
products <- products %>% mutate(product_name = as.factor(product_name))
aisles <- aisles %>% mutate(aisle = as.factor(aisle))
departments <- departments %>% mutate(department = as.factor(department))

orders %>% 
  ggplot(aes(x=order_hour_of_day)) + 
  geom_histogram(stat="count",fill="black")
orders %>% 
  ggplot(aes(x=order_dow)) + 
  geom_histogram(stat="count",fill="blue")
orders %>% 
  ggplot(aes(x=days_since_prior_order)) + 
  geom_histogram(stat="count",fill="red")

#How many items do people buy?
order_products__train %>% 
  group_by(order_id) %>% 
  summarize(n_items = last(add_to_cart_order)) %>%
  ggplot(aes(x=n_items))+
  geom_histogram(stat="count",fill="red") + 
  geom_rug()+
  coord_cartesian(xlim=c(0,80))
#best seller
bestsell <- order_products__train %>% 
  group_by(product_id) %>% 
  summarize(count = n()) %>% 
  top_n(10, wt = count) %>%
  left_join(select(products,product_id,product_name),by="product_id") %>%
  arrange(desc(count)) 

bestsell %>% 
  ggplot(aes(x=reorder(product_name,-count), y=count))+
  geom_bar(stat="identity",fill="red")+
  theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())


top10orders=fread("/Users/joshualee/Downloads/bootcamp_trail/top10orders.csv")
orders_heat= top10orders %>% group_by(order_dow,order_hour_of_day)%>%summarise(Order_number=n())
plot_ly(x = orders_heat$order_dow, y = orders_heat$order_hour_of_day,z = orders_heat$Order_number, type = "heatmap")
#order__dow= orderdow %>% group_by(order_dow,order_hour_of_day)%>%count(order_number)

#order__dow %>% ggplot(aes(x=order_dow,y=order_hour_of_day))+
 # geom_point()
#plot_ly(x = order__dow$order_dow, y = order__dow$order_hour_of_day,z = order__dow$n, type = "heatmap")
#order__dow %>%
 # dplyr::count(order__dow$n) %>%
#  plot_ly(x = ~order__dow$order_dow) %>% 
 # add_bars()
orders_heat= orders %>% group_by(order_dow,order_hour_of_day)%>%summarise(Order_number=n())
plot_ly(x = orders_heat$order_dow, y = orders_heat$order_hour_of_day,z = orders_heat$Order_number, type = "heatmap")

#plot_ly(x = order__dow$order_dow, y = order__dow$n)