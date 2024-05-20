#Script to print #C and #V duachronic graphs opposing anglo-norman and continental French
#Must be run after A5_diachro_plot_context.R; it uses POS__V and POS__C produced by this script.

#---------------------------------------------------------------------
#Prepare data
#---------------------------------------------------------------------
#Separate anglo-norman texts from continental texts
	AN_V <- POS__V %>% filter(R_code_suppl_total == 29)
	non_AN_V <- POS__V %>% filter(R_code_suppl_total != 29)

	AN_C <- POS__C %>% filter(R_code_suppl_total == 29)
	non_AN_C <- POS__C %>% filter(R_code_suppl_total != 29)


# POS_context_count <- POS_context %>% count(cat,id)


# POS_context_count <- merge (POS_context_count,
#                             Dates_NCA,
#                             by="id")

# ###Remove empty cols for readability
# index_POS_context_count <- map_lgl(POS_context_count, ~ all(is.na(.)))
# POS_context_count <- POS_context_count[, !index_POS_context_count]

# #Transform date values into numeric values (there are discreet for now)
# POS_context_count$datecomposition <- as.numeric(as.character(POS_context_count$datecomposition))
# POS_context_count$datemanuscrit <- as.numeric(as.character(POS_context_count$datemanuscrit))

#---------------------------------------------------------------------
#Prepare plots
#---------------------------------------------------------------------

#--------------------------------
#AN_C and AN_V: anglo-norman plots
#--------------------------------

#-------
# AN_C: Anglo-norman texts before C-initial word
#-------

## Reinject metadata from Dates_NCA
# AN_C <- merge (	AN_C,
# 								Dates_NCA,
# 								by="id")

AN_C$datecomposition <- as.numeric(as.character(AN_C$datecomposition))
AN_C$datemanuscrit <- as.numeric(as.character(AN_C$datemanuscrit))
AN_C$datemoyennedees <- as.numeric(as.character(AN_C$datemoyennedees))

AN_C_w_mean <- weighted.mean(AN_C$Tx_POS_EnonE, w = AN_C$Nb_POS_EnonE, na.rm=TRUE)
  AN_C_w_mean <- round(AN_C_w_mean, digits=2)
AN_C_w_median <- weighted.median(AN_C$Tx_POS_EnonE, w = AN_C$Nb_POS_EnonE, na.rm=TRUE)
		AN_C_w_median <- round(AN_C_w_median, digits=2)
AN_C_w_sd <- wtd.var(AN_C$Tx_POS_EnonE, w = AN_C$Nb_POS_EnonE, na.rm=TRUE)
  AN_C_w_sd <- sqrt(AN_C_w_sd)
  AN_C_w_sd <- round(AN_C_w_sd, digits=2)
AN_C_w_date_mean <- weighted.mean(AN_C$datecomposition, w = AN_C$Nb_POS_EnonE, na.rm=TRUE)
  AN_C_w_date_mean <- round(AN_C_w_date_mean, digits=0)
# AN_C_w_corr <- wtd.cor(AN_C$datecomposition, AN_C$Tx_POS_EnonE, AN_C$Nb_POS_EnonE)
#  AN_C_w_corr <- as.data.frame(AN_C_w_corr)
#   AN_C_w_rho <- AN_C_w_corr$correlation
# 		 AN_C_w_rho <- round(AN_C_w_rho, digits=3)
# 		AN_C_w_SE <- AN_C_w_corr$std.err
# 		 AN_C_w_SE <- round(AN_C_w_SE, digits=3)
# 		AN_C_w_tvalue <- AN_C_w_corr$t.value
# 			AN_C_w_tvalue <- round(AN_C_w_tvalue, digits=3)
# 		AN_C_w_pvalue <- AN_C_w_corr$p.value
# 			AN_C_w_pvalue <- round(AN_C_w_pvalue, digits=5)

p_AN_C_w <- ggplot(AN_C, aes(x=datecomposition, y=Tx_POS_EnonE, size=Nb_POS_EnonE)) +
 geom_point() +
 scale_size(range = c(1, 5)) +
	# geom_smooth(method = "loess",
	# 												se = FALSE,
	# 												na.rm = TRUE,
	# 												colour = "grey",
	# 												span = 0.75,
	# 												aes(weight=Nb_POS_EnonE),
	# 											 show.legend = FALSE)  +
 # geom_smooth(method = "lm",
 #             se = FALSE,
 #             na.rm = TRUE,
 #             colour = "grey",
 #             linetype = "dashed",
