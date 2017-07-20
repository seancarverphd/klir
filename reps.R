repeated.estimates <- function(reps=6, seed=FALSE, quantile.regression=FALSE) {
  if (seed != FALSE) {
    set.seed(seed)
  }
  estimates <- c()
  for (k in 1:reps) {
    bs.t5 <- sim.t(200000, df=5)
    ll.t5.t5 <- likes.t(bs.t5, df=5)
    ll.t5.normal <- likes.t(bs.t5, df=Inf)
    estimates[k] <- samples.needed(ll.t5.t5, ll.t5.normal, 
                                   max.samples=250, bootstrap.rows=1000, quantile.regression=quantile.regression)
  }
  return(estimates)
}