library('readxl')
library('readr')
library('dplyr')
library('tidyverse')
library('ggplot2')
library('writexl')
library('stringr')
library('ggpubr')
library('Hmisc')
library('spatstat')
library('weights')
library('Unicode')
library('ggtext')
library('RColorBrewer')
library('sp')
library('ggspatial')
library('rgdal')
library('ggpmisc')
library('viridis')
library('rlang')

italic_p <- u_char_inspect(u_char_from_name("MATHEMATICAL SANS-SERIF ITALIC SMALL P"))["Char"]
rho <- u_char_inspect(u_char_from_name("GREEK SMALL LETTER RHO"))["Char"]
schwa <- u_char_inspect(u_char_from_name("LATIN SMALL LETTER SCHWA"))["Char"]
chi_char <- u_char_inspect(u_char_from_name("GREEK SMALL LETTER CHI"))["Char"]
logiAND <- u_char_inspect(u_char_from_name("AMPERSAND"))["Char"]
sigma <- u_char_inspect(u_char_from_name("GREEK SMALL LETTER SIGMA"))["Char"]


##Define the variable you want to investigate, in order to maintain traceability
my_var <- readline(prompt="Enter the name of the POS you want to investigate, to name the files: ")
my_var2 <- readline(prompt="Enter the name of the POS you want to print as title: ")
my_lemma <- readline(prompt="Enter the type of lemma you want to use: ttlemma, or rnnlemma: ")
my_var_filter <- readline(prompt="Enter the variable you want to use to filter
                          forms. Can be gender_number, or
                          gender_number_case:")
bypass <- readline(prompt="Will you by-pass filtering by lemmas? Answer Y or N:")

word_keeper <- readline(prompt="Enter one or several (space-separated) words you want to keep: ")
word_excluder <- readline(prompt="Enter one (or a vector of) word (form) you want to exclude: ")

#Additional filters
my_var_qual <- readline(prompt="Enter (space separated) level(s) of editorial quality to filter texts: ")
  my_var_qual <- strsplit(my_var_qual, " ")[[1]] #Transform input into vector
my_var_meter <- readline(prompt="Enter 'oui' to only keep versified texts, 'non' to only keep non versified texts: ")
#See A4_Filter in R.R script for directives on how to use this

#----------------------------------
#For non contextual analysis
#----------------------------------
source("A1_import_data.R")
source("A3_post_cleaning.R")
	#Can be by-passed (if all forms are considered the same lemma) by calling instead
	#the following dummy script:
	source("A3_fake_cleaning.R")
source("ZZ_test_filtering_non_contextual.R") #Can be by-passed if not needed: doesn't change variables' name.
source("A4_filter_dates.R") 
source("A5_diachro_plot.R")
source("A6_save_diachro_plot.R")

#----------------------------------
#For non contextual analysis with gender+number filter
#----------------------------------
source("A1_import_data.R")
source("A3_post_cleaning.R")
   #Can be by-passed (if all forms are considered the same lemma) by calling instead
   #the following dummy script:
   source("A3_fake_cleaning.R")
source("ZZ_test_filtering_non_contextual.R") #Can be by-passed if not needed: doesn't change variables' name.
source("AA_filter_gender.R") 
source("A4_filter_dates.R") 
source("A5_diachro_plot.R")
source("A6_save_diachro_plot.R")

#----------------------------------
#For contextual analysis
#----------------------------------
source("A1_import_data_context.R")
source("A3_post_cleaning_context.R")
  #Can be by-passed (if all forms are considered the same lemma) by calling instead
  ##the following dummy script:
  #source("A3_fake_cleaning_context.R")
source("A4_filter_dates_context.R")
source("ZZ_test_filtering.R") #Can be by-passed if not needed: doesn't change variables' name.
source("Filter_by_qual.R")
source("Filter_by_meter.R")
source("A5_diachro_plot_context.R")         #g_POS_V_vs_C_ALL
  #Or, if you have 0 (non-NA) values, try the script without linear model:
  #source("A5_diachro_plot_context_sans_lm.R")
      #If you do so, depending on your data, you might want to uncomment lines for local regression
      #only on data sets where you don't have 0 (non-NA) values.
source("A5_diachro_plot_context_lemma.R")   #p_POS__V_lemma_arrange
source("AB_freq_lemmas_in_R.R") #Print freq plot and table
source("A5_count_choose_SRC.R") #This lead to R_count or R_count_bypass_lemma
                                #depending on the var. 'bypass' == Y/N
source("A5_diachro_plot_context_AN_non_AN.R")   #g_AN_non_AN_ALL
   #Or, if you have 0 (non-NA) values, try the script without linear model:
   #source("A5_diachro_plot_context_AN_non_AN_sans_lm.R")
      #If you do so, depending on your data, you might want to uncomment lines for local regression
      #only on data sets where you don't have 0 (non-NA) values.
#source("A5_chi-2.R") #Beware: must be parametered by hand!!! Can be by-passed.
source("A6_save_diachro_plot_context.R")
  #Warning object 'f_frq not found' is normal with only one lemma, can be ignored.
source("A6_save_diachro_plot_context_lemma.R")
source("A6_save_diachro_plot_context AN_non_AN.R")
source("A6_save_simple_table.R")
source("A6_save_table.R")
#source("A6_chi-2_save.R")
#Choose one of the following:
##Default is with neutralization of regions < 5 texts
  source("A8_carto.R")
  source("A8_carto_no_min.R")
source("A9_carto_save.R")
source("A9_carto_save_no_min.R")
source("A9_AN_vs_non_AN.R") #Print boxplot and Student for comparison between AN and continental texts

#----------------------------------
#For maps by periods
#----------------------------------
#This work with any contextual analysis above. Run it after you've run an A5_diachro_plot script.
#If you want custom periods, run the following lines:
 bound_1b <- readline(prompt="Whats the top boundary of the first period?")
 bound_2a <- readline(prompt="Whats the bottom boundary of the second period?")
 bound_2b <- readline(prompt="Whats the top boundary of the second period?")
 bound_3a <- readline(prompt="Whats the bottom boundary of the third period?")
 bound_3b <- readline(prompt="Whats the top boundary of the third period?")
 bound_4a <- readline(prompt="Whats the bottom boundary of the last period?")
#If you want half century periods, run the following lines:
 bound_1b <- 1151
 bound_2a <- 1150
 bound_2b <- 1201
 bound_3a <- 1200
 bound_3b <- 1251
 bound_4a <- 1250
source("A8bis_carto_time.R")
source("A8bis_carto_time_save.R")
 
 #----------------------------------
 #Notes for easy access
 #----------------------------------
 View(POS_EnonE_count)
    mean(POS_EnonE_count$Tx_POS_nonE)
    min(POS_EnonE_count$Tx_POS_nonE)
    max(POS_EnonE_count$Tx_POS_nonE)
 #View(POS__V)
 #View(POS__C)
 View(POS_nonE_V_cleaned)
 View(POS_nonE_C_cleaned)
 View(POS_E_V_cleaned)
 View(POS_E_C_cleaned)
 
 #To see Pearson correlation coefficient pour #C and #V series of the current dataset:
 POS__C_corr
  POS__C_w_corr
 POS__V_corr
  POS__V_w_corr
 