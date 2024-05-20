#Script to save plots as PDFs



#Save arranged plots
ggsave(	g_AN_non_AN_ALL,
	  	path = "Graphs",
		filename = paste(my_var,"AN_non_AN.pdf"),
		device=cairo_pdf,
		width = 9,
		height = 9,
		units = "in")

ggsave(	g_AN_V_non_AN_V,
	  	path = "Graphs",
		filename = paste(my_var,"AN_non_AN_V.pdf"),
		device=cairo_pdf,
		width = 9,
		height = 5,
		units = "in")

ggsave(	g_AN_C_non_AN_C,
	  	path = "Graphs",
		filename = paste(my_var,"AN_non_AN_C.pdf"),
		device=cairo_pdf,
		width = 9,
		height = 5,
		units = "in")


