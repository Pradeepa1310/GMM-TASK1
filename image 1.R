set.seed(123)


n <- 200000


mu1_true <- c(2, 3)
sigma1_true <- matrix(c(
  1, 0.5,
  0.5, 1
), nrow = 2)

mu2_true <- c(7, 8)
sigma2_true <- matrix(c(
  1, -0.3,
  -0.3, 1
), nrow = 2)

generate_data <- function(n, mean, sigma) {

  L <- chol(sigma)

  Z <- matrix(
    rnorm(n * 2),
    ncol = 2
  )

  X <- Z %*% L +
    matrix(mean,
           n,
           2,
           byrow = TRUE)

  return(X)
}

data1 <- generate_data(
  n / 2,
  mu1_true,
  sigma1_true
)

data2 <- generate_data(
  n / 2,
  mu2_true,
  sigma2_true
)

X <- rbind(data1, data2)

colnames(X) <- c("Feature1", "Feature2")

write.csv(
  X,
  "synthetic_data_200k.csv",
  row.names = FALSE
)

cat("Dataset Generated\n")
cat("Rows:", nrow(X), "\n")
cat("Columns:", ncol(X), "\n")

K <- 2

n <- nrow(X)
d <- ncol(X)

pi_k <- rep(1 / K, K)

mu_k <- X[
  sample(1:n, K),
]

sigma_k <- list()

for (k in 1:K) {
  sigma_k[[k]] <- diag(d)
}


gaussian_density <- function(X, mu, sigma) {

  n <- nrow(X)
  d <- ncol(X)

  sigma_inv <- solve(sigma)

  sigma_det <- det(sigma)

  density <- numeric(n)

  constant <- 1 /
    (((2 * pi)^(d / 2)) *
       sqrt(sigma_det))

  for (i in 1:n) {

    x_mu <- X[i, ] - mu

    density[i] <-
      constant *
      exp(
        -0.5 *
          t(x_mu) %*%
          sigma_inv %*%
          x_mu
      )
  }

  return(density)
}

E_step <- function(
  X,
  pi_k,
  mu_k,
  sigma_k
) {

  n <- nrow(X)

  K <- length(pi_k)

  gamma <- matrix(
    0,
    n,
    K
  )

  for (k in 1:K) {

    gamma[, k] <-
      pi_k[k] *
      gaussian_density(
        X,
        mu_k[k, ],
        sigma_k[[k]]
      )
  }

  gamma <- gamma /
    rowSums(gamma)

  return(gamma)
}

M_step <- function(X, gamma) {

  n <- nrow(X)
  d <- ncol(X)
  K <- ncol(gamma)

  Nk <- colSums(gamma)

  pi_k <- Nk / n

  mu_k <- matrix(
    0,
    K,
    d
  )

  sigma_k <- list()

  for (k in 1:K) {

    mu_k[k, ] <-
      colSums(
        gamma[, k] * X
      ) / Nk[k]

    sigma <- matrix(
      0,
      d,
      d
    )

    for (i in 1:n) {

      x_mu <- matrix(
        X[i, ] -
          mu_k[k, ],
        ncol = 1
      )

      sigma <-
        sigma +
        gamma[i, k] *
        (x_mu %*% t(x_mu))
    }

    sigma_k[[k]] <-
      sigma / Nk[k] +
      diag(1e-6, d)
  }

  return(
    list(
      pi_k = pi_k,
      mu_k = mu_k,
      sigma_k = sigma_k
    )
  )
}

log_likelihood <- function(
  X,
  pi_k,
  mu_k,
  sigma_k
) {

  n <- nrow(X)

  K <- length(pi_k)

  logL <- 0

  for (i in 1:n) {

    temp <- 0

    for (k in 1:K) {

      temp <- temp +
        pi_k[k] *
        gaussian_density(
          X[i, , drop = FALSE],
          mu_k[k, ],
          sigma_k[[k]]
        )
    }

    logL <- logL + log(temp)
  }

  return(logL)
}

max_iter <- 20

logL_values <- numeric(
  max_iter
)

for (iter in 1:max_iter) {

  cat(
    "\nIteration:",
    iter,
    "\n"
  )

  gamma <- E_step(
    X,
    pi_k,
    mu_k,
    sigma_k
  )

  params <- M_step(
    X,
    gamma
  )

  pi_k <- params$pi_k
  mu_k <- params$mu_k
  sigma_k <- params$sigma_k

  logL_values[iter] <-
    log_likelihood(
      X,
      pi_k,
      mu_k,
      sigma_k
    )

  cat(
    "Log-Likelihood:",
    logL_values[iter],
    "\n"
  )

  if (
    iter > 1 &&
      abs(
        logL_values[iter] -
          logL_values[iter - 1]
      ) < 1e-4
  ) {
    cat(
      "\nConverged\n"
    )
    break
  }
}


clusters <- apply(
  gamma,
  1,
  which.max
)



dir.create(
  "Output",
  showWarnings = FALSE
)

result <- data.frame(
  Feature1 = X[, 1],
  Feature2 = X[, 2],
  Cluster = clusters
)

write.csv(
  result,
  "Output/GMM_Cluster_Output.csv",
  row.names = FALSE
)

# Dataset Plot
png(
  "Output/Dataset.png",
  width = 1000,
  height = 800
)

plot(
  X,
  col = "blue",
  pch = 16,
  main = "Generated Dataset"
)

dev.off()

# Final Clusters Plot
png(
  "Output/Final_Clusters.png",
  width = 1000,
  height = 800
)

plot(
  X,
  col = clusters,
  pch = 16,
  main = "GMM Clusters"
)

points(
  mu_k,
  col = 1:K,
  pch = 8,
  cex = 3
)

dev.off()

# Log Likelihood Plot
png(
  "Output/LogLikelihood.png",
  width = 1000,
  height = 800
)

plot(
  logL_values,
  type = "l",
  lwd = 2,
  main = "Log Likelihood",
  xlab = "Iteration",
  ylab = "Value"
)

dev.off()

cat("\n=========================\n")
cat("FINAL RESULTS\n")
cat("=========================\n")

cat("\nMixing Coefficients\n")
print(pi_k)

cat("\nMeans\n")
print(mu_k)

cat("\nCovariance Matrices\n")
print(sigma_k)

cat("\nCluster Counts\n")
print(table(clusters))

cat("\nCompleted Successfully\n")