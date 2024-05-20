#Script to save as PDF files the maps produced by A8_carto.R

ggsave(plot2_V_no_min,
	      path = "Graphs",
							filename = paste(my_var,"map_V_no_min.pdf"),
							width = 25,
						 height = 19.5,
						 units = "cm",
						 scale = 1,
						 dpi = "retina",
							device = cairo_pdf)

ggsave(plot2_C_no_min,
	      path = "Graphs",
							filename = paste(my_var,"map_C_no_min.pdf"),
							width = 25,
						 height = 19.5,
						 units = "cm",
						 scale= 1,
						 dpi = "retina",
							device = cairo_pdf)

ggsave(plot2_CV_no_min,
	      path = "Graphs",
							filename = paste(my_var,"map_ALL_no_min.pdf"),
							width = 25,
						 height = 39,
						 units = "cm",
						 scale= 1,
						 dpi = "retina",
							device = cairo_pdf)

ggsave(plot2_W_no_min,
	      path = "Graphs",
							filename = paste(my_var,"map_elision_weight_no_min.pdf"),
							width = 25,
						 height = 19.5,
						 units = "cm",
						 scale= 1,
						 dpi = "retina",
							device = cairo_pdf)
