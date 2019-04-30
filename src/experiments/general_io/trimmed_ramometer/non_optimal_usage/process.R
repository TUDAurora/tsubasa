library(ggplot2)
library(readr)
library(scales)
library(ggpubr)

db.axis.text <- element_text(size = 14)
db.axis.caption.text <- element_text(size = 16)

process <- function(data_in) {   
   #preprocess
   for(i in 1:nrow(data_in)) {
      prim <- data_in[i, "primitive"]
      if( prim == "Copy" ) {
         dsize <- data_in[i, "data_size"]
         data_in[i, "data_size"] <- 2 * dsize  
      }
   }
   #process
   data_out <- aggregate(time_s~primitive+bitwidth+usage+data_size+operator_repetition+usage, data=data_in, max)
   data_out$dmin <- with(data_out, (data_size/(1024*1024*1024))/time_s)
   data_out$dmax <- with( aggregate(time_s~primitive+bitwidth+usage+data_size+operator_repetition+usage, data=data_in, min), (data_size/(1024*1024*1024))/time_s)
   data_out$dmean <- with( aggregate(time_s~primitive+bitwidth+usage+data_size+operator_repetition+usage, data=data_in, mean), (data_size/(1024*1024*1024))/time_s)
   data_out$min_slowdown = 0
   data_out$max_slowdown = 0
   data_out$mean_slowdown = 0
   data_out$base_line = 0
   for(i in 1:nrow(data_out)) {
      primitive <- data_out[i, "primitive"]
      datasize <- data_out[i, "data_size"]
      usage <- data_out[i, "usage"]
      baseline <- data_out[data_out$primitive==primitive & data_out$data_size==datasize & data_out$usage==100, "dmax"]
      data_out[i, "max_slowdown"] <- baseline / data_out[i, "dmin"]
      data_out[i, "min_slowdown"] <- baseline / data_out[i, "dmax"]
      data_out[i, "mean_slowdown"] <- baseline / data_out[i, "dmean"]
      data_out[i, "base_line"] <- baseline
   }
   return(data_out)
}

df <- read_delim("Work/NEC/tsubasa/src/experiments/general_io/trimmed_ramometer/non_optimal_usage/64/out/results.csv", 
    ";", escape_double = FALSE, locale = locale(), 
    trim_ws = TRUE)

data <- aggregate(time_s~primitive+bitwidth+active_element_count+data_count+operator_repetition, data=df, mean)
data$data_size <- with(data, data_count*bitwidth/8)

data_greater_ten <- data
data_greater_ten$usage <- with(data_greater_ten, ((active_element_count/256)*100)%/%10*10)
data_greater_ten <- data_greater_ten[data_greater_ten$usage >= 10,]
data_greater_ten$throughput <- with(data_greater_ten, (data_size/(1024*1024*1024))/time_s)
data_greater_ten <- process(data_greater_ten)

data_smaller_ten <- data
data_smaller_ten$usage <- with(data_smaller_ten, ((active_element_count/256)*100)%/%1)
data_smaller_ten <- data_smaller_ten[(data_smaller_ten$usage < 10) | (data_smaller_ten$usage == 100),]
data_smaller_ten$throughput <- with(data_smaller_ten, (data_size/(1024*1024*1024))/time_s)
data_smaller_ten <- process(data_smaller_ten)
data_smaller_ten <- data_smaller_ten[data_smaller_ten$usage < 10, ]
data_smaller_ten$usage <- data_smaller_ten$usage + 1

data_extracted_greater_ten <- data_greater_ten[
   (data_greater_ten$usage == 20) |
   (data_greater_ten$usage == 40) |
   (data_greater_ten$usage == 60) |
   (data_greater_ten$usage == 80) |
   (data_greater_ten$usage == 100),]
data_extracted_greater_ten$usage <- factor(data_extracted_greater_ten$usage, levels = sort(unique(data_extracted_greater_ten$usage)),
                 labels = c(">=20%", ">=40%", ">=60%", ">=80%", "=100%"))
data_extracted_smaller_ten <- data_smaller_ten[
   (data_smaller_ten$usage == 2) |
   (data_smaller_ten$usage == 4) |
   (data_smaller_ten$usage == 6) |
   (data_smaller_ten$usage == 8) |
   (data_smaller_ten$usage == 10),]
data_extracted_smaller_ten$usage <- factor(data_extracted_smaller_ten$usage, levels = sort(unique(data_extracted_smaller_ten$usage)),
                 labels = c("<=2%", "<=4%", "<=6%", "<=8%", "<10%"))


data_greater_ten$usage <- factor(data_greater_ten$usage, levels = sort(unique(data_greater_ten$usage)),
                 labels = c(">=10%", ">=20%", ">=30%", ">=40%", ">=50%", ">=60%", ">=70%", ">=80%", ">=90%", "=100%"))
data_smaller_ten$usage <- factor(data_smaller_ten$usage, levels = sort(unique(data_smaller_ten$usage)),
                 labels = c("<=1%", "<=2%", "<=3%", "<=4%", "<=5%", "<=6%", "<=7%", "<=8%", "<=9%", "<10%"))


data_gt10_cpy = data_extracted_greater_ten[data_extracted_greater_ten$primitive=="Copy",]
data_gt10_write = data_extracted_greater_ten[data_extracted_greater_ten$primitive=="Write",]
data_gt10_read = data_extracted_greater_ten[data_extracted_greater_ten$primitive=="Read",]

data_lt10_cpy = data_extracted_smaller_ten[data_extracted_smaller_ten$primitive=="Copy",]
data_lt10_write = data_extracted_smaller_ten[data_extracted_smaller_ten$primitive=="Write",]
data_lt10_read = data_extracted_smaller_ten[data_extracted_smaller_ten$primitive=="Read",]

a <- 
      ggplot(data_gt10_cpy) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "throughput [GiB/s]", title="copy") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
a <- a + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
b <- 
      ggplot(data_gt10_write) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "throughput [GiB/s]", title="write") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
b <- b + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
c <- 
      ggplot(data_gt10_cpy) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "throughput [GiB/s]", title="read") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
c <- c + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
fig_trimmed_gt <- ggarrange(a, b, c, ncol=3, nrow=1, common.legend = TRUE, legend="bottom")



d <- 
      ggplot(data_lt10_cpy) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "throughput [GiB/s]", title="copy") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
d <- d + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
e <- 
      ggplot(data_lt10_write) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "throughput [GiB/s]", title="write") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
e <- e + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
f <- 
      ggplot(data_lt10_cpy) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "throughput [GiB/s]", title="read") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
f <- f + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
fig_trimmed_lt <- ggarrange(d, e, f, ncol=3, nrow=1, common.legend = TRUE, legend="bottom")


g <- 
      ggplot(data_gt10_cpy) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "slowdown", title="copy") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
g <- g + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
h <- 
      ggplot(data_gt10_write) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "slowdown", title="write") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
h <- h + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
i <- 
      ggplot(data_gt10_cpy) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "slowdown", title="read") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
i <- i + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
fig_trimmed_gt_sd <- ggarrange(g, h, i, ncol=3, nrow=1, common.legend = TRUE, legend="bottom")



j <- 
      ggplot(data_lt10_cpy) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "slowdown", title="copy") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))

j <- j + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
k <- 
      ggplot(data_lt10_write) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "slowdown", title="write") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
k <- k + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
l <- 
      ggplot(data_lt10_cpy) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage, color = usage)) + 
      labs(x = "buffer size [B]", y = "slowdown", title="read") + 
      theme(
         plot.title = element_text(hjust = 0.5), 
         legend.text = db.axis.caption.text, 
         axis.text = db.axis.text, 
         title = db.axis.caption.text, 
         axis.title = db.axis.caption.text, 
         panel.background = element_blank(),
         panel.grid.major = element_blank(), 
         panel.grid.minor = element_blank(),
         axis.line = element_blank(),
         panel.border = element_rect(colour = "black", fill=NA, size=0.5))
l <- l + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      ) + rremove("legend.title")
fig_trimmed_lt_sd <- ggarrange(j, k, l, ncol=3, nrow=1, common.legend = TRUE, legend="bottom")





plot_greater_ten_tmp <- 
      ggplot(data_greater_ten) +  
      geom_line(aes(x = data_size, y = dmean, group = usage, color = usage)) + 
#      geom_ribbon(aes(x = data_size, ymax = dmax, ymin = dmin), alpha = 0.6, fill = "skyblue") +
      labs(x = "DataSize [Byte]", y = "Throughput [GB/s]") + 
      theme(axis.text = db.axis.text, title = db.axis.caption.text, axis.title = db.axis.caption.text)
plot_greater_ten <- plot_greater_ten_tmp + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      )
p1 <- plot_greater_ten + facet_grid(.~primitive)

plot_greater_ten_sd_tmp <- 
      ggplot(data_greater_ten) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage)) + 
      geom_ribbon(aes(x = data_size, ymax = max_slowdown, ymin = min_slowdown), alpha = 0.6, fill = "skyblue")+
      labs(x = "DataSize [Byte]", y = "Slow down") + 
      theme(axis.text = db.axis.text, title = db.axis.caption.text, axis.title = db.axis.caption.text)
plot_greater_ten_sd <- plot_greater_ten_sd_tmp + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      )
p2 <- plot_greater_ten_sd + facet_grid(primitive~usage)



plot_smaller_ten_tmp <- 
      ggplot(data_smaller_ten) +  
      geom_line(aes(x = data_size, y = dmean, group = usage)) + 
      geom_ribbon(aes(x = data_size, ymax = dmax, ymin = dmin), alpha = 0.6, fill = "skyblue") +
      labs(x = "DataSize [Byte]", y = "Throughput [GB/s]") + 
      theme(axis.text = db.axis.text, title = db.axis.caption.text, axis.title = db.axis.caption.text)
plot_smaller_ten <- plot_smaller_ten_tmp + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      )
p3 <- plot_smaller_ten + facet_grid(primitive~usage)


plot_smaller_ten_sd_tmp <- 
      ggplot(data_smaller_ten) +  
      geom_line(aes(x = data_size, y = mean_slowdown, group = usage)) + 
      geom_ribbon(aes(x = data_size, ymax = max_slowdown, ymin = min_slowdown), alpha = 0.6, fill = "skyblue") +
      labs(x = "DataSize [Byte]", y = "Throughput [GB/s]") + 
      theme(axis.text = db.axis.text, title = db.axis.caption.text, axis.title = db.axis.caption.text)
plot_smaller_ten_sd <- plot_smaller_ten_sd_tmp + 
      scale_x_continuous(
         trans= log2_trans(),
         breaks = trans_breaks("log2", function(x) 2^x),
         labels = trans_format("log2", math_format(2^.x))
      )
p4 <- plot_smaller_ten_sd + facet_grid(primitive~usage)


