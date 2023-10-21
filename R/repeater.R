library(tictoc)
tic()
count <- 1
repeat {
  blockInfoUpdate()
  count <- count + 1
  Sys.sleep(runif(n=1, min=1, max=5))
  if(count > 2500) {
    break
  }
}
toc()
