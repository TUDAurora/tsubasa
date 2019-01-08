if(!require( "readr" )) {
    install.packages("readr", dependencies = TRUE)
    require(readr)
}
if(!require( "ggplot2" )) {
    install.packages("ggplot2", dependencies = TRUE)
    require(ggplot2)
}
if(!require( "scales" )) {
    install.packages("scales", dependencies = TRUE)
    require(scales)
}


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




cbPalette9 <- c("#eb3b5a", "#fa8231", "#f7b731", "#20bf6b", "#0fb9b1", "#2d98da", "#3867d6", "#8854d0", "#a5b1c2")
cbPallete6 <- c("#eb3b5a", "#f7b731", "#45aaf2", "#a55eea", "#20bf6b", "#a5b1c2")
cbPalette3 <- c("#20bf6b", "#f7b731", "#eb3b5a")
Variant_Labeler <- c(
seq = "w/o Autovectorization",
vec = "w/ Autovectorization"
)

BitWidth_Labeler <- c(
'32' = "32-bit Elements",
'64' = "64-bit Elements"
)

size_array<- c(
    '4096' = "Half L1 (4'096 Elements)",
    '8192' = "L1 (8'192 Elements)",
    '32768' = "Half L2 (32'768 Elements)",
    '65536' = "L2 (65'536 Elements)",
    '2097152' = "Half LLC (2'097'152 Elements)",
    '4194304' = "LLC (4'194'304 Elements)",
    '134217728' = "RAM (134'217'728 Elements)"
)

size_array_names<- c(
    '4096' = "0.5_L1",
    '8192' = "1.0_L1",
    '32768' = "0.5_L2",
    '65536' = "1.0_L2",
    '2097152' = "0.5_LLC",
    '4194304' = "1.0_LLC",
    '134217728' = "n_BLOB"
)
size_array_axis <- c(
        '4096' = "16K",
        '8192' = "32K",
        '32768' = "128K",
        '65536' = "256K",
        '2097152' = "8M",
        '4194304' = "16M",
        '134217728' = "400M"
    )
operation_array_names <- c(
    "eq" = "== ?",
    "neq" = "!= ?",
    "leq" = "<= ?",
    "lt" = "< ?",
    "gt" = "> ?",
    "geq" = ">= ?"
)


operation_list <- function( dataframe ) {
	eq_df<-dplyr::filter(dataframe, Operation == "eq")
	neq_df<-dplyr::filter(dataframe, Operation == "neq")
	leq_df<-dplyr::filter(dataframe, Operation == "leq")
	lt_df<-dplyr::filter(dataframe, Operation == "lt")
	gt_df<-dplyr::filter(dataframe, Operation == "gt")
	geq_df<-dplyr::filter(dataframe, Operation == "geq")
	return(list( eq=eq_df, neq=neq_df, leq=leq_df, lt=lt_df, gt=gt_df, geq=geq_df) )
}

get_data_all_list <- function( dataframe ) {
    
    df_aggr <- aggregate(
        mips ~ Operation + Variant + BitWidth + DataCount + CodeSize + VectorElemCount + ThreadCount,
        data=dataframe, mean)
    df_aggr$DataCountLabel <- ""
    for( row in 1:nrow( df_aggr ) ) {
        df_aggr[ row, "DataCountLabel" ] = size_array_axis[ as.character( df_aggr[ row, "DataCount" ] ) ]
    }

    df_max <- aggregate(
        mips ~ Operation + Variant + BitWidth + DataCount + DataCountLabel,
        data=df_aggr, max)
    df_max$info <- "MAX"
    df_min <- aggregate(
        mips ~ Operation + Variant + BitWidth + DataCount + DataCountLabel,
        data=df_aggr, min)
    df_min$info <- "MIN"
    df_mean <- aggregate(
        mips ~ Operation + Variant + BitWidth + DataCount + DataCountLabel,
        data=df_aggr, mean)
    df_mean$info <- "MEAN"
    df_stats <- rbind(
        df_max,
        df_min,
        df_mean
    )
    return( operation_list( df_stats ) )
}


