#' @import ggplot2
#' @import gridExtra
#' @importFrom grid textGrob
#' @importFrom grid gpar
#' 
#' 

#function (not exported) to open a graph window depending on the operative system
.open_window <- function() {
  os <- Sys.info()["sysname"]
  
  if (os == "Windows") {
    windows()
  } else if (os == "Darwin") { 
    quartz()
  } else { 
    x11()
  }
}

#first input: result from KO
#second input: result from hp check KO
#third input: true if you want to plot real values of alpha, false if you prefer using them equispaced (vis purposes)
KO_show_results <- function( results_ko, hp_ko=NULL, x_lab="x", y_lab="y", true_alphas=FALSE){
  
  #length of results_ko if error saved
  lenght_res_with_er = 18
  
  #checking correct input by their dimension
  if (length(results_ko) == 0) {
    stop("First parameter (results_ko) must not be NULL")
  } else{
    if(length(results_ko)!=lenght_res_with_er && length(results_ko)!=(lenght_res_with_er-1)){
      stop("results_ko could not come from KO")
    }
    cat("\n")
    cat("Results of KO algorithm")
    cat("\n")
  }
  
  
  
  #Print parameters found: alpha, number of PPCs and Explanatory power
  cat("\n")
  cat("Alpha:", results_ko$Alpha, "\n")
  cat("\n")
  cat("Number of PPCs retained:", results_ko$`Number of PPCs retained`, "\n")
  cat("\n")
  
  exp_pw = data.frame(
    m = results_ko$`Explanatory power PPCs`
  )
  colnames(exp_pw) = "Explanatory power"
  print(exp_pw)
  cat("\n")
  
  
  
  #Plot pvalues of ADF
  if(!(is.null(hp_ko))){
    
    if(length(hp_ko)!=1){ stop("Second parameter (hp_ko) could be not from hp-check KO")}
    
    data_hp <- data.frame( x = results_ko$`Function discrete evaluations points`, y = hp_ko$`P-values ADF`)
    
    plot_pvalues <- ggplot(data_hp, aes(x = x, y = y, fill = y)) +
                    geom_bar( stat = "identity", color = "black" ) +  # 'stat = "identity"' per utilizzare i valori di y
                    geom_text( data = subset(data_hp, is.na(y)), aes(label = "*", y = 0), color = "yellow", size = 3 ) +
                    scale_fill_gradient2( low = "blue", mid="white", high = "red", midpoint = 0.1 ) +
                    labs( title = "Pointwise ADF test p-value", x = x_lab, y = "Value" ) +
                    geom_hline( yintercept = c(0.01,0.05,0.1), color = "red" ) + 
                    theme_minimal() + 
                    theme( plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                           panel.grid.major.x = element_line( color = "gray", linewidth = 0.1) )
    
    .open_window()
    print(plot_pvalues)}
  
  
  
  #Plot one step ahead prediction and comparison with last available instant
  data_pred <- data.frame(x = results_ko$`Function discrete evaluations points`,
                          y = c(results_ko$`One-step ahead prediction`, results_ko$f_n),
                          function_type = factor(rep(c("f_n+1", "f_n"), each = length(results_ko$`Function discrete evaluations points`))))
  
  plot_pred <- ggplot(data_pred, aes(x = x, y = y, color = function_type)) +
               geom_line( size = 1.2 ) +
               scale_color_manual( values = c("f_n+1" = "blue", "f_n" = "black"), labels = c(TeX("$f_{n}$"), TeX("$f_{n+1}$")) ) +
               labs(color = "Time instant") +  
               labs( x = x_lab, y = y_lab ) +
               labs(title = "One step ahead prediction") + 
               theme_minimal() +
               theme( plot.title = element_text(face = "bold",hjust = 0.5),
                      legend.title = element_text(size = 12),
                      legend.text = element_text(size = 10) )
  
  .open_window()
  print(plot_pred)
  
  
  
  #if CV errors to be plotted
  if(length(results_ko) == lenght_res_with_er){
    
    #CV alpha
    if(results_ko$CV=="CV_alpha"){
      
      
      if(true_alphas==FALSE){  #put the alphas equispaced
        opt_par       <- data.frame(x=which(results_ko$Alphas==results_ko$Alpha),y=min(results_ko$`Validation errors`))
        plot_cv_alpha <- ggplot( data = data.frame(x = 1:length(results_ko$`Validation errors`), y = results_ko$`Validation errors`), aes(x = x, y = y)) +
          geom_point( color = "blue", size = 1) +  
          geom_line( color = "blue") +  
          geom_point(data = opt_par, aes(x = x, y = y), color = "red", size = 4, shape = 8) +
          labs(title = "Validation error for CV on regularization parameter", x = "alpha", y = "Validation error") +
          theme_minimal() +
          scale_x_continuous( breaks = seq(1,length(results_ko$`Validation errors`), by = 1), labels = as.character(results_ko$Alphas)) + 
          theme(plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                panel.grid.major.x = element_line( color = "gray", linewidth = 0.5))}
      
      if(true_alphas==TRUE){  #use the true alphas 
        opt_par       <- data.frame(x=results_ko$Alpha,y=min(results_ko$`Validation errors`))
        plot_cv_alpha <- ggplot( data = data.frame(x = results_ko$Alphas, y = results_ko$`Validation errors`), aes(x = x, y = y)) +
          geom_point( color = "blue", size = 1) +  
          geom_line( color = "blue") +
          geom_point(data = opt_par, aes(x = x, y = y), color = "red", size = 4, shape = 8) +
          labs(title = "Validation error for CV on regularization parameter", x = "alpha", y = "Validation error") +
          theme_minimal() +
          scale_x_continuous( breaks = results_ko$Alphas) + 
          theme(plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                panel.grid.major.x = element_line( color = "gray", linewidth = 0.5))}
      
      .open_window()
      print(plot_cv_alpha)}
    
    
    #CV k
    if(results_ko$CV=="CV_k"){
      opt_par   <- data.frame(x=results_ko$`Number of PPCs retained`,y=min(results_ko$`Validation errors`))
      plot_cv_k <- ggplot(data=data.frame(x = 1:length(results_ko$`Validation errors`), y = results_ko$`Validation errors`), aes(x = x, y = y)) +
        geom_point(color = "blue", size = 1) +  
        geom_line(color = "blue") +  
        geom_point(data = opt_par, aes(x = x, y = y), color = "red", size = 4, shape = 8) +
        labs(title = "Validation error for CV on number of PPCs", x = "k", y = "Validation error") +
        theme_minimal() +
        scale_x_continuous(breaks = seq(1,length(results_ko$`Validation errors`), by = 1)) + 
        theme(plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
              panel.grid.major.x = element_line( color = "gray", linewidth = 0.5)) 
      
      .open_window()
      print(plot_cv_k)}
    
    
    #CV alpha-k
    if(results_ko$CV=="CV"){
      
      #preparing the data for the heatmap
      data <- expand.grid(x = results_ko$Alphas, y = results_ko$K_s)
      tot_alpha = length(results_ko$Alphas)
      tot_k = length(results_ko$K_s)
      for(i in 1:tot_alpha){
        err_alpha_fix = unlist(results_ko$`Validation errors`[i]) 
        if(length(err_alpha_fix)<tot_k){  err_alpha_fix = c(err_alpha_fix,rep(max(err_alpha_fix),tot_k-length(err_alpha_fix)))}
        data[which(data$x==results_ko$Alphas[i]),3]=err_alpha_fix
        if(true_alphas==FALSE){  data[which(data$x==results_ko$Alphas[i]),1]=i}
        if(true_alphas==TRUE) {  data[which(data$x==results_ko$Alphas[i]),1]=results_ko$Alphas[i]}}
      colnames(data) = c("x","y","z")
      
      if(true_alphas==FALSE){
        plot_cv <- ggplot(data, aes(x = x, y = y, fill = z)) +
                   geom_tile() +
                   scale_fill_viridis_c( option = "plasma", na.value = "white", limits = c(min(data$z), max(data$z))) +
                   labs( x = "alpha", y = "k", fill = "Validation Error" ) +
                   labs( title = "Validation error for CV on reg param and number of PPCs" ) +
                   theme_minimal() + 
                   scale_x_continuous( breaks = seq(1,length(results_ko$Alphas), by = 1), labels = as.character(results_ko$Alphas)) + 
                   theme( plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                          legend.position = "bottom",
                          panel.grid.major = element_blank(),  
                          panel.grid.minor = element_blank() ) +
                   geom_hline( yintercept = data$y, linetype = "solid", color = "grey", size = 0.05 ) +  
                   geom_vline( xintercept = data$x, linetype = "solid", color = "grey", size = 0.1 )}
      
      if(true_alphas==TRUE){
        plot_cv <- ggplot(data, aes(x = x, y = y, fill = z)) +
                   geom_tile() +
                   scale_fill_viridis_c( option = "plasma", na.value = "white", limits = c(min(data$z), max(data$z))) +
                   labs( x = "alpha", y = "k", fill = "Validation Error" ) +
                   labs( title = "Validation error for CV on reg param and number of PPCs" ) +
                   theme_minimal() + 
                   theme( plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                          legend.position = "bottom",
                          panel.grid.major = element_blank(),  
                          panel.grid.minor = element_blank()) +
                   geom_hline( yintercept = data$y, linetype = "solid", color = "grey", size = 0.05 ) +  
                   geom_vline( xintercept = data$x, linetype = "solid", color = "grey", size = 0.1 )}
      
      .open_window()
      print(plot_cv)}
  }
  
  
  
  #plot of directions and weights
  for (i in 1:results_ko$`Number of PPCs retained`) {
    
    data_dir <- data.frame(x = results_ko$`Function discrete evaluations points`,
                           y = results_ko$`Directions of PPCs`[[i]])
    data_wei <- data.frame(x = results_ko$`Function discrete evaluations points`,
                           y = results_ko$`Weights of PPCs`[[i]])
    
    direction <- ggplot(data_dir, aes(x = x, y = y)) +
                 geom_line( size = 1.2 ) +
                 labs( x = x_lab, y = y_lab ) +
                 labs( title = paste0("Direction a",i)) + 
                 theme_minimal() +
                 theme( plot.title = element_text(face = "bold",hjust = 0.5) )
    
    weight <-    ggplot(data_wei, aes(x = x, y = y)) +
                 geom_line( size = 1.2 ) +
                 labs( x = x_lab, y = y_lab ) +
                 labs(title = paste0("Weight b",i)) + 
                 theme_minimal() +
                 theme( plot.title = element_text(face = "bold",hjust = 0.5))
    
    plot_dir_we <-  weight + direction + plot_layout(ncol = 2) + plot_annotation( title = paste0("PPC",i), theme = theme(plot.title = element_text(face = "bold",hjust = 0.5)) )
    .open_window()
    print(plot_dir_we)}

  #plot of directions and weights as perturbation of the mean
  for (i in 1:results_ko$`Number of PPCs retained`) {
  
  data_dir <- data.frame(x = results_ko$`Function discrete evaluations points`,
                         y = c(results_ko$`Mean function`,
                               results_ko$`Mean function` + results_ko$`Sd scores directions`[i]*results_ko$`Directions of PPCs`[[i]],
                               results_ko$`Mean function` - results_ko$`Sd scores directions`[i]*results_ko$`Directions of PPCs`[[i]]),
                         group = rep(c("Mean", "Upper", "Lower"), each = length(results_ko$`Function discrete evaluations points`)))
  
  data_wei <- data.frame(x = results_ko$`Function discrete evaluations points`,
                         y = c(results_ko$`Mean function`,
                               results_ko$`Mean function` + results_ko$`Sd scores weights`[i]*results_ko$`Weights of PPCs`[[i]],
                               results_ko$`Mean function` - results_ko$`Sd scores weights`[i]*results_ko$`Weights of PPCs`[[i]]),
                         group = rep(c("Mean", "Upper", "Lower"), each = length(results_ko$`Function discrete evaluations points`)))
  
  direction <- ggplot(data_dir, aes(x = x, y = y)) +
               geom_line(data = subset(data_dir, group == "Mean"), aes(color = NULL, linetype = NULL), size = 1, color = "black") +
               geom_line(data = subset(data_dir, group != "Mean"), aes(color = group, linetype = group), size = 1, alpha = 0.4) +
               scale_linetype_manual(values = c("dashed", "dashed")) + 
               scale_color_manual(values = c("red", "green")) +        
               labs(title = paste0("Direction a",i),
                    x = x_lab,
                    y = y_lab,
                    color = "",
                    linetype = "") +
               theme_minimal()
  
  weight <- ggplot(data_wei, aes(x = x, y = y)) +
            geom_line(data = subset(data_wei, group == "Mean"), aes(color = NULL, linetype = NULL), size = 1, color = "black") +
            geom_line(data = subset(data_wei, group != "Mean"), aes(color = group, linetype = group), size = 1, alpha = 0.4) +
            scale_linetype_manual(values = c("dashed", "dashed")) + 
            scale_color_manual(values = c("red", "green")) +        
            labs(title = paste0("Weight b",i),
                 x = x_lab,
                 y = y_lab,
                 color = "",
                 linetype = "") +
            theme_minimal()
  
  plot_dir_we_mean_pert <- weight + direction + plot_layout(ncol = 2) + plot_annotation( title = paste0(paste0("PPC",as.character(i))," as perturbation of the mean"), theme = theme(plot.title = element_text(face = "bold",hjust = 0.5)) )
  .open_window()
  print(plot_dir_we_mean_pert)}
  
}


