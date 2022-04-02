library(tidyverse)

content <- read_html("http://www.reptile-database.org/db-info/SpeciesStat.html")

tables <- content %>% html_table(fill = TRUE)

first_table <- tables[[1]]
first_table <- first_table[-1,]

library(janitor)

reptile<-first_table %>% select(1,16)
reptile2<-reptile[-c(6,7), ]
reptile3<-sort(reptile2$X16, decreasing=T)

reptile2 %>% pull(X16,X1)
df = as.data.frame(reptile2)

library(readr)

df$X16 <- parse_number(df$X16) ## Removes commas 
df1_vector<-structure(as.numeric(df$X16),names=as.character(df$X1))
df1_vector

df2<-sort(df1_vector, decreasing=T)

png(file = "30dayschallenge_day1.png", width = 1024, height = 510)

library(png)
library(patchwork)    

my_image <- readPNG("lagarto.png", native = TRUE)

library(waffle)

waffle(df2/10, rows=22, title = "THE REPTILE DATABASE: Species Numbers by Higher Taxa (as of March 2022)", xlab="1 square = 10 species")+
  theme (legend.text =element_text (size =15), axis.title.x=element_text(size=20))+
  labs(subtitle="http://www.reptile-database.org", caption="@fblpalmeira")+
  
  
  # Combine plot & image
  inset_element(p = my_image,
                left = 0.75,
                bottom = 0.75,
                right = 0.975,
                top = 0.975,
                align_to = "full")# Text size

dev.off()