# 												 aes(weight=Nb_POS_EnonE),
# 												 show.legend = FALSE)  +
 theme_classic() +
	theme(legend.position = c(.95, .95),
       legend.justification = c("right", "top"),
       legend.box.just = "right",
       legend.margin = margin(6, 6, 6, 6)) +
	labs(size="Nb obs.") +
	ggtitle("Anglo-normand, #C") +
 scale_x_continuous(name="Date de composition", breaks=c(1000,
                                                         1100,
                                                         1200,
                                                         1300,
                                                         1400,
                                                         1500,
                                                         1600,
                                                         1700,
                                                         1800,
                                                         1900,
                                                         2000),
																																																limits = c(1100,1500)) +
 scale_y_continuous(limits = c(0,1),
                    name="Devant #C, taux de Ø")

p_AN_C_w_arrange <- p_AN_C_w +
annotate("rect",
									xmin = 1350,
									xmax = 1500,
									ymin = 0,
									ymax = 0.25,
									alpha = .75,
									fill="white") +
annotate("text",
									x=1450,
									y=0,
									label=paste("",#AN_C_w_rho,"\n",
																					#AN_C_w_pvalue,"\n",
																					AN_C_w_mean,"\n",
																					AN_C_w_median,"\n",
																					AN_C_w_sd,"\n",
																					AN_C_sum,"\n",
																					AN_C_w_date_mean),
									hjust=0,
									vjust=0) +
annotate("text",
									x=1425,
									y=0,
									label=paste(#rho,"\n",
																					#"p","\n",
																					"moy. \n",
																					"méd. \n",
																					"sd \n",
																					"nb. obs. \n",
																					"date moy."),
									hjust=1,
									vjust=0)

#-------
# AN_V: Anglo-norman texts before V-initial word
#-------
AN_V$datecomposition <- as.numeric(as.character(AN_V$datecomposition))
AN_V$datemanuscrit <- as.numeric(as.character(AN_V$datemanuscrit))
AN_V$datemoyennedees <- as.numeric(as.character(AN_V$datemoyennedees))


AN_V_w_mean <- weighted.mean(AN_V$Tx_POS_EnonE, w = AN_V$Nb_POS_EnonE, na.rm=TRUE)
  AN_V_w_mean <- round(AN_V_w_mean, digits=2)
AN_V_w_median <- weighted.median(AN_V$Tx_POS_EnonE, w = AN_V$Nb_POS_EnonE, na.rm=TRUE)
		AN_V_w_median <- round(AN_V_w_median, digits=2)
AN_V_w_sd <- wtd.var(AN_V$Tx_POS_EnonE, w = AN_V$Nb_POS_EnonE, na.rm=TRUE)
  AN_V_w_sd <- sqrt(AN_V_w_sd)
  AN_V_w_sd <- round(AN_V_w_sd, digits=2)
AN_V_w_date_mean <- weighted.mean(AN_V$datecomposition, w = AN_V$Nb_POS_EnonE, na.rm=TRUE)
  AN_V_w_date_mean <- round(AN_V_w_date_mean, digits=0)
# AN_V_w_corr <- wtd.cor(AN_V$datecomposition, AN_V$Tx_POS_EnonE, AN_V$Nb_POS_EnonE)
#  AN_V_w_corr <- as.data.frame(AN_V_w_corr)
#   AN_V_w_rho <- AN_V_w_corr$correlation
# 		 AN_V_w_rho <- round(AN_V_w_rho, digits=3)
# 		AN_V_w_SE <- AN_V_w_corr$std.err
# 		 AN_V_w_SE <- round(AN_V_w_SE, digits=3)
# 		AN_V_w_tvalue <- AN_V_w_corr$t.value
# 			AN_V_w_tvalue <- round(AN_V_w_tvalue, digits=3)
# 		AN_V_w_pvalue <- AN_V_w_corr$p.value
# 			AN_V_w_pvalue <- round(AN_V_w_pvalue, digits=5)

