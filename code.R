
library(fs)
library(tidyverse)

appointments <- read.csv(file ="C:\\Users\\erynn\\OneDrive\\Erynn\\TA\\Pretest\\appointments.csv", header = TRUE, sep=",")

files <- dir_ls(path = "pretest-tograde/pretesdt-tograde/", all = TRUE)

files <- tibble(files)

files <- 
  files %>% 
  mutate(filename = path_file(files)) %>% 
  mutate(pawsid = str_split(filename, pattern = "_")) %>% 
  mutate(pawsid2 = map_chr(pawsid, 1)) %>% 
  mutate(filesize = file_size(files))
  

appointments <-
  appointments %>% 
  mutate(drop = pawsid %in% files$pawsid2)

appointments <- left_join( appointments, select(files, pawsid2, filesize), by = c("pawsid" = "pawsid2"))

write.csv(appointments, "C:\\Users\\erynn\\OneDrive\\Erynn\\TA\\Pretest\\ExcelPretestR")           
