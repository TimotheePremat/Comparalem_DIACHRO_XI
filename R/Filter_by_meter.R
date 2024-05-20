#Filtering by versified form of the text
POS_E_V_cleaned <- POS_E_V_cleaned %>%
 filter(vers == my_var_meter)
POS_E_C_cleaned <- POS_E_C_cleaned %>%
 filter(vers == my_var_meter)
POS_nonE_C_cleaned <- POS_nonE_C_cleaned %>%
 filter(vers == my_var_meter)
POS_nonE_V_cleaned <- POS_nonE_V_cleaned %>%
 filter(vers == my_var_meter)