get_data_list <- function( dataframe, dc ) {
	subset_dc<-dplyr::filter(dataframe, DataCount == dc)
	subset_dc_mean <- aggregate(
		mips ~ Operation + Variant + BitWidth + DataCount + CodeSize + VectorElemCount + ThreadCount,
		data=subset_dc, mean)

	subset_dc_max <- merge(
		aggregate( mips ~ Operation + Variant + BitWidth + CodeSize + VectorElemCount, data=subset_dc_mean, max),
		subset_dc_mean,
		by=c("Operation", "Variant", "BitWidth", "CodeSize", "VectorElemCount", "mips") )

	subset_dc_median <- aggregate( mips ~ Operation + Variant + BitWidth + CodeSize + VectorElemCount, data=subset_dc_mean, mean)
	subset_dc_median$ThreadCount <- 0
    subset_dc_median$DataCount <- dc
	for( row in 1:nrow( subset_dc_median ) ) {
	   	speed <- subset_dc_median[ row, "mips" ]
		operation <- subset_dc_median[ row, "Operation" ]
		variant <- subset_dc_median[ row, "Variant" ]
		bitwidth <- subset_dc_median[ row, "BitWidth" ]
		codesize <- subset_dc_median[ row, "CodeSize" ]
		vecelemcount <- subset_dc_median[ row, "VectorElemCount" ]

	   	baseline <- subset_dc_mean[ which(
			subset_dc_mean$Operation==operation &
			subset_dc_mean$Variant==variant &
			subset_dc_mean$BitWidth==bitwidth &
			subset_dc_mean$CodeSize==codesize &
			subset_dc_mean$VectorElemCount==vecelemcount), ]
		for( rowbase in 1:nrow( baseline ) ) {
			baseline[ rowbase, "mips" ] = ( speed - baseline[ rowbase, "mips" ] ) * ( speed - baseline[ rowbase, "mips" ] )
		}

		subset_dc_median[ row, "ThreadCount" ] = median(baseline[ baseline$mips == min(baseline[, "mips"]), "ThreadCount"])
		#is this bullshit with the median? with new compiler (nc++1.6) different thread-counts lead to same mips
	}
	subset_dc_min <- merge(
		aggregate( mips ~ Operation + Variant + BitWidth + CodeSize + VectorElemCount, data=subset_dc_mean, min),
		subset_dc_mean,
		by=c("Operation", "Variant", "BitWidth", "CodeSize", "VectorElemCount", "mips") )

    tmp_max_nocodesize <- aggregate( mips ~ Operation + Variant + BitWidth + VectorElemCount + DataCount, data=subset_dc_max, max)
    tmp_max_nocodesize$info <- "MAX"
    tmp_mean_nocodesize <- aggregate( mips ~ Operation + Variant + BitWidth + VectorElemCount + DataCount, data=subset_dc_mean, mean)
    tmp_mean_nocodesize$info <- "MEAN"
    tmp_min_nocodesize <- aggregate( mips ~ Operation + Variant + BitWidth + VectorElemCount + DataCount, data=subset_dc_mean, min)
    tmp_min_nocodesize$info <- "MIN"
    subset_dc_min_max_nocodesize <- rbind(
        tmp_max_nocodesize,
        tmp_mean_nocodesize,
        tmp_min_nocodesize
    )
    subset_dc_min_max_nocodesize$speedup_to_min <- 1
    subset_dc_min_max_nocodesize$speedup_vec <- 1
    for( row in 1:nrow( subset_dc_min_max_nocodesize ) ) {
        speed <- subset_dc_min_max_nocodesize[ row, "mips" ]
        operation <- subset_dc_min_max_nocodesize[ row, "Operation" ]
        variant <- subset_dc_min_max_nocodesize[ row, "Variant" ]
        bitwidth <- subset_dc_min_max_nocodesize[ row, "BitWidth" ]
        vecelemcount <- subset_dc_min_max_nocodesize[ row, "VectorElemCount" ]
        datacount <- subset_dc_min_max_nocodesize[ row, "DataCount" ]
        info <- subset_dc_min_max_nocodesize[ row, "info"]
        if( info != "MIN" ) {
            baseline <- subset_dc_min_max_nocodesize[ which(
                subset_dc_min_max_nocodesize$Operation==operation &
                subset_dc_min_max_nocodesize$Variant==variant &
                subset_dc_min_max_nocodesize$BitWidth==bitwidth &
                subset_dc_min_max_nocodesize$VectorElemCount==vecelemcount &
                subset_dc_min_max_nocodesize$DataCount==datacount &
                subset_dc_min_max_nocodesize$info == "MIN" ), "mips"]
            subset_dc_min_max_nocodesize[ row, "speedup_to_min" ] <- speed / baseline
        }

        if( variant != "seq" ) {
            seq_baseline <- subset_dc_min_max_nocodesize[ which(
                subset_dc_min_max_nocodesize$Operation==operation &
                subset_dc_min_max_nocodesize$BitWidth==bitwidth &
                subset_dc_min_max_nocodesize$VectorElemCount==vecelemcount &
                subset_dc_min_max_nocodesize$DataCount==datacount &
                subset_dc_min_max_nocodesize$info == info &
                subset_dc_min_max_nocodesize$Variant == "seq" ), "mips"]
            subset_dc_min_max_nocodesize[ row, "speedup_vec" ] = speed / seq_baseline
        }
    }

	return( list(
		speed=operation_list( subset_dc_mean ),
		max=operation_list( subset_dc_max),
		mean=operation_list( subset_dc_median ),
		min=operation_list( subset_dc_min ),
        stats=operation_list( subset_dc_min_max_nocodesize )
	))
}