p_AN_V_w <- ggplot(AN_V, aes(x=datecomposition, y=Tx_POS_EnonE, size=Nb_POS_EnonE)) +
 geom_point() +
 scale_size(range = c(1, 5)) +
	# geom_smooth(method = "loess",
	# 												se = FALSE,
	# 												na.rm = TRUE,
	# 												colour = "grey",
	# 												span = 0.75,
	# 												aes(weight=Nb_POS_EnonE),
	# 											 show.legend = FALSE)  +
 # geom_smooth(method = "lm",
 #             se = FALSE,
 #             na.rm = TRUE,
 #             colour = "grey",
 #             linetype = "dashed",
	# 											 aes(weight=Nb_POS_EnonE),
	# 											 show.legend = FALSE)  +
 theme_classic() +
	theme(legend.position = c(.95, .95),
       legend.justification = c("right", "top"),
       legend.box.just = "right",
       legend.margin = margin(6, 6, 6, 6)) +
	ggtitle("Anglo-normand, #V") +
	labs(size="Nb obs.") +
 scale_x_continuous(name="Date de composition", breaks=c(1000,
                                                         1100,
                                                         1200,
                                                         1300,
                                                         1400,
                                                         1500,
                                                         1600,
                                                         1700,
                                                         1800,
                                                         1900,
                                                         2000),
																																																limits = c(1100,1500)) +
 scale_y_continuous(limits = c(0,1),
                    name="Devant #V, taux de Ø")

p_AN_V_w_arrange <- p_AN_V_w +
annotate("rect",
									xmin = 1350,
									xmax = 1500,
									ymin = 0,
									ymax = 0.25,
									alpha = .75,
									fill="white") +
annotate("text",
									x=1450,
									y=0,
									label=paste("",#AN_V_w_rho,"\n",
																					#AN_V_w_pvalue,"\n",
																					AN_V_w_mean,"\n",
																					AN_V_w_median,"\n",
																					AN_V_w_sd,"\n",
																					AN_V_sum,"\n",
																					AN_V_w_date_mean),
									hjust=0,
									vjust=0) +
annotate("text",
									x=1425,
									y=0,
									label=paste(#rho,"\n",
																					#"p","\n",
																					"moy. \n",
																					"méd. \n",
																					"sd \n",
																					"nb. obs. \n",
																					"date moy."),
									hjust=1,
									vjust=0)

#--------------------------------
#non_AN_C and non_AN_V: anglo-norman plots
#--------------------------------

#-------
# non_AN_C: Anglo-norman texts before C-initial word
#-------

## Reinject metadata from Dates_NCA
# non_AN_C <- merge (	non_AN_C,
# 								Dates_NCA,
# 								by="id")

non_AN_C$datecomposition <- as.numeric(as.character(non_AN_C$datecomposition))
non_AN_C$datemanuscrit <- as.numeric(as.character(non_AN_C$datemanuscrit))
non_AN_C$datemoyennedees <- as.numeric(as.character(non_AN_C$datemoyennedees))

non_AN_C_w_mean <- weighted.mean(non_AN_C$Tx_POS_EnonE, w = non_AN_C$Nb_POS_EnonE, na.rm=TRUE)
  non_AN_C_w_mean <- round(non_AN_C_w_mean, digits=2)
non_AN_C_w_median <- weighted.median(non_AN_C$Tx_POS_EnonE, w = non_AN_C$Nb_POS_EnonE, na.rm=TRUE)
		non_AN_C_w_median <- round(non_AN_C_w_median, digits=2)
non_AN_C_w_sd <- wtd.var(non_AN_C$Tx_POS_EnonE, w = non_AN_C$Nb_POS_EnonE, na.rm=TRUE)
  non_AN_C_w_sd <- sqrt(non_AN_C_w_sd)
  non_AN_C_w_sd <- round(non_AN_C_w_sd, digits=2)
non_AN_C_w_date_mean <- weighted.mean(non_AN_C$datecomposition, w = non_AN_C$Nb_POS_EnonE, na.rm=TRUE)
  non_AN_C_w_date_mean <- round(non_AN_C_w_date_mean, digits=0)
non_AN_C_w_corr <- wtd.cor(non_AN_C$datecomposition, non_AN_C$Tx_POS_EnonE, non_AN_C$Nb_POS_EnonE)
 non_AN_C_w_corr <- as.data.frame(non_AN_C_w_corr)
  non_AN_C_w_rho <- non_AN_C_w_corr$correlation
		 non_AN_C_w_rho <- round(non_AN_C_w_rho, digits=3)
		non_AN_C_w_SE <- non_AN_C_w_corr$std.err
		 non_AN_C_w_SE <- round(non_AN_C_w_SE, digits=3)
		non_AN_C_w_tvalue <- non_AN_C_w_corr$t.value
			non_AN_C_w_tvalue <- round(non_AN_C_w_tvalue, digits=3)
		non_AN_C_w_pvalue <- non_AN_C_w_corr$p.value
			# non_AN_C_w_pvalue <- round(non_AN_C_w_pvalue, digits=3)
			non_AN_C_w_pvalue <- if (non_AN_C_w_pvalue <0.005) {
																						("< 0.005")
																					} else if (non_AN_C_w_pvalue <0.05) {
																						("< 0.05")
																					} else
																						(paste("=",round(non_AN_C_w_pvalue, digits=3)))

