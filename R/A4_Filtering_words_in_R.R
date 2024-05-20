#If values have been provided in word_keeper and/or word_excluder variable,
 #Then keep/exclude them.
	#- Does nothing is no values are provided
	#- To be run before A5_diachro_plot_context

	#Be sure to check the list of words you wanna keep/exclude before!
	 #To do so, inspect each of four dataframes with
		 #list_of_words <- POS_E_C_cleaned %>% group_by(word)
			#print(summarise(list_of_words, count=n()), n=Inf)
			 #replacing POS_E_C_cleaned by the three other datasets names also!

if (exists("word_keeper") && !is.null(word_keeper) && length(word_keeper) > 0 && any(word_keeper != "")) {
	 values_keeper <- strsplit(word_keeper, " ")[[1]]
  POS_E_C_cleaned <- POS_E_C_cleaned %>% filter(word %in% values_keeper)
		POS_E_V_cleaned <- POS_E_V_cleaned %>% filter(word %in% values_keeper)
		POS_nonE_C_cleaned <- POS_nonE_C_cleaned %>% filter(word %in% values_keeper)
		POS_nonE_V_cleaned <- POS_nonE_V_cleaned %>% filter(word %in% values_keeper)
		print("Keeper: Word(s) successfully kept, others excluded")
} else {
  print("Keeper: You have not provided words to keep, I do nothing.")
}

if (exists("word_excluder") && !is.null(word_excluder) && length(word_excluder) > 0 && any(word_excluder != "")) {
	 word_excluder <- strsplit(word_excluder, " ")[[1]]
		POS_E_C_cleaned <- POS_E_C_cleaned %>% filter(!word %in% word_excluder)
		POS_E_V_cleaned <- POS_E_V_cleaned %>% filter(!word %in% word_excluder)
		POS_nonE_C_cleaned <- POS_nonE_C_cleaned %>% filter(!word %in% word_excluder)
		POS_nonE_V_cleaned <- POS_nonE_V_cleaned %>% filter(!word %in% word_excluder)
		print("Excluder: Word(s) successfully excluded, others kept")
} else {
  print("Excluder: You have not provided words to exclude, I do nothing.")
}
