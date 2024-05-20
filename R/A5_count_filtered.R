#Script to print numbers of lemmas and occ.
#This script calls to non-filtered and filtered files. This is needed because
##you need the non filtered data for number of lemmas non subjects to variation
##but it implies non verified data; use with precautions.
###Filtered lemma are obtains by reference to 'list', the object that filters lemmas.
###Filtered lemma are designated in var name by 'var'.

#For total
POS <- bind_rows(POS_E_V, POS_E_C, POS_nonE_C, POS_nonE_V)# POS_EC_V, POS_EC_C)

	#-------------------------------------------------
	#Add filtering
	POS_masc_sg <- POS %>%
	 filter(gender == "masc") %>%
		filter(number == "sg")
	POS_masc_pl <- POS %>%
		filter(gender == "masc") %>%
		filter(number == "pl")
	POS_femi_sg <- POS %>%
		filter(gender == "femi") %>%
		filter(number == "sg")
	POS_femi_pl <- POS %>%
		filter(gender == "femi") %>%
		filter(number == "pl")

 POS_masc_sg_suj <- POS %>%
		filter(gender == "masc") %>%
		filter(number == "sg") %>%
		filter(decl == "suj")
 POS_femi_sg_suj <- POS %>%
 	filter(gender == "femi") %>%
 	filter(number == "sg") %>%
 	filter(decl == "suj")
 POS_neutre_sg_suj <- POS %>%
 filter(gender == "neutre") %>%
 filter(number == "sg") %>%
 filter(decl == "suj")
	POS_masc_pl_suj <- POS %>%
		filter(gender == "masc") %>%
		filter(number == "pl") %>%
		filter(decl == "suj")
	POS_femi_pl_suj <- POS %>%
		filter(gender == "femi") %>%
		filter(number == "pl") %>%
		filter(decl == "suj")
	POS_neutre_pl_suj <- POS %>%
	filter(gender == "neutre") %>%
	filter(number == "pl") %>%
	filter(decl == "suj")
	POS_masc_sg_acc <- POS %>%
		filter(gender == "masc") %>%
		filter(number == "sg") %>%
		filter(decl == "acc")
	POS_femi_sg_acc <- POS %>%
		filter(gender == "femi") %>%
		filter(number == "sg") %>%
		filter(decl == "acc")
	POS_neutre_sg_acc <- POS %>%
	filter(gender == "neutre") %>%
	filter(number == "sg") %>%
	filter(decl == "acc")
	POS_masc_pl_acc <- POS %>%
		filter(gender == "masc") %>%
		filter(number == "pl") %>%
		filter(decl == "acc")
	POS_femi_pl_acc <- POS %>%
		filter(gender == "femi") %>%
		filter(number == "pl") %>%
		filter(decl == "acc")
	POS_neutre_pl_acc <- POS %>%
	filter(gender == "neutre") %>%
	filter(number == "pl") %>%
	filter(decl == "acc")

	POS <- get(paste("POS",my_var_filter, sep = "_"))
	#-------------------------------------------------

	#Back to normal script
	POS_var <- POS %>%
	  filter(lemma %in% list$lemma)

	POS_nrow <- nrow(POS)

	POS_lemma <- POS %>% group_by(lemma)
	POS_lemma <- POS_lemma %>% count(lemma, sort=TRUE) #First time gets the number of occ. per lemma
	POS_lemma <- POS_lemma %>% count(lemma, sort=TRUE) #Second time get 1 by lemma
	POS_lemma_sum <- sum(POS_lemma$n)