p_non_AN_C_w <- ggplot(non_AN_C, aes(x=datecomposition, y=Tx_POS_EnonE, size=Nb_POS_EnonE)) +
 geom_point() +
 scale_size(range = c(1, 5)) +
	geom_smooth(method = "loess",
													se = FALSE,
													na.rm = TRUE,
													colour = "grey",
													span = 0.75,
													aes(weight=Nb_POS_EnonE),
												 show.legend = FALSE)  +
 geom_smooth(method = "lm",
             se = FALSE,
             na.rm = TRUE,
             colour = "grey",
             linetype = "dashed",
												 aes(weight=Nb_POS_EnonE),
												 show.legend = FALSE)  +
 theme_classic() +
	theme(legend.position = c(.95, .95),
       legend.justification = c("right", "top"),
       legend.box.just = "right",
       legend.margin = margin(6, 6, 6, 6)) +
	labs(size="Nb obs.") +
	ggtitle("A.fr. continental, #C") +
 scale_x_continuous(name="Date de composition", breaks=c(1000,
                                                         1100,
                                                         1200,
                                                         1300,
                                                         1400,
                                                         1500,
                                                         1600,
                                                         1700,
                                                         1800,
                                                         1900,
                                                         2000),
																																																limits = c(1100,1500)) +
 scale_y_continuous(limits = c(0,1),
                    name="Devant #C, taux de Ø")

p_non_AN_C_w_arrange <- p_non_AN_C_w +
annotate("rect",
									xmin = 1350,
									xmax = 1500,
									ymin = 0,
									ymax = 0.25,
									alpha = .75,
									fill="white") +
annotate("text",
									x=1450,
									y=0,
									label=paste("",non_AN_C_w_rho,"\n",
																					non_AN_C_w_pvalue,"\n",
																					non_AN_C_w_mean,"\n",
																					non_AN_C_w_median,"\n",
																					non_AN_C_w_sd,"\n",
																					non_AN_C_sum,"\n",
																					non_AN_C_w_date_mean),
									hjust=0,
									vjust=0) +
annotate("text",
									x=1425,
									y=0,
									label=paste(rho,"\n",
																					"p","\n",
																					"moy. \n",
																					"méd. \n",
																					"sd \n",
																					"nb. obs. \n",
																					"date moy."),
									hjust=1,
									vjust=0)

#-------
# non_AN_V: Non-Anglo-norman texts before V-initial word
#-------
non_AN_V$datecomposition <- as.numeric(as.character(non_AN_V$datecomposition))
non_AN_V$datemanuscrit <- as.numeric(as.character(non_AN_V$datemanuscrit))
non_AN_V$datemoyennedees <- as.numeric(as.character(non_AN_V$datemoyennedees))


non_AN_V_w_mean <- weighted.mean(non_AN_V$Tx_POS_EnonE, w = non_AN_V$Nb_POS_EnonE, na.rm=TRUE)
  non_AN_V_w_mean <- round(non_AN_V_w_mean, digits=2)
non_AN_V_w_median <- weighted.median(non_AN_V$Tx_POS_EnonE, w = non_AN_V$Nb_POS_EnonE, na.rm=TRUE)
		non_AN_V_w_median <- round(non_AN_V_w_median, digits=2)
non_AN_V_w_sd <- wtd.var(non_AN_V$Tx_POS_EnonE, w = non_AN_V$Nb_POS_EnonE, na.rm=TRUE)
  non_AN_V_w_sd <- sqrt(non_AN_V_w_sd)
  non_AN_V_w_sd <- round(non_AN_V_w_sd, digits=2)
non_AN_V_w_date_mean <- weighted.mean(non_AN_V$datecomposition, w = non_AN_V$Nb_POS_EnonE, na.rm=TRUE)
  non_AN_V_w_date_mean <- round(non_AN_V_w_date_mean, digits=0)
