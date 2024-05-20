#Chose your exploratory file
relevant_forms <- file.choose(new = FALSE)
list <- read_excel(relevant_forms, sheet = "Feuil2")

POS_E_V_cleaned <- POS_E_V %>%
  filter(!!sym(my_lemma) %in% list[[my_lemma]])
POS_E_C_cleaned <- POS_E_C %>%
  filter(!!sym(my_lemma) %in% list[[my_lemma]])
POS_nonE_C_cleaned <- POS_nonE_C %>%
  filter(!!sym(my_lemma) %in% list[[my_lemma]])
POS_nonE_V_cleaned <- POS_nonE_V %>%
  filter(!!sym(my_lemma) %in% list[[my_lemma]])