#For variable lemmas
POS_var <- bind_rows(POS_E_V_cleaned, POS_E_C_cleaned, POS_nonE_C_cleaned, POS_nonE_V_cleaned)

	#-------------------------------------------------
	#Add filtering
	POS_var_masc_sg <- POS_var %>%
	 filter(gender == "masc") %>%
		filter(number == "sg")
	POS_var_masc_pl <- POS_var %>%
		filter(gender == "masc") %>%
		filter(number == "pl")
	POS_var_femi_sg <- POS_var %>%
		filter(gender == "femi") %>%
		filter(number == "sg")
	POS_var_femi_pl <- POS_var %>%
		filter(gender == "femi") %>%
		filter(number == "pl")

		POS_var_masc_sg_suj <- POS_var %>%
			filter(gender == "masc") %>%
			filter(number == "sg") %>%
			filter(decl == "suj")
	 POS_var_femi_sg_suj <- POS_var %>%
	 	filter(gender == "femi") %>%
	 	filter(number == "sg") %>%
	 	filter(decl == "suj")
	 POS_var_neutre_sg_suj <- POS_var %>%
	 filter(gender == "neutre") %>%
	 filter(number == "sg") %>%
	 filter(decl == "suj")
		POS_var_masc_pl_suj <- POS_var %>%
			filter(gender == "masc") %>%
			filter(number == "pl") %>%
			filter(decl == "suj")
		POS_var_femi_pl_suj <- POS_var %>%
			filter(gender == "femi") %>%
			filter(number == "pl") %>%
			filter(decl == "suj")
		POS_var_neutre_pl_suj <- POS_var %>%
		filter(gender == "neutre") %>%
		filter(number == "pl") %>%
		filter(decl == "suj")
		POS_var_masc_sg_acc <- POS_var %>%
			filter(gender == "masc") %>%
			filter(number == "sg") %>%
			filter(decl == "acc")
		POS_var_femi_sg_acc <- POS_var %>%
			filter(gender == "femi") %>%
			filter(number == "sg") %>%
			filter(decl == "acc")
		POS_var_neutre_sg_acc <- POS_var %>%
		filter(gender == "neutre") %>%
		filter(number == "sg") %>%
		filter(decl == "acc")
		POS_var_masc_pl_acc <- POS_var %>%
			filter(gender == "masc") %>%
			filter(number == "pl") %>%
			filter(decl == "acc")
		POS_var_femi_pl_acc <- POS_var %>%
			filter(gender == "femi") %>%
			filter(number == "pl") %>%
			filter(decl == "acc")
		POS_var_neutre_pl_acc <- POS_var %>%
		filter(gender == "neutre") %>%
		filter(number == "pl") %>%
		filter(decl == "acc")

	POS_var <- get(paste("POS_var",my_var_filter, sep = "_"))
	#-------------------------------------------------

POS_var_nrow <- nrow(POS_var)

POS_var_lemma <- POS_var %>% group_by(lemma)
POS_var_lemma <- POS_var_lemma %>% count(lemma, sort=TRUE) #First time gets the number of occ. per lemma
POS_var_lemma <- POS_var_lemma %>% count(lemma, sort=TRUE) #Second time get 1 by lemma
POS_var_lemma_sum <- sum(POS_var_lemma$n)


