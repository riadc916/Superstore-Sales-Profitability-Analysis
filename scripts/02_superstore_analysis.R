library(tidyverse)
library(gt)
install.packages('gt')
install.packages('webshort2')

file.choose()
clean_ana <- read.csv("/Users/riadmac/Documents/R program/r-data-cleaning-practice/data/processed/cleaned_superstore.csv") |>
  select(-X)


summary(clean_ana)
head(clean_ana)

#what are our total sales and total profit 
clean_ana |>
  summarise(
    Total_sales=sum(sales),
    Total_profit=sum(profit)
  )
#Which product categories and sub-categories are generating the highest profit?
clean_ana |>
  group_by(product_category,product_sub_category) |>
  summarise(Total_profit=sum(profit)) |>
  arrange(desc(Total_profit))


#Are we incurring a loss (or negative profit) on any product or category?
clean_ana |>
  group_by(product_category,product_sub_category) |>
  summarise(Total_profit=sum(profit)) |>
  filter(Total_profit < 0)


#Profit and loss tables and graphs by category and sub-category
profit_table <- clean_ana |>
  group_by(product_category,product_sub_category) |>
  summarise(
    Total_sales=round(sum(sales),2),
    Total_profit=round(sum(profit),2),
    .groups = 'drop'
  ) |>
  arrange(desc(Total_profit)) 

formatted_table <- profit_table|>
  gt() |>
  tab_header(
    title = "Table 1. Sales and Profitability Overview",
    subtitle = "Performance Breakdown by Category & Sub-Category"
  ) |>
  cols_label(
    product_category="Category",
    product_sub_category="Sub-Category",
    Total_sales="Sales",
    Total_profit="Profit"
  ) |>
  tab_options(
    table.background.color = "#FFFFFF",        
    table.font.color = "#000000",             
    column_labels.font.weight = "bold",
    column_labels.background.color = "#F2F2F2",
    table_body.border.bottom.color = "#CCCCCC"
  )
print(formatted_table)
#for save this table in the result table part
gtsave(formatted_table,filename = "results/tables/profit_summary_table.png")
#for visualization
options(scipen = 999)
profit_tables <- ggplot(profit_table,
       aes(x=reorder(product_sub_category,Total_profit),
                        y=Total_profit,
                        fill=product_category))+
  geom_col()+
  coord_flip()+
  labs(
    title="Analysis of total profit and loss by sub-category",
    x="Product Sub-category",
    y="Total Profit",
    fill="product_category"
  )+
  theme_minimal()
ggsave("results/figures/profit_loss_by_subcategory.png",plot = profit_tables,width = 10,height = 6,dpi = 300)

                        
                        
#Sales table and graph by Order Priority
priority_table <- clean_ana |>
  group_by(order_priority) |>
  summarise(
    order_count=n(),
    Total_sales=round(sum(sales),2),
    .groups = 'drop'
  )|>
  arrange(desc(Total_sales))
#formatted tables
formatted_priority_table <- priority_table |>
  gt()|>
  tab_header(
    title = md("**Table 2. Sales and Order Summary by Order Priority**"),
    subtitle = "Order Distribution and Total Sales Volume Across Priority Levels"
  ) |>
  cols_label(
    order_priority="Order Priority",
    order_count="Order Count",
    Total_sales="Total Sales"
  )|>
  tab_options(
    table.background.color = "#FFFFFF",        
    table.font.color = "#000000",             
    column_labels.font.weight = "bold",
    column_labels.background.color = "#F2F2F2",
    table_body.border.bottom.color = "#CCCCCC"
  )
gtsave(formatted_priority_table,filename = "results/tables/order_priority_table.png")
#for visualization 

priority_plot <- ggplot(priority_table,
       aes(x=reorder(order_priority,Total_sales),
           y=Total_sales,
           fill = order_priority))+
  geom_col()+
  coord_flip()+
  labs(
    title = "Sales volume Analysis by Order Priority",
    x="Order Priority",
    y="Total sales",
    fill="Priority Level"
  )+
  theme_minimal()
ggsave("results/figures/sales_by_order_priority.png",plot = priority_plot,width = 10,height = 6,dpi = 300)
  
#Customer from which rigion are generating the most profit for us and what is their preferred shipping method 
rigion_ship_table <-clean_ana|>
  group_by(region,ship_mode)|>
  summarise(
    Total_Sales=round(sum(sales),2),
    Total_Profit=round(sum(profit),2),
    .groups = 'drop'
  )|>
  arrange(region,desc(Total_Profit))

formatted_rigion_ship_table <- rigion_ship_table|>
  gt()|>
  tab_header(
    title = md("**Table 3. Regional Sales and Profitability by Shipping Mode**"),
    subtitle="Performance Analysis Across Geographic Regions and Transportation Logistics"
  )|>
  cols_label(
    region="Region",
    ship_mode="Ship Mode",
    Total_Sales="Total Sales",
    Total_Profit="Total Profit"
  )|>
  tab_options(
    table.background.color = "#FFFFFF",        
    table.font.color = "#000000",             
    column_labels.font.weight = "bold",
    column_labels.background.color = "#F2F2F2",
    table_body.border.bottom.color = "#CCCCCC"
  )
gtsave(formatted_rigion_ship_table,filename = "results/tables/rigion_ship_table.png")
#formatted_rigion_ship_table visualization
options(scipen = 999)
Regional_sales_plot<- ggplot(rigion_ship_table,
       aes(x=region,
           y=Total_Sales,
           fill=ship_mode))+
  geom_col()+
  coord_flip()+
  labs(
    title = "Regional sales Breakdown by shipping mode",
    x="Region",
    y="Total Sales",
    fill="Shipping Mode"
  )+
  theme_minimal()

ggsave("results/figures/regional_sales_by_shipping_mode.png",plot =Regional_sales_plot,width = 10,height = 6,dpi = 300 )