non_AN_V_w_corr <- wtd.cor(non_AN_V$datecomposition, non_AN_V$Tx_POS_EnonE, non_AN_V$Nb_POS_EnonE)
 non_AN_V_w_corr <- as.data.frame(non_AN_V_w_corr)
  non_AN_V_w_rho <- non_AN_V_w_corr$correlation
		 non_AN_V_w_rho <- round(non_AN_V_w_rho, digits=3)
		non_AN_V_w_SE <- non_AN_V_w_corr$std.err
		 non_AN_V_w_SE <- round(non_AN_V_w_SE, digits=3)
		non_AN_V_w_tvalue <- non_AN_V_w_corr$t.value
			non_AN_V_w_tvalue <- round(non_AN_V_w_tvalue, digits=3)
		non_AN_V_w_pvalue <- non_AN_V_w_corr$p.value
			# non_AN_V_w_pvalue <- round(non_AN_V_w_pvalue, digits=5)
			non_AN_V_w_pvalue <- if (non_AN_V_w_pvalue <0.005) {
																						("< 0.005")
																					} else if (non_AN_V_w_pvalue <0.05) {
																						("< 0.05")
																					} else
																						(paste("=",round(non_AN_V_w_pvalue, digits=3)))

p_non_AN_V_w <- ggplot(non_AN_V, aes(x=datecomposition, y=Tx_POS_EnonE, size=Nb_POS_EnonE)) +
 geom_point() +
 scale_size(range = c(1, 5)) +
	geom_smooth(method = "loess",
													se = FALSE,
													na.rm = TRUE,
													colour = "grey",
													span = 0.75,
													aes(weight=Nb_POS_EnonE),
												 show.legend = FALSE)  +
 geom_smooth(method = "lm",
             se = FALSE,
             na.rm = TRUE,
             colour = "grey",
             linetype = "dashed",
												 aes(weight=Nb_POS_EnonE),
												 show.legend = FALSE)  +
 theme_classic() +
	theme(legend.position = c(.95, .95),
       legend.justification = c("right", "top"),
       legend.box.just = "right",
       legend.margin = margin(6, 6, 6, 6)) +
	labs(size="Nb obs.") +
	ggtitle("A.fr. continental, #V") +
 scale_x_continuous(name="Date de composition", breaks=c(1000,
                                                         1100,
                                                         1200,
                                                         1300,
                                                         1400,
                                                         1500,
                                                         1600,
                                                         1700,
                                                         1800,
                                                         1900,
                                                         2000),
																																																limits = c(1100,1500)) +
 scale_y_continuous(limits = c(0,1),
                    name="Devant #V, taux de Ø")

p_non_AN_V_w_arrange <- p_non_AN_V_w +
annotate("rect",
									xmin = 1350,
									xmax = 1500,
									ymin = 0,
									ymax = 0.25,
									alpha = .75,
									fill="white") +
annotate("text",
									x=1450,
									y=0,
									label=paste("",non_AN_V_w_rho,"\n",
																					non_AN_V_w_pvalue,"\n",
																					non_AN_V_w_mean,"\n",
																					non_AN_V_w_median,"\n",
																					non_AN_V_w_sd,"\n",
																					non_AN_V_sum,"\n",
																					non_AN_V_w_date_mean),
									hjust=0,
									vjust=0) +
annotate("text",
									x=1425,
									y=0,
									label=paste(rho,"\n",
																					"p","\n",
																					"moy. \n",
																					"méd. \n",
																					"sd \n",
																					"nb. obs. \n",
																					"date moy."),
									hjust=1,
									vjust=0)



#PLOT IT!

##Merge AN_C and non_AN_C


	g_AN_C_non_AN_C <- ggarrange(	p_AN_C_w_arrange,
																p_non_AN_C_w_arrange,
	          										labels="auto",
	          										ncol = 2,
	          										nrow = 1,
										 						align = "v")

	g_AN_V_non_AN_V <- ggarrange(	p_AN_V_w_arrange,
		                            p_non_AN_V_w_arrange,
	          										labels="auto",
	          										ncol = 2,
	          										nrow = 1,
										 						align = "v")

	g_AN_non_AN_ALL <- ggarrange(	p_AN_C_w_arrange,
																p_non_AN_C_w_arrange,
																p_AN_V_w_arrange,
																p_non_AN_V_w_arrange,
																labels="auto",
																ncol=2,
																nrow=2,
																align= "v"
																)

 	g_AN_non_AN_ALL <- annotate_figure(g_AN_non_AN_ALL,
 											top =text_grob(	paste(my_var2),
 																			face = "bold",
 																			size = 14))

  g_AN_V_non_AN_V <- annotate_figure(g_AN_V_non_AN_V,
 											top =text_grob(	paste(my_var2),
 																			face = "bold",
 																			size = 14))

  g_AN_C_non_AN_C <- annotate_figure(g_AN_C_non_AN_C,
 											top =text_grob(	paste(my_var2),
 																			face = "bold",
 																			size = 14))
