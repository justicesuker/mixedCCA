# Generate Data
n <- 100; p1 <- 5; p2 <- 7
maxcancor <- 0.9
Sigma1 <- autocor(p1, 0.7)
groupind <- c(rep(1, 2), rep(2, p2-2))
Sigma2 <- blockcor(groupind, 0.7)
copula1 <- "exp"; copula2 <- "cube"
mu <- rep(0, p1+p2)
type1 <- type2 <- "trunc"
c1 <- rep(0, p1); c2 <- rep(0, p2)
trueidx1 <- c(0, 0, 1, 1, 1)
trueidx2 <- c(1, 0, 1, 0, 0, 1, 1)
simdata <- GenerateData(n=n, trueidx1 = trueidx1, trueidx2 = trueidx2, maxcancor = maxcancor,
                        Sigma1 = Sigma1, Sigma2 = Sigma2,
                        copula1 = copula1, copula2 = copula2,
                        muZ = mu,
                        type1 = type1, type2 = type2, c1 = c1, c2 = c2
)

X1 <- simdata$X1
X2 <- simdata$X2

# Kendall CCA with BIC1
kendallcca1 <- mixedCCA(X1, X2, type1 = type1, type2 = type2, BICtype = 1)

# Kendall CCA with BIC2. Estimated correlation matrix is plugged in from the above result.
R <- kendallcca1$KendallR
kendallcca2 <- mixedCCA(X1, X2, type1 = type1, type2 = type2, KendallR = R, BICtype = 2)
