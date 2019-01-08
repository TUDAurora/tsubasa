library(readr)
library( ggplot2 )

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
	library(grid)

	# Make a list from the ... arguments and plotlist
	plots <- c(list(...), plotlist)

	numPlots = length(plots)

	# If layout is NULL, then use 'cols' to determine layout
	if (is.null(layout)) {
		# Make the panel
		# ncol: Number of columns of plots
		# nrow: Number of rows needed, calculated from # of cols
		layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
		ncol = cols, nrow = ceiling(numPlots/cols))
	}

	if (numPlots==1) {
		print(plots[[1]])

	} else {
		# Set up the page
		grid.newpage()
		pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

		# Make each plot, in the correct location
		for (i in 1:numPlots) {
			# Get the i,j matrix positions of the regions that contain this subplot
			matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

			print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
			layout.pos.col = matchidx$col))
		}
	}
}




cbPalette <- c("#eb3b5a", "#fa8231", "#f7b731", "#20bf6b", "#0fb9b1", "#2d98da", "#3867d6", "#8854d0")
df <- read_delim("~/work/projects/nec/general/experiment_results/const_size_hash_histogramm/hash_set_experiment_results.csv", ";", escape_double = FALSE, trim_ws = TRUE, comment = "#")
df$mips <- with( df, ( DataCount / ( TimeMs / 1000) / 1000000))

l1_df<-dplyr::filter(df, DataCount == 8000)
l2_df<-dplyr::filter(df, DataCount == 64000)
l3_df<-dplyr::filter(df, DataCount == 4096000)
# Blob400Mb_df<-dplyr::filter(df, DataCount == 100000000)
# Blob2Gb_df<-dplyr::filter(df, DataCount == 500000000)

l1_mean <- aggregate( mips ~ Variant + LoadFactor, data=l1_df, mean)
l2_mean <- aggregate( mips ~ Variant + LoadFactor, data=l2_df, mean)
l3_mean <- aggregate( mips ~ Variant + LoadFactor, data=l3_df, mean)
# Blob400Mb_mean <- aggregate( mips ~ Variant + LoadFactor, data=Blob400Mb_df, mean)
# Blob2Gb_mean <- aggregate( mips ~ Variant + LoadFactor, data=Blob2Gb_df, mean)

speed_plot_l1 <- ggplot( data = l1_mean, aes( x=LoadFactor, y=mips, colour=Variant)) +
				  geom_line()+ theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
	   			 scale_colour_manual(values=cbPalette) + labs(caption="(a) Inserted Data fits in L1.")
speed_plot_l2 <- ggplot( data = l2_mean, aes( x=LoadFactor, y=mips, colour=Variant)) +
				  geom_line()+ theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
				 scale_colour_manual(values=cbPalette) + labs(caption="(b) Inserted Data fits in L2.")
speed_plot_l3 <- ggplot( data = l3_mean, aes( x=LoadFactor, y=mips, colour=Variant)) +
				  geom_line()+ theme_minimal() +  theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
				 scale_colour_manual(values=cbPalette) + labs(caption="(c) Inserted Data fits in LLC.")
# speed_plot_Blob400Mb <- ggplot( data = Blob400Mb_mean, aes( x=LoadFactor, y=mips, colour=Variant)) +
# 						geom_point() + geom_line()+ theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
# 						scale_colour_manual(values=cbPalette) + labs(caption="(d) Inserted Data does not fit in Cache (400MB).")
# speed_plot_Blob2Gb <- ggplot( data = Blob2Gb_mean, aes( x=LoadFactor, y=mips, colour=Variant)) +
# 					  geom_point() + geom_line()+ theme_minimal() +  theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
# 					  scale_colour_manual(values=cbPalette) + labs(caption="(e) Inserted Data does not fit in Cache (2GB).")

# speed_plot <- multiplot(speed_plot_l1, speed_plot_l3, speed_plot_Blob2Gb, speed_plot_l2, speed_plot_Blob400Mb, cols=2)
speed_plot <- multiplot(speed_plot_l1, speed_plot_l3, speed_plot_l2, cols=2)


l1_mean$speedup <- 0
l2_mean$speedup <- 0
l3_mean$speedup <- 0
# Blob400Mb_mean$speedup <- 0
# Blob2Gb_mean$speedup <- 0

