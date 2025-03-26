
strawberry <- read_csv("straw1.csv", col_names = TRUE)

for(i in 1:dim(strawberry)[2]) {
  print(unique(strawberry[i]))
}
strawberry = strawberry |> select(-Watershed)

drop_one_val = function(df){
  drop = NULL
  for (i in 1:dim(df)[2]) {
    if((df |> distinct(df[,i]) |> count()) ==1){
      drop = c(drop, i)
    }}
  
  if(is.null(drop)){return("none")}else{
    print("Columns dropped")
    print(colnames(df)[drop])
    strawberry = df[, -1*drop]
  }}

strawberry = strawberry |> drop_one_val()

library(kableExtra)
