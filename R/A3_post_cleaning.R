#Chose your exploratory file
relevant_forms <- file.choose(new = FALSE)
list <- read_excel(relevant_forms, sheet = "Feuil2")

POS_E_cleaned <- POS_E %>%
  filter(!!sym(my_lemma) %in% list[[my_lemma]])
POS_nonE_cleaned <- POS_nonE %>%
  filter(!!sym(my_lemma) %in% list[[my_lemma]])