#For variable lemmas ending in -Ø
POS_var_zero <- bind_rows(POS_nonE_C_cleaned, POS_nonE_V_cleaned)

	#-------------------------------------------------
	#Add filtering
	POS_var_zero_masc_sg <- POS_var_zero %>%
	  filter(gender == "masc") %>%
		filter(number == "sg")
	POS_var_zero_masc_pl <- POS_var_zero %>%
		filter(gender == "masc") %>%
		filter(number == "pl")
	POS_var_zero_femi_sg <- POS_var_zero %>%
		filter(gender == "femi") %>%
		filter(number == "sg")
	POS_var_zero_femi_pl <- POS_var_zero %>%
		filter(gender == "femi") %>%
		filter(number == "pl")

		POS_var_zero_masc_sg_suj <- POS_var_zero %>%
			filter(gender == "masc") %>%
			filter(number == "sg") %>%
			filter(decl == "suj")
	 POS_var_zero_femi_sg_suj <- POS_var_zero %>%
	 	filter(gender == "femi") %>%
	 	filter(number == "sg") %>%
	 	filter(decl == "suj")
	 POS_var_zero_neutre_sg_suj <- POS_var_zero %>%
	 filter(gender == "neutre") %>%
	 filter(number == "sg") %>%
	 filter(decl == "suj")
		POS_var_zero_masc_pl_suj <- POS_var_zero %>%
			filter(gender == "masc") %>%
			filter(number == "pl") %>%
			filter(decl == "suj")
		POS_var_zero_femi_pl_suj <- POS_var_zero %>%
			filter(gender == "femi") %>%
			filter(number == "pl") %>%
			filter(decl == "suj")
		POS_var_zero_neutre_pl_suj <- POS_var_zero %>%
		filter(gender == "neutre") %>%
		filter(number == "pl") %>%
		filter(decl == "suj")
		POS_var_zero_masc_sg_acc <- POS_var_zero %>%
			filter(gender == "masc") %>%
			filter(number == "sg") %>%
			filter(decl == "acc")
		POS_var_zero_femi_sg_acc <- POS_var_zero %>%
			filter(gender == "femi") %>%
			filter(number == "sg") %>%
			filter(decl == "acc")
		POS_var_zero_neutre_sg_acc <- POS_var_zero %>%
		filter(gender == "neutre") %>%
		filter(number == "sg") %>%
		filter(decl == "acc")
		POS_var_zero_masc_pl_acc <- POS_var_zero %>%
			filter(gender == "masc") %>%
			filter(number == "pl") %>%
			filter(decl == "acc")
		POS_var_zero_femi_pl_acc <- POS_var_zero %>%
			filter(gender == "femi") %>%
			filter(number == "pl") %>%
			filter(decl == "acc")
		POS_var_zero_neutre_pl_acc <- POS_var_zero %>%
		filter(gender == "neutre") %>%
		filter(number == "pl") %>%
		filter(decl == "acc")

	POS_var_zero <- get(paste("POS_var_zero",my_var_filter, sep = "_"))
	#-------------------------------------------------

POS_var_zero_nrow <- nrow(POS_var_zero)

#Print
##Tot.
###Number of occ.:
POS_nrow
###Number of lemmas:
POS_lemma_sum

##Schwa_C
###Number of occ.:
# POS_schwaC_nrow
###Number of lemmas:
# POS_schwaC_lemma_sum

##Variable lemmas
###Number of occ.:
POS_var_nrow
###Number of lemmas:
POS_var_lemma_sum
###Number of -Ø forms
POS_var_zero_nrow

###Calculations
Tx_var_lemma <- (POS_var_lemma_sum / POS_lemma_sum)*100
if(Tx_var_lemma < 0.01){Tx_var_lemma <- "<0,01 %"}
if(Tx_var_lemma > 0.01){Tx_var_lemma <- round(Tx_var_lemma, digits=2)}
if(Tx_var_lemma > 0.01){Tx_var_lemma <- paste(Tx_var_lemma, "%")}

Tx_var_nrow <- (POS_var_nrow / POS_nrow)*100
if(Tx_var_nrow < 0.01){Tx_var_nrow <- "<0,01 %"}
if(Tx_var_nrow > 0.01){Tx_var_nrow <- round(Tx_var_nrow, digits=2)}
if(Tx_var_nrow > 0.01){Tx_var_nrow <- paste(Tx_var_nrow, "%")}

Tx_var_zero_nrow <- (POS_var_zero_nrow / POS_nrow)*100
if(Tx_var_zero_nrow < 0.01){Tx_var_zero_nrow <- "<0,01 %"}
if(Tx_var_zero_nrow > 0.01){Tx_var_zero_nrow <- round(Tx_var_zero_nrow, digits=2)}
if(Tx_var_zero_nrow > 0.01){Tx_var_zero_nrow <- paste(Tx_var_zero_nrow, "%")}

##Synoptic table
table <- data.frame(	"AA_temp" = c("Lemmes", "Occ."),
                    	"Nb." = c(POS_lemma_sum, POS_nrow),
											"Nb.var." = c(POS_var_lemma_sum, POS_var_nrow),
											"Taux" = c(Tx_var_lemma, Tx_var_nrow),
											"Nb.Var.Ø" = c("", POS_var_zero_nrow),
											"Taux.Ø" = c("",Tx_var_zero_nrow)
											)
table <- table %>% rename(!!my_var := AA_temp)