for( row in 1:nrow( l1_mean ) ) {
	lf <- l1_mean[ row, "LoadFactor" ]
	baseline <- l1_mean[ which( l1_mean$Variant=='SCALAR_ELEM' & l1_mean$LoadFactor==lf ), "mips" ]
	l1_mean[ row, "speedup"  ] = l1_mean[ row, "mips" ] / baseline
}
for( row in 1:nrow( l2_mean ) ) {
	lf <- l2_mean[ row, "LoadFactor" ]
	baseline <- l2_mean[ which( l2_mean$Variant=='SCALAR_ELEM' & l2_mean$LoadFactor==lf ), "mips" ]
	l2_mean[ row, "speedup"  ] = l2_mean[ row, "mips" ] / baseline
}
for( row in 1:nrow( l3_mean ) ) {
	lf <- l3_mean[ row, "LoadFactor" ]
	baseline <- l3_mean[ which( l3_mean$Variant=='SCALAR_ELEM' & l3_mean$LoadFactor==lf ), "mips" ]
	l3_mean[ row, "speedup"  ] = l3_mean[ row, "mips" ] / baseline
}
# for( row in 1:nrow( Blob400Mb_mean ) ) {
# 	lf <- Blob400Mb_mean[ row, "LoadFactor" ]
# 	baseline <- Blob400Mb_mean[ which( Blob400Mb_mean$Variant=='SCALAR_ELEM' & Blob400Mb_mean$LoadFactor==lf ), "mips" ]
# 	Blob400Mb_mean[ row, "speedup"  ] = Blob400Mb_mean[ row, "mips" ] / baseline
# }
# for( row in 1:nrow( Blob2Gb_mean ) ) {
# 	lf <- Blob2Gb_mean[ row, "LoadFactor" ]
# 	baseline <- Blob2Gb_mean[ which( Blob2Gb_mean$Variant=='SCALAR_ELEM' & Blob2Gb_mean$LoadFactor==lf ), "mips" ]
# 	Blob2Gb_mean[ row, "speedup"  ] = Blob2Gb_mean[ row, "mips" ] / baseline
# }

l1_mean_high <- subset( l1_mean, l1_mean$LoadFactor>=90 )
l2_mean_high <- subset( l2_mean, l2_mean$LoadFactor>=90 )
l3_mean_high <- subset( l3_mean, l3_mean$LoadFactor>=90 )
# Blob400Mb_mean_high <- subset( Blob400Mb_mean, Blob400Mb_mean$LoadFactor>=90 )
# Blob2Gb_mean_high <- subset( Blob2Gb_mean, Blob2Gb_mean$LoadFactor>=90 )

speedup_plot_l1 <- ggplot( data = l1_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
				   geom_bar(stat="identity", position=position_dodge()) +
				   theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
	               scale_fill_manual(values=cbPalette) + labs(caption="(a) Inserted Data fits in L1.")
speedup_plot_l2 <- ggplot( data = l2_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
				   geom_bar(stat="identity", position=position_dodge()) +
				   theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
				   scale_fill_manual(values=cbPalette) + labs(caption="(b) Inserted Data fits in L2.")
speedup_plot_l3 <- ggplot( data = l3_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
				   geom_bar(stat="identity", position=position_dodge()) +
				   theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
				   scale_fill_manual(values=cbPalette) + labs(caption="(c) Inserted Data fits in L3.")
# speedup_plot_Blob400Mb <- ggplot( data = Blob400Mb_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
# 						  geom_bar(stat="identity", position=position_dodge()) +
# 						  theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
# 						  scale_fill_manual(values=cbPalette) + labs(caption="(d) Inserted Data does not fit in Cache (400MB).")
# speedup_plot_Blob2Gb <- ggplot( data = Blob2Gb_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
# 						geom_bar(stat="identity", position=position_dodge()) +
# 						theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
# 						scale_fill_manual(values=cbPalette) + labs(caption="(e) Inserted Data does not fit in Cache (2GB).")
speedup1_plot <- multiplot(speedup_plot_l1, speedup_plot_l3, speedup_plot_l2, cols=2)

l1_mean_low <- subset( l1_mean, l1_mean$LoadFactor<=90 )
l2_mean_low <- subset( l2_mean, l2_mean$LoadFactor<=90 )
l3_mean_low <- subset( l3_mean, l3_mean$LoadFactor<=90 )
# Blob400Mb_mean_high <- subset( Blob400Mb_mean, Blob400Mb_mean$LoadFactor>=90 )
# Blob2Gb_mean_high <- subset( Blob2Gb_mean, Blob2Gb_mean$LoadFactor>=90 )

speedup2_plot_l1 <- ggplot( data = l1_mean_low, aes( x=LoadFactor, y=speedup, fill=Variant)) +
	geom_bar(stat="identity", position=position_dodge()) +
	theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
	scale_fill_manual(values=cbPalette) + labs(caption="(a) Inserted Data fits in L1.")
speedup2_plot_l2 <- ggplot( data = l2_mean_low, aes( x=LoadFactor, y=speedup, fill=Variant)) +
	geom_bar(stat="identity", position=position_dodge()) +
	theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
	scale_fill_manual(values=cbPalette) + labs(caption="(b) Inserted Data fits in L2.")
speedup2_plot_l3 <- ggplot( data = l3_mean_low, aes( x=LoadFactor, y=speedup, fill=Variant)) +
	geom_bar(stat="identity", position=position_dodge()) +
	theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
	scale_fill_manual(values=cbPalette) + labs(caption="(c) Inserted Data fits in L3.")
# speedup_plot_Blob400Mb <- ggplot( data = Blob400Mb_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
# 						  geom_bar(stat="identity", position=position_dodge()) +
# 						  theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
# 						  scale_fill_manual(values=cbPalette) + labs(caption="(d) Inserted Data does not fit in Cache (400MB).")
# speedup_plot_Blob2Gb <- ggplot( data = Blob2Gb_mean_high, aes( x=LoadFactor, y=speedup, fill=Variant)) +
# 						geom_bar(stat="identity", position=position_dodge()) +
# 						theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
# 						scale_fill_manual(values=cbPalette) + labs(caption="(e) Inserted Data does not fit in Cache (2GB).")
speedup2_plot <- multiplot(speedup2_plot_l1, speedup2_plot_l3, speedup2_plot_l2, cols=2)