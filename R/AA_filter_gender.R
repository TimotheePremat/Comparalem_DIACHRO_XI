#Filtering for gender and number (specially for ADJs)
POS_E_masc_sg <- POS_E_cleaned %>%
 filter(gender == "masc") %>%
	filter(number == "sg")
POS_E_masc_pl <- POS_E_cleaned %>%
	filter(gender == "masc") %>%
	filter(number == "pl")
POS_E_femi_sg <- POS_E_cleaned %>%
	filter(gender == "femi") %>%
	filter(number == "sg")
POS_E_femi_pl <- POS_E_cleaned %>%
	filter(gender == "femi") %>%
	filter(number == "pl")

POS_nonE_masc_sg <- POS_nonE_cleaned %>%
 filter(gender == "masc") %>%
	filter(number == "sg")
POS_nonE_masc_pl <- POS_nonE_cleaned %>%
	filter(gender == "masc") %>%
	filter(number == "pl")
POS_nonE_femi_sg <- POS_nonE_cleaned %>%
	filter(gender == "femi") %>%
	filter(number == "sg")
POS_nonE_femi_pl <- POS_nonE_cleaned %>%
	filter(gender == "femi") %>%
	filter(number == "pl")

POS_E_cleaned <- get(paste("POS_E",my_var_filter, sep = "_"))
POS_nonE_cleaned <- get(paste("POS_nonE",my_var_filter, sep = "_"))