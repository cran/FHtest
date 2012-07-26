rcc <-
function (times, status, z, rho, lambda) 
{
    uz <- sort(unique(z))
    k <- length(uz)
    zz <- 1 * (z == uz[1])
    wtd <- wtdlogrank(Surv(times, status) ~ zz, WtFun = "FH", 
        param = c(1, 0))
    w <- c(1, wtd$wt[1:(length(wtd$wt) - 1)])
    neventg <- matrix(1, length(wtd$wt), k)
    neventg[, 1] <- wtd$nevent1
    nriskg <- matrix(1, length(wtd$wt), k)
    nriskg[, 1] <- wtd$nrisk1
    for (i in 2:k) {
        zz <- 1 * (z == uz[i])
        wtd <- wtdlogrank(Surv(times, status) ~ zz, WtFun = "FH", 
            param = c(1, 0))
        neventg[, i] <- wtd$nevent1
        nriskg[, i] <- wtd$nrisk1
    }
    observed <- (w^rho * (1 - w)^lambda) %*% neventg
    expected <- (w^rho * (1 - w)^lambda) %*% (nriskg * (wtd$nevent/wtd$nrisk))
    v <- (w^rho * (1 - w)^lambda)^2 * (wtd$nevent * (wtd$nrisk - 
        wtd$nevent)/(wtd$nrisk - 1))
    v[wtd$nrisk == 1] <- 0
    v <- diag(c(v %*% (nriskg/wtd$nrisk))) - t(nriskg/wtd$nrisk) %*% 
        ((nriskg/wtd$nrisk) * v)
    list(obs = c(observed), exp = c(expected), var = v)
}
