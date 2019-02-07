# Clear workspace
rm(list = ls())

# Set working directory
# Please comment this line if you are running the script using source
#setwd('Desktop/2019Spring/Teaching/Section/Section1/')

# Transition probability
k.h <- 0.01 

# Time vector (draw for 500 times)
tt <- 0:500 

# Define the function that returns Markov chain result 
# Input: time vector and initial states
# Output: history of the bumble bees distribution in two boxes
BumbleBees <- function(tt, n1, n2) {
  N1=n1;N2=n2 
  for(i in tt[-1]){
    if(n1==0)
      {dn1=0}
    else {dn1=sum(runif(n1)<k.h)}
    
    if(n2==0)
      {dn2=0}
    else {dn2=sum(runif(n2)<k.h)}
    
    n1= n1-dn1+dn2 
    n2= n2-dn2+dn1
    N1=c(N1,n1)
    N2=c(N2,n2)
  }
  return(list(N1 = N1, N2 = N2))
}

# Test the function
n1 <- 1000
n2 <- 0
result <- BumbleBees(tt, n1, n2)

# Read the data into a dataframe
istate <- read.csv('./Section1_initial_states.csv', header = TRUE)  

# extract value from a dataframe, dataframe$column[index]
print(istate$A[1])

# Loop through the given initial states
N1_list = list()
N2_list = list()
for (j in 1:5){
  n1_temp <- istate$A[j]
  n2_temp <- istate$B[j]
  result_temp <- BumbleBees(tt, n1_temp, n2_temp)
  N1_list[[j]] <- result_temp$N1
  N2_list[[j]] <- result_temp$N2
}

# Plotting
# par() or layout() can be used for drawing subplots
par(mar = c(4,4,3,3), mfrow = c(2,2)) 
for (k in 1:4){
  plot(x = tt, y = N1_list[[k]], cex = 0.2, xlab="Time", ylab="# of bumble bees ", ylim = c(0, 1000), pch=1, col = 'red') 
  points(tt, N2_list[[k]], cex = 0.2, xlab="Time", ylab="# of bumble bees ", pch=1, col = 'blue')
  legend("topright", legend = c("Box A", "Box B"), col = c("red", "blue"),
         lty = c(1, 1), pch = c(1, 1), lwd = c(1, 1), bty = 'n', cex = 0.7, pt.cex = 1, y.intersp=0.6)
}

# Set the title for the plot
mtext("Extended bumble bee example", side = 3, line = -2, outer = TRUE)

# Save the figure
dev.copy2eps(file = "./RTutorial_plot.eps")