barplot_codesize_vectorelem <- function( dataframe, cap, out ) {
	pl <-   ggplot(
                    data = dataframe,
                    aes(    x=CodeSize,
                            y=ThreadCount,
                            fill=as.factor( VectorElemCount )
                    )
                ) +
                geom_bar( stat="identity", position="dodge2") +
                #, scales = "free"
                facet_wrap( ~Variant+BitWidth, labeller=labeller( Variant = Variant_Labeler, BitWidth = BitWidth_Labeler)) +
                scale_fill_manual(values=cbPalette9) + scale_x_continuous(trans=log2_trans()) +
                theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
                labs(caption= cap, x="Code Size (log scale)", y="# of threads", fill="Size of vectors")
	ggsave( filename=out , plot=pl, width = 13, height = 9 )
}

speedplot_vectorelem_codesize <- function( dataframe, cap, out ) {
	pl <-   ggplot(
                    data = dataframe,
                    aes(    x = VectorElemCount,
                            y = mips,
                            colour = as.factor( CodeSize )
                    )
                ) +
                geom_line() +
                #, scales = "free"
                facet_wrap( ~Variant+BitWidth, labeller=labeller( Variant = Variant_Labeler, BitWidth = BitWidth_Labeler)) +
                scale_colour_manual(values=cbPallete6) + scale_x_continuous(trans=log2_trans()) +
                theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
                labs(caption= cap, x="Vector Size (log scale)", y="Performance [mips]", colour="Code Size")
    ggsave( filename=out , plot=pl, width = 13, height = 9 )
}



speedupplot_stats_vectorelem <- function( dataframe, cap, out ) {
    pl <-   ggplot(
                    data = dataframe[ which( dataframe$info != "MIN"), ],
                    aes(    x = VectorElemCount,
                            y = speedup_to_min,
                            fill=as.factor( info )
                    )
                ) +
                geom_bar( stat="identity", position="dodge2") +
                #, scales = "free"
                facet_wrap( ~Variant+BitWidth, labeller=labeller( Variant = Variant_Labeler, BitWidth = BitWidth_Labeler)) +
                scale_fill_manual(values=cbPalette3) + scale_x_continuous(trans=log2_trans()) +
                theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
                labs(caption= cap, x="Vector Size (log scale)", y="Speedup", fill="")

    ggsave( filename=out , plot=pl, width = 13, height = 9 )
}

#this does not make sense yet, since we don't know the effects of multithreading
speedupplot_stats_vectorelem_vectorize <- function( dataframe, cap, out ) {
    pl <-   ggplot(
                    data = dataframe[ which( dataframe$Variant != "seq"), ],
                    aes(    x = VectorElemCount,
                            y = speedup_vec,
                            fill=as.factor( info )
                        )
                    ) +
                    geom_bar( stat="identity", position="dodge2") +
                    #, scales = "free"
                    facet_wrap( ~BitWidth, labeller=labeller( BitWidth = BitWidth_Labeler)) +
                    scale_fill_manual(values=cbPalette3) + scale_x_continuous(trans=log2_trans()) +
                    theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
                    labs(caption= cap, x="Vector Size (log scale)", y="Speedup", fill="")

    ggsave( filename=out , plot=pl, width = 13, height = 9 )
}

