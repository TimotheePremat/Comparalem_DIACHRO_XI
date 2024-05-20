POS_nonE_V_cleaned_lemma <- POS_nonE_V_cleaned %>% count(!!sym(my_lemma))
POS_E_V_cleaned_lemma <- POS_E_V_cleaned %>% count(!!sym(my_lemma))
POS_E_C_cleaned_lemma <- POS_E_C_cleaned %>% count(!!sym(my_lemma))
POS_nonE_C_cleaned_lemma <- POS_nonE_C_cleaned %>% count(!!sym(my_lemma))

POS_V_cleaned_lemma <- full_join(POS_nonE_V_cleaned_lemma,POS_E_V_cleaned_lemma,by=my_lemma) %>%
     rename(nb.nonE = "n.x") %>%
     rename(nb.E = "n.y")
POS_C_cleaned_lemma <- full_join(POS_nonE_C_cleaned_lemma,POS_E_C_cleaned_lemma,by=my_lemma) %>%
     rename(nb.nonE = "n.x") %>%
     rename(nb.E = "n.y")
POS_cleaned_lemma <- full_join(POS_V_cleaned_lemma,POS_C_cleaned_lemma,by=my_lemma) %>%
     rename(nb.nonE.V = "nb.nonE.x") %>%
     rename(nb.E.V = "nb.E.x") %>%
     rename(nb.nonE.C = "nb.nonE.y") %>%
     rename(nb.E.C = "nb.E.y")

POS_cleaned_lemma <- POS_cleaned_lemma %>% replace(is.na(.), 0)

POS_cleaned_lemma <- POS_cleaned_lemma %>% mutate(Nb_POS = nb.nonE.V + nb.E.V + nb.nonE.C + nb.E.C)
POS_cleaned_lemma <- POS_cleaned_lemma %>% mutate(Tx_zero = ((nb.nonE.V + nb.nonE.C)/Nb_POS))

View(POS_cleaned_lemma)

POS_cleaned_lemma_simplified <- POS_cleaned_lemma %>%
	 mutate(Nb_nonE = nb.nonE.V + nb.nonE.C) %>%
     mutate(Nb_E = nb.E.V + nb.E.C) %>%
     select(-c(nb.nonE.V, nb.nonE.C, nb.E.V, nb.E.C)) %>%
     relocate(Nb_nonE, .after=my_lemma) %>%
     relocate(Nb_E, .after=Nb_nonE) %>%
     arrange(desc(Nb_POS)) %>%
     rename(nb.Ø = "Nb_nonE") %>%
     rename(nb.E = "Nb_E") %>%
     rename(frq. = "Nb_POS") %>%
     rename(tx.Ø = "Tx_zero")

POS_cleaned_lemma_corr <- wtd.cor(POS_cleaned_lemma_simplified$tx.Ø, POS_cleaned_lemma_simplified$frq.)
 POS_cleaned_lemma_corr <- as.data.frame(POS_cleaned_lemma_corr)
  POS_cleaned_lemma_rho <- POS_cleaned_lemma_corr$correlation
   POS_cleaned_lemma_rho <- round(POS_cleaned_lemma_rho, digits=3)
  POS_cleaned_lemma_SE <- POS_cleaned_lemma_corr$std.err
   POS_cleaned_lemma_SE <- round(POS_cleaned_lemma_SE, digits=3)
  POS_cleaned_lemma_tvalue <- POS_cleaned_lemma_corr$t.value
   POS_cleaned_lemma_tvalue <- round(POS_cleaned_lemma_tvalue, digits=3)
  POS_cleaned_lemma_pvalue <- POS_cleaned_lemma_corr$p.value
   POS_cleaned_lemma_pvalue <- round(POS_cleaned_lemma_pvalue, digits=3)

# max_freq <- max(POS_cleaned_lemma_simplified$tx.Ø)

g_frq <- ggplot(data=POS_cleaned_lemma_simplified, aes(x=frq., y=tx.Ø)) +
  geom_point(size=2) +#stat="identity",width=0.5,color="black") +
  geom_segment(aes(x=frq., xend=frq., y=0, yend=tx.Ø)) +
  theme_classic() +
  # scale_x_sqrt(name="Fréquence") +
  scale_x_continuous(name="Fréquence",
         limits = c(0,7000)) + #Adjust this to set x-axis lenght to display values
  scale_y_continuous(name="Taux de Ø") +
  					# limits = c(0,paste(max_freq))) +
  # geom_smooth(method = "lm",
  #            se = FALSE,
  #            na.rm = TRUE,
  #            colour = "black",
  #            span = 0.75,
  #            linetype = "dashed") +
  #   geom_smooth(method = "loess",
  #            se = FALSE,
  #            na.rm = TRUE,
  #            colour = "grey",
  #            span = 0.75) +
	annotate("text",
		x=6500,
		y=0.4,
		label=paste("",POS_cleaned_lemma_rho,"\n",
				    POS_cleaned_lemma_SE,"\n",
				    POS_cleaned_lemma_tvalue,"\n",
				    POS_cleaned_lemma_pvalue),
		hjust=0,
		vjust=0) +
	annotate("text",
		x=6200,
		y=0.4,
		label=paste("",rho,"\n",
					sigma,"\n",
					"t","\n",
					"p"),
		hjust=0,
		vjust=0)

mean(POS_cleaned_lemma_simplified$tx.Ø)

write_xlsx(POS_cleaned_lemma,path=paste("Tables/",my_var,"_frq_lemma.xlsx", sep=""))
write_xlsx(POS_cleaned_lemma_simplified,path=paste("Tables/",my_var,"_frq_lemma_simple.xlsx", sep=""))

