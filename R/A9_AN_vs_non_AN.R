#Prepare datasets
#Separate anglo-norman from continental dialects
	AN <- POS__V %>% filter(R_code_suppl_total == 29)
	non_AN <- POS__V %>% filter(R_code_suppl_total != 29)

	AN_OVW <-  AN %>%
	               mutate(cat = "AN") %>%
	               relocate(cat)
	non_AN_OVW <-  non_AN %>%
	               mutate(cat = "non_AN") %>%
	               relocate(cat)
	POS_OVW <- bind_rows(AN_OVW,non_AN_OVW)

#---------------------------------------------------------------------
#Compute states
#---------------------------------------------------------------------
#Compute Student
 	AN_vs_non_AN_t <- t.test(AN$Tx_POS_EnonE,non_AN$Tx_POS_EnonE)
	 AN_vs_non_AN_t <- t.test(AN$Tx_POS_EnonE,non_AN$Tx_POS_EnonE)$statistic
			AN_vs_non_AN_t <- round(AN_vs_non_AN_t, digits=2)
		AN_vs_non_AN_p <- t.test(AN$Tx_POS_EnonE,non_AN$Tx_POS_EnonE)$p.value
			AN_vs_non_AN_p <- if (AN_vs_non_AN_p <0.005) {
									   				("< 0.005")
									   			} else if (AN_vs_non_AN_p <0.05) {
									   				("< 0.05")
									   			} else
									   				(paste("=",round(AN_vs_non_AN_p, digits=3)))

#Compute means and sd
	AN_mean <- mean(AN$Tx_POS_EnonE)
		AN_mean <- round(AN_mean, digits=2)
	AN_sd <- sd(AN$Tx_POS_EnonE)
		AN_sd <- round(AN_sd, digits=2)
	AN_med <- median(AN$Tx_POS_EnonE)
		AN_med <- round(AN_med, digits=2)
	non_AN_mean <- mean(non_AN$Tx_POS_EnonE)
		non_AN_mean <- round(non_AN_mean, digits=2)
	non_AN_sd <- sd(non_AN$Tx_POS_EnonE)
		non_AN_sd <- round(non_AN_sd, digits=2)
	non_AN_med <- median(non_AN$Tx_POS_EnonE)
	 	non_AN_med<- round(non_AN_med, digits=2)

#---------------------------------------------------------------------
#Plot it!
#---------------------------------------------------------------------
	Overview_AN_vs_non_AN <- ggplot(POS_OVW, aes(x=cat, y=Tx_POS_EnonE)) +
	  geom_boxplot() +
			theme_classic() +
			scale_y_continuous(	limits = c(0,1),
								name="Taux de Ø devant #V") +
	  scale_x_discrete(name="Dialecte",
	                   labels = c(
	                     "AN" = "anglo-normand",
	                     "non_AN" = "a.fr. continental"))


#---------------------------------------------------------------------
#ARRANGE plot and texts
#---------------------------------------------------------------------
#Prepare legend text
	text_Student <- paste("t =",AN_vs_non_AN_t,"; p",AN_vs_non_AN_p, sep=" ")
		text_Student <- ggparagraph(text = text_Student, size = 11, color = "black")

	text_stat_AN <- paste("A.n.",AN_sd,AN_mean,AN_med,sep="\n\n")
		text_stat_AN <- ggparagraph(text = text_stat_AN, size = 11, color = "black")
	text_stat_nonAN <- paste("A.fr. cont.",non_AN_sd,non_AN_mean,non_AN_med,sep="\n\n")
		text_stat_nonAN <- ggparagraph(text = text_stat_nonAN, size = 11, color = "black")
	text_leg <- paste("",sigma,"moy.","méd.",sep="\n\n")
		text_leg <- ggparagraph(text = text_leg, size = 11, color = "black")
	place_holder <- paste("")
		place_holder <- ggparagraph(text = place_holder, size = 11, color = "black")

	text_Student_titled <- ggarrange(	text_Student,
										ncol = 1,
	 	        						nrow = 2
										)
	text_Student_titled <- annotate_figure(text_Student_titled, top = text_grob("Test de Student\n", color = "black", face = "bold", size = 11))

	text_stat <- ggarrange(	text_leg,
							text_stat_AN,
							text_stat_nonAN,
										ncol = 3,
	 	        						nrow = 1
										)
	text_stat <- annotate_figure(text_stat, top = text_grob("Mesures\n", color = "black", face = "bold", size = 11))

	text_ALL <- ggarrange(	place_holder,
							text_Student_titled,
							text_stat,
							ncol = 1,
							nrow = 3,
							align="h",
							heights= c(2.5,1,2))

#Merge graph and text
	g_Overview_AN_vs_non_AN <- ggarrange(	Overview_AN_vs_non_AN,
	          								text_ALL,
	        								# labels="auto",
	        								ncol = 2,
	        								nrow = 1,
											align = "h",
											widths = c(1.5, 1))

#---------------------------------------------------------------------
#Save
#---------------------------------------------------------------------
ggsave(g_Overview_AN_vs_non_AN,
	   	path = "Graphs",
		filename = paste(my_var,"AN_non_AN_Student.pdf"),
		device=cairo_pdf,
		width = 7,
	 	height = 6,
		units = "in")