speedplot_total <- function( dataframe, cap, out ) {
    max_mips <- data.frame(aggregate( mips~Variant+BitWidth, data=dataframe, max ))
    min_mips <- data.frame(aggregate( mips~Variant+BitWidth, data=dataframe, min ))
    mean_mips <- data.frame(aggregate( mips~Variant+BitWidth, data=dataframe, min ))
    for( row in 1:nrow( mean_mips ) ) {
        mean_mips[ row, "mips" ] <- ( max_mips[ row, "mips" ] - min_mips[ row, "mips" ] ) / 2
    }

    pl <-   ggplot(
                    data = dataframe,
                    aes(    x = DataCount,
                            y = mips,
                            colour = as.factor( info )
                    )
                ) +
                geom_line() +
                #, scales = "free"
                facet_wrap( ~Variant + BitWidth, labeller=labeller( Variant = Variant_Labeler, BitWidth = BitWidth_Labeler)) +
                scale_colour_manual(values=cbPalette3) + scale_x_continuous(trans=log2_trans()) +
                geom_vline(xintercept = 8192, linetype=2) +
                geom_vline(xintercept = 65536, linetype=2) +
                geom_vline(xintercept = 4194304, linetype=2) +
                geom_vline(xintercept = 134217728, linetype=2) +
                geom_text( data = mean_mips, inherit.aes=FALSE, aes(x = 4296, y=mips ), label = "<=L1", size=3)+
                geom_text( data = mean_mips, inherit.aes=FALSE, aes(x = 19214, y=mips ), label = "<=L2", size=3)+
                geom_text( data = mean_mips, inherit.aes=FALSE, aes(x = 2064384/5, y=mips ), label = "<=LLC", size=3)+
                geom_text( data = mean_mips, inherit.aes=FALSE, aes(x = 65011712/3, y=mips ), label = ">LLC", size=3)+
                theme_minimal() + theme(plot.caption = element_text(hjust=0.5, size=rel(1.2))) +
                labs(caption= cap, x="Processed Data Size (log scale)", y="Performance [mips]", colour="")


    ggsave( filename=out , plot=pl )
}

create_images <- function( outdir, dataframe, dc, operation ) {
	list_of_df <-  get_data_list( dataframe, dc )
	print( paste("Processing Operator", operation_array_names[operation], "Size:", size_array[as.character(dc)]))
	size_string <- size_array[ as.character(dc) ]
	dir.create(file.path(outdir, size_array_names[ as.character( dc ) ]), showWarnings = FALSE)
	dir.create(file.path(outdir, size_array_names[ as.character( dc ) ], "threads"), showWarnings = FALSE)
	dir.create(file.path(outdir, size_array_names[ as.character( dc ) ], "mips"), showWarnings = FALSE)
    dir.create(file.path(outdir, size_array_names[ as.character( dc ) ], "speedup"), showWarnings = FALSE)

    barplot_codesize_vectorelem(
		list_of_df[["max"]][[operation]],
		paste(	"Amount of threads wich results in best performance with ",
				"respect to different vector sizes for Bitweaving-H (operation: ",
				operation_array_names[[operation]], ").\n",
				"The processed data fits into ",  size_string , ".", sep=""
		),
		paste(	outdir, size_array_names[ as.character( dc ) ], "/threads/", operation, "_max.svg", sep="" )
	)

    barplot_codesize_vectorelem(
		list_of_df[["mean"]][[operation]],
        paste(	"Amount of threads wich results in mean performance with ",
		    "respect to different vector sizes for Bitweaving-H (operation: ",
    		operation_array_names[[operation]], ").\n",
    		"The processed data fits into ",  size_string , ".", sep=""
		),
		paste(	outdir, size_array_names[ as.character( dc ) ], "/threads/", operation, "_mean.svg", sep="" )
	)

    barplot_codesize_vectorelem(
		list_of_df[["min"]][[operation]],
		paste(	"Amount of threads wich results in worst performance with ",
		    "respect to different vector sizes for Bitweaving-H (operation: ",
		    operation_array_names[[operation]], ").\n",
		    "The processed data fits into ",  size_string , ".", sep=""
		),
		paste(	outdir, size_array_names[ as.character( dc ) ], "/threads/", operation, "_min.svg", sep="" )
	)

    speedplot_vectorelem_codesize(
        list_of_df[["max"]][[operation]],
        paste(  "Best performance (independent from threadcount) with ",
            "respect to code and vector sizes for Bitweaving-H (operation: ",
            operation_array_names[[operation]], ").\n",
            "The processed data fits into ",  size_string , ".", sep=""
        ),
        paste(	outdir, size_array_names[ as.character( dc ) ], "/mips/", operation, "_max.svg", sep="" )
    )

    speedplot_vectorelem_codesize(
        list_of_df[["mean"]][[operation]],
        paste(  "Mean performance (independent from threadcount) with ",
            "respect to code and vector sizes for Bitweaving-H (operation: ",
            operation_array_names[[operation]], ").\n",
            "The processed data fits into ",  size_string , ".", sep=""
        ),
        paste(	outdir, size_array_names[ as.character( dc ) ], "/mips/", operation, "_mean.svg", sep="" )
    )

    speedplot_vectorelem_codesize(
        list_of_df[["min"]][[operation]],
        paste(  "Worst performance (independent from threadcount) with ",
            "respect to code and vector sizes for Bitweaving-H (operation: ",
            operation_array_names[[operation]], ").\n",
            "The processed data fits into ",  size_string , ".", sep=""
        ),
        paste(	outdir, size_array_names[ as.character( dc ) ], "/mips/", operation, "_min.svg", sep="" )
    )


    speedupplot_stats_vectorelem(
        list_of_df[["stats"]][[operation]],
        paste(  "Max/Mean Speedup (independent from threadcount and code size) with ",
                "respect to vector sizes for Bitweaving-H (operation: ",
                operation_array_names[[operation]], ").\n",
                "The processed data fits into ",  size_string , ".", sep=""
        ),
        paste(	outdir, size_array_names[ as.character( dc ) ], "/speedup/", operation, "_stats_speedup.svg", sep="" )
    )

    #this does not make sense yet, since we don't know the effects of multithreading
    #speedupplot_stats_vectorelem_vectorize...


}

create_all_speed_images <- function( outdir, general_df, operation ) {
    speedplot_total(
        general_df[[operation]],
        paste(  "Max/Mean/Min Performance overall measurements with ",
                "respect to data sizes for Bitweaving-H (operation: ",
                operation_array_names[[operation]], ").", sep=""
        ),
        paste(	outdir, operation, "_best", sep="" )
    )
}

create_images_all_operations <- function( outdir, dataframe, dc ) {
	#create_images( outdir, dataframe, dc, "eq" )
	#create_images( outdir, dataframe, dc, "neq" )
	#create_images( outdir, dataframe, dc, "leq" )
	#create_images( outdir, dataframe, dc, "lt" )
	create_images( outdir, dataframe, dc, "gt" )
	#create_images( outdir, dataframe, dc, "geq" )
}

create_images_all_sizes <- function( outdir, dataframe ) {
    general_df <- get_data_all_list( dataframe )
    #create_all_speed_images( outdir, general_df, "eq" )
    #create_all_speed_images( outdir, general_df, "neq" )
    #create_all_speed_images( outdir, general_df, "leq" )
    #create_all_speed_images( outdir, general_df, "lt" )
    #create_all_speed_images( outdir, general_df, "gt" )
    #create_all_speed_images( outdir, general_df, "geq" )
    
	#create_images_all_operations( outdir, dataframe,      4096 )
	#create_images_all_operations( outdir, dataframe,      8192 )
	#create_images_all_operations( outdir, dataframe,     32768 )
	#create_images_all_operations( outdir, dataframe,     65536 )
	#create_images_all_operations( outdir, dataframe,   2097152 )
	#create_images_all_operations( outdir, dataframe,   4194304 )
	create_images_all_operations( outdir, dataframe, 134217728 )

}


process <- function( indir, outdir, file ) {
	df <- read_delim(paste( indir, file, sep="/" ), ";", escape_double = FALSE, trim_ws = TRUE, comment = "#")
	df$mips <- with( df, ( DataCount / ( TimeMs / 1000) / 1000000))

	create_images_all_sizes( outdir, df )
}

process_1_5 <- function( ) {
	basepath <- "~/work/projects/nec/general/experiment_results/bitweaving/"
	outdir <- "~/work/projects/nec/general/experiment_results/bitweaving/ncc1.5/"
	dir.create(file.path(basepath, "ncc1.5"), showWarnings = FALSE)
	process( basepath, outdir, "bitweaving_results_nc++_1.5_all.csv" )
}

process_1_6 <- function( ) {
	basepath <- "~/work/projects/nec/general/experiment_results/bitweaving/"
	outdir <- "~/work/projects/nec/general/experiment_results/bitweaving/ncc1.6/"
	dir.create(file.path(basepath, "ncc1.6"), showWarnings = FALSE)
	process( basepath, outdir, "bitweaving_results_nc++_1.6_all.csv" )
}

process_all <- function( ) {
	process_1_5()
	process_1_6()
}