#2d case: same inputs as unidimensioanl case, but from bidimensional functions
KO_show_results_2d <- function(results_ko,hp_ko=NULL,x1_lab="x1",x2_lab="x2",z_lab="value",true_alphas=FALSE){
  
  #length of results_ko if error saved
  lenght_res_with_er = 21 #with errors
  
  #checking correct input by their dimension
  if (length(results_ko) == 0) {
    stop("First parameter (results_ko) must not be NULL")
  } else{
    if(length(results_ko)!=lenght_res_with_er && length(results_ko)!=(lenght_res_with_er-1)){
      stop("results_ko could not come from KO")
    }
    cat("\n")
    cat("Results of KO algorithm")
    cat("\n")
  }
  
  
  
  #Print parameters found: alpha, number of PPCs and Explanatory power
  cat("\n")
  cat("Alpha:", results_ko$Alpha, "\n")
  cat("\n")
  cat("Number of PPCs retained:", results_ko$`Number of PPCs retained`, "\n")
  cat("\n")
  
  exp_pw = data.frame(
    m = results_ko$`Explanatory power PPCs`
  )
  colnames(exp_pw) = "Explanatory power"
  print(exp_pw)
  cat("\n")
  

  
  #Plot pvalues of ADF
  if(!(is.null(hp_ko))){
    
    if(length(hp_ko)!=1){ stop("Second parameter (hp_ko) could be not from hp-check KO")}
    
    data <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
    
    # Usa gli indici per ottenere i valori da m$`Pvalues ADF`
    data$z <- (hp_ko$`P-values ADF`)[cbind(
      match(data$x, results_ko$`Function discrete evaluations points dim1`),  # Trova gli indici di x in x_coords
      match(data$y, results_ko$`Function discrete evaluations points dim2`)   # Trova gli indici di y in y_coords
    )]
    
    plot_pv <- ggplot(data, aes(x = x, y = y)) +
               geom_raster(aes(fill = z), na.rm = TRUE) +
               stat_contour(aes(z = z, color = ..level..), binwidth = 0.1, na.rm = TRUE) +
               scale_fill_viridis_c( na.value = "white", option = "viridis", name = "Value", limits = c(0, 1), breaks = seq(0, 1, by = 0.1) ) +
               scale_color_viridis_c(option = "viridis", name = "Value", limits = c(0, 1), breaks = seq(0, 1, by = 0.1) ) +
               labs( title = "Pointwise ADF test p-value", x = x1_lab, y = x2_lab ) +
               guides( fill = guide_legend(override.aes = list(color = NA)), color = guide_legend() ) +
               theme_minimal() +
               theme( plot.title = element_text(face = "bold",hjust = 0.5),
                      legend.position = "right",
                      legend.key.size = unit(0.5, "cm"),
                      legend.title = element_text(size = 10),
                      legend.text = element_text(size = 7),
                      legend.box = "vertical",
                      legend.box.background = element_rect(fill = "white", color = "black"),
                      legend.margin = margin(5, 5, 5, 5), 
                      panel.grid.major = element_blank(),  
                      panel.grid.minor = element_blank() ) +
               geom_hline( yintercept = seq(min(data$y), max(data$y), by = (quantile(data$y)[2]-quantile(data$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
               geom_vline( xintercept = seq(min(data$x), max(data$x), by = (quantile(data$x)[2]-quantile(data$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
    
    .open_window()
    print(plot_pv)}
  
  
  
  #Plot of one step ahead prediction
  #First, a plot to compare f_n and f_n+1
  data1 <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  data2 <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  
  #f_n
  data1$z <- (results_ko$f_n)[cbind(
    match(data1$x, results_ko$`Function discrete evaluations points dim1`),  
    match(data1$y, results_ko$`Function discrete evaluations points dim2`))]
  
  #f_n+1
  data2$z <- (results_ko$`One-step ahead prediction`)[cbind(
    match(data2$x, results_ko$`Function discrete evaluations points dim1`),  
    match(data2$y, results_ko$`Function discrete evaluations points dim2`))]
  
  z_min <- min(c(data1$z, data2$z), na.rm = TRUE)
  z_max <- max(c(data1$z, data2$z), na.rm = TRUE)
 
  plot1 <- ggplot(data1, aes(x = x, y = y, fill = z)) +
           geom_tile() +
           scale_fill_viridis_c( option = "plasma", na.value = "white", limits = c(z_min, z_max) ) +
           labs( x = x1_lab, y = x2_lab, fill = z_lab ) +
           labs( title = latex2exp::TeX("$f_n$")) +
           theme_minimal() +
           theme( plot.title = element_text(face = "bold",hjust = 0.5),
                  legend.position = "none",
                  panel.grid.major = element_blank(),  
                  panel.grid.minor = element_blank())+
           geom_hline( yintercept = seq(min(data1$y), max(data1$y), by = (quantile(data1$y)[2]-quantile(data1$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
           geom_vline( xintercept = seq(min(data1$x), max(data1$x), by = (quantile(data1$x)[2]-quantile(data1$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  
  plot2 <- ggplot(data2, aes(x = x, y = y, fill = z)) +
           geom_tile() +
           scale_fill_viridis_c( option = "plasma", na.value = "white", limits = c(z_min, z_max)) +
           labs( x = x1_lab, y = x2_lab, fill = z_lab ) +
           labs( title = latex2exp::TeX("$f_{n+1}$")) +
           theme_minimal() +
           theme( plot.title = element_text(face = "bold",hjust = 0.5),
                  legend.position = "bottom",
                  panel.grid.major = element_blank(),  
                  panel.grid.minor = element_blank()) +
           geom_hline( yintercept = seq(min(data2$y), max(data2$y), by = (quantile(data2$y)[2]-quantile(data2$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
           geom_vline( xintercept = seq(min(data2$x), max(data2$x), by = (quantile(data2$x)[2]-quantile(data2$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  
  combined_plot <- plot1 + plot2 + plot_layout(guides = "collect") & theme(legend.position = "bottom")

  .open_window()
  print(combined_plot)
  
  #then, a plot to see the increment
  diff   <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  diff$z <- data2$z - data1$z
  increment <- ggplot( diff, aes(x = x, y = y, fill = z))  +
               geom_tile( color = "white") +  
               scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0, name = z_lab ) +  
               labs( x = x1_lab, y = x2_lab ) +
               labs(title = latex2exp::TeX("Increment from $f_{n}$ to $f_{n+1}$ ")) +
               theme_minimal() + 
               theme(plot.title = element_text(face = "bold",hjust = 0.5),
                     panel.grid.major = element_blank(),  
                     panel.grid.minor = element_blank()) +
               geom_hline( yintercept = seq(min(diff$y), max(diff$y), by = (quantile(diff$y)[2]-quantile(diff$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
               geom_vline( xintercept = seq(min(diff$x), max(diff$x), by = (quantile(diff$x)[2]-quantile(diff$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  
  .open_window()
  print(increment)
  
  

  #if CV errors to be plotted
  if(length(results_ko) == lenght_res_with_er){
    
    #CV alpha
    if(results_ko$CV=="CV_alpha"){
      
      
      if(true_alphas==FALSE){  #put the alphas equispaced
        opt_par       <- data.frame(x=which(results_ko$Alphas==results_ko$Alpha),y=min(results_ko$`Validation errors`))
        plot_cv_alpha <- ggplot( data = data.frame(x = 1:length(results_ko$`Validation errors`), y = results_ko$`Validation errors`), aes(x = x, y = y)) +
          geom_point( color = "blue", size = 1) +  
          geom_line( color = "blue") +  
          geom_point(data = opt_par, aes(x = x, y = y), color = "red", size = 4, shape = 8) +
          labs(title = "Validation error for CV on regularization parameter", x = "alpha", y = "Validation error") +
          theme_minimal() +
          scale_x_continuous( breaks = seq(1,length(results_ko$`Validation errors`), by = 1), labels = as.character(results_ko$Alphas)) + 
          theme(plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                panel.grid.major.x = element_line( color = "gray", linewidth = 0.5))}
      
      if(true_alphas==TRUE){  #use the true alphas 
        opt_par       <- data.frame(x=results_ko$Alpha,y=min(results_ko$`Validation errors`))
        plot_cv_alpha <- ggplot( data = data.frame(x = results_ko$Alphas, y = results_ko$`Validation errors`), aes(x = x, y = y)) +
          geom_point( color = "blue", size = 1) +  
          geom_line( color = "blue") +
          geom_point(data = opt_par, aes(x = x, y = y), color = "red", size = 4, shape = 8) +
          labs(title = "Validation error for CV on regularization parameter", x = "alpha", y = "Validation error") +
          theme_minimal() +
          scale_x_continuous( breaks = results_ko$Alphas) + 
          theme(plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                panel.grid.major.x = element_line( color = "gray", linewidth = 0.5))}
      
      .open_window()
      print(plot_cv_alpha)}
    
    
    #CV k
    if(results_ko$CV=="CV_k"){
      opt_par   <- data.frame(x=results_ko$`Number of PPCs retained`,y=min(results_ko$`Validation errors`))
      plot_cv_k <- ggplot(data=data.frame(x = 1:length(results_ko$`Validation errors`), y = results_ko$`Validation errors`), aes(x = x, y = y)) +
        geom_point(color = "blue", size = 1) +  
        geom_line(color = "blue") +  
        geom_point(data = opt_par, aes(x = x, y = y), color = "red", size = 4, shape = 8) +
        labs(title = "Validation error for CV on number of PPCs", x = "k", y = "Validation error") +
        theme_minimal() +
        scale_x_continuous(breaks = seq(1,length(results_ko$`Validation errors`), by = 1)) + 
        theme(plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
              panel.grid.major.x = element_line( color = "gray", linewidth = 0.5)) 
      
      .open_window()
      print(plot_cv_k)}
    
    
    #CV alpha-k
    if(results_ko$CV=="CV"){
      
      #preparing the data for the heatmap
      data <- expand.grid(x = results_ko$Alphas, y = results_ko$K_s)
      tot_alpha = length(results_ko$Alphas)
      tot_k = length(results_ko$K_s)
      for(i in 1:tot_alpha){
        err_alpha_fix = unlist(results_ko$`Validation errors`[i]) 
        if(length(err_alpha_fix)<tot_k){  err_alpha_fix = c(err_alpha_fix,rep(max(err_alpha_fix),tot_k-length(err_alpha_fix)))}
        data[which(data$x==results_ko$Alphas[i]),3]=err_alpha_fix
        if(true_alphas==FALSE){  data[which(data$x==results_ko$Alphas[i]),1]=i}
        if(true_alphas==TRUE) {  data[which(data$x==results_ko$Alphas[i]),1]=results_ko$Alphas[i]}}
      colnames(data) = c("x","y","z")
      
      if(true_alphas==FALSE){
        plot_cv <- ggplot(data, aes(x = x, y = y, fill = z)) +
          geom_tile() +
          scale_fill_viridis_c( option = "plasma", na.value = "white", limits = c(min(data$z), max(data$z))) +
          labs( x = "alpha", y = "k", fill = "Validation Error" ) +
          labs( title = "Validation error for CV on reg param and number of PPCs" ) +
          theme_minimal() + 
          scale_x_continuous( breaks = seq(1,length(results_ko$Alphas), by = 1), labels = as.character(results_ko$Alphas)) + 
          theme( plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                 legend.position = "bottom",
                 panel.grid.major = element_blank(),  
                 panel.grid.minor = element_blank() ) +
          geom_hline( yintercept = data$y, linetype = "solid", color = "grey", size = 0.05 ) +  
          geom_vline( xintercept = data$x, linetype = "solid", color = "grey", size = 0.1 )}
      
      if(true_alphas==TRUE){
        plot_cv <- ggplot(data, aes(x = x, y = y, fill = z)) +
          geom_tile() +
          scale_fill_viridis_c( option = "plasma", na.value = "white", limits = c(min(data$z), max(data$z))) +
          labs( x = "alpha", y = "k", fill = "Validation Error" ) +
          labs( title = "Validation error for CV on reg param and number of PPCs" ) +
          theme_minimal() + 
          theme( plot.title = element_text( family = "Arial", face = "bold", color = "black", size = 16, hjust = 0.5),
                 legend.position = "bottom",
                 panel.grid.major = element_blank(),  
                 panel.grid.minor = element_blank()) +
          geom_hline( yintercept = data$y, linetype = "solid", color = "grey", size = 0.05 ) +  
          geom_vline( xintercept = data$x, linetype = "solid", color = "grey", size = 0.1 )}
      
      .open_window()
      print(plot_cv)}
  }
  
  
  
  #plot of weights and directions
  for (i in 1:results_ko$`Number of PPCs retained`) {
    dir <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
    wei <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
    
    dir$z <- (results_ko$`Directions of PPCs`[[i]])[cbind(
      match(dir$x, results_ko$`Function discrete evaluations points dim1`),  
      match(dir$y, results_ko$`Function discrete evaluations points dim2`))]
    
    wei$z <- (results_ko$`Weights of PPCs`[[i]])[cbind(
      match(wei$x, results_ko$`Function discrete evaluations points dim1`),  
      match(wei$y, results_ko$`Function discrete evaluations points dim2`))]
    
    dir_plot <- ggplot(dir, aes(x = x, y = y, fill = z)) +
                geom_tile() +
                scale_fill_viridis_c( option = "plasma", na.value = "white",limits = c(min(dir$z,na.rm=TRUE), max(dir$z,na.rm=TRUE)) ) +
                labs( x = x1_lab, y = x2_lab, fill = z_lab ) +
                labs( title = paste0("Direction a",i) ) + 
                theme_minimal() +
                theme( plot.title = element_text(face = "bold",hjust = 0.5 ),
                       panel.grid.major = element_blank(),  
                       panel.grid.minor = element_blank() ) +
                geom_hline( yintercept = seq(min(dir$y), max(dir$y), by = (quantile(dir$y)[2]-quantile(dir$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
                geom_vline( xintercept = seq(min(dir$x), max(dir$x), by = (quantile(dir$x)[2]-quantile(dir$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
    
    weight_plot <- ggplot(wei, aes(x = x, y = y, fill = z)) +
                   geom_tile() +
                   scale_fill_viridis_c(option = "viridis", na.value = "white",limits = c(min(wei$z,na.rm=TRUE), max(wei$z,na.rm=TRUE))) +
                   labs( x = x1_lab, y = x2_lab, fill = z_lab ) +
                   labs(title = paste0("Weight b",i)) + 
                   theme_minimal() +
                   theme( plot.title = element_text(face = "bold",hjust = 0.5),
                          panel.grid.major = element_blank(),  
                          panel.grid.minor = element_blank() ) +
                  geom_hline( yintercept = seq(min(wei$y), max(wei$y), by = (quantile(wei$y)[2]-quantile(wei$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
                  geom_vline( xintercept = seq(min(wei$x), max(wei$x), by = (quantile(wei$x)[2]-quantile(wei$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
    
    plot_dir_we <-  weight_plot + dir_plot + plot_layout(ncol = 2) + plot_annotation( title = paste0("PPC",i), theme = theme(plot.title = element_text(face = "bold",hjust = 0.5)) )
    .open_window()
    print(plot_dir_we)}

  
  #PPCs as perturbation of the mean
  for (i in 1:results_ko$`Number of PPCs retained`){
  
  data_up_dir <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  
  data_lw_dir <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  
  data_lw_dir$z <- ((-1)*results_ko$`Directions of PPCs`[[i]]*results_ko$`Sd scores directions`[i])[cbind(
          match(data_lw_dir$x, results_ko$`Function discrete evaluations points dim1`),  
          match(data_lw_dir$y, results_ko$`Function discrete evaluations points dim2`))]
  data_up_dir$z <- (results_ko$`Directions of PPCs`[[i]]*results_ko$`Sd scores directions`[i])[cbind(
          match(data_up_dir$x, results_ko$`Function discrete evaluations points dim1`),  
          match(data_up_dir$y, results_ko$`Function discrete evaluations points dim2`))]
  
  z_min = min(min(data_up_dir),min(data_lw_dir))
  z_max = max(max(data_up_dir),max(data_lw_dir))
  
  
  plot_up_dir <- ggplot(data_up_dir, aes(x = x, y = y, fill = z)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) + 
    labs( title = paste0(paste0("Direction a",i),", upper mean perturbation"), x = x1_lab, y = x2_lab, fill = z_lab ) +
    theme_minimal() +
    theme( plot.title = element_text(face = "bold",hjust = 0.5),
           legend.position = "bottom",
           panel.grid.major = element_blank(),  
           panel.grid.minor = element_blank()) +
    geom_hline( yintercept = seq(min(data_up_dir$y), max(data_up_dir$y), by = (quantile(data_up_dir$y)[2]-quantile(data_up_dir$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
    geom_vline( xintercept = seq(min(data_up_dir$x), max(data_up_dir$x), by = (quantile(data_up_dir$x)[2]-quantile(data_up_dir$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  
  plot_bw_dir <- ggplot(data_lw_dir, aes(x = x, y = y, fill = z)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) + 
    labs( title = paste0(paste0("Direction a",i),", lower mean perturbation"), x = x1_lab, y = x2_lab, fill = z_lab ) +
    theme_minimal() +
    theme( plot.title = element_text(face = "bold",hjust = 0.5),
           legend.position = "bottom",
           panel.grid.major = element_blank(),  
           panel.grid.minor = element_blank()) +
    geom_hline( yintercept = seq(min(data_lw_dir$y), max(data_lw_dir$y), by = (quantile(data_lw_dir$y)[2]-quantile(data_lw_dir$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
    geom_vline( xintercept = seq(min(data_lw_dir$x), max(data_lw_dir$x), by = (quantile(data_lw_dir$x)[2]-quantile(data_lw_dir$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  
  
  
  
  data_up_wei <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  
  data_lw_wei <- expand.grid(x = results_ko$`Function discrete evaluations points dim1`, y = results_ko$`Function discrete evaluations points dim2`)
  
  data_lw_wei$z <- ((-1)*results_ko$`Weights of PPCs`[[i]]*results_ko$`Sd scores weights`[i])[cbind(
    match(data_lw_wei$x, results_ko$`Function discrete evaluations points dim1`),  
    match(data_lw_wei$y, results_ko$`Function discrete evaluations points dim2`))]
  data_up_wei$z <- (results_ko$`Weights of PPCs`[[i]]*results_ko$`Sd scores weights`[i])[cbind(
    match(data_up_wei$x, results_ko$`Function discrete evaluations points dim1`),  
    match(data_up_wei$y, results_ko$`Function discrete evaluations points dim2`))]
  
  z_min = min(min(data_up_wei),min(data_lw_wei))
  z_max = max(max(data_up_wei),max(data_lw_wei))
  
  
  plot_up_wei <- ggplot(data_up_wei, aes(x = x, y = y, fill = z)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) + 
    labs( title = paste0(paste0("Weight b",i),", upper mean perturbation"), x = x1_lab, y = x2_lab, fill = z_lab ) +
    theme_minimal() +
    theme( plot.title = element_text(face = "bold",hjust = 0.5),
           legend.position = "bottom",
           panel.grid.major = element_blank(),  
           panel.grid.minor = element_blank()) +
    geom_hline( yintercept = seq(min(data_up_wei$y), max(data_up_wei$y), by = (quantile(data_up_wei$y)[2]-quantile(data_up_wei$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
    geom_vline( xintercept = seq(min(data_up_wei$x), max(data_up_wei$x), by = (quantile(data_up_wei$x)[2]-quantile(data_up_wei$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  
  plot_bw_wei<- ggplot(data_lw_wei, aes(x = x, y = y, fill = z)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) + 
    labs( title = paste0(paste0("Weight b",i),", lower mean perturbation"), x = x1_lab, y = x2_lab, fill = z_lab ) +
    theme_minimal() +
    theme( plot.title = element_text(face = "bold",hjust = 0.5),
           legend.position = "bottom",
           panel.grid.major = element_blank(),  
           panel.grid.minor = element_blank()) +
    geom_hline( yintercept = seq(min(data_lw_wei$y), max(data_lw_wei$y), by = (quantile(data_lw_wei$y)[2]-quantile(data_lw_wei$y)[1])/2), linetype = "solid", color = "grey", size = 0.1 ) +  
    geom_vline( xintercept = seq(min(data_lw_wei$x), max(data_lw_wei$x), by = (quantile(data_lw_wei$x)[2]-quantile(data_lw_wei$x)[1])/2), linetype = "solid", color = "grey", size = 0.1 )  
  

  
  title_mean_pert <- textGrob(paste0(paste0("PPC",i), " as perturbation of the mean"), gp = gpar(fontsize = 20, fontface = "bold"))
  .open_window()
  # Combinazione dei grafici con titolo complessivo
  grid.arrange(title_mean_pert,arrangeGrob(plot_up_wei, plot_up_dir, plot_bw_wei, plot_bw_dir, nrow = 2, ncol = 2),nrow = 2,heights = c(1, 10))}
}
