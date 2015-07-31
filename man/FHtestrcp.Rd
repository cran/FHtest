\name{FHtestrcp}
\alias{FHtestrcp}
\alias{FHtestrcp.default}
\alias{FHtestrcp.formula}
\title{The Fleming-Harrington test for right-censored data based on permutations}
\description{The \code{FHtestrcp} function performs a test for right-censored data based on a permutation distribution. It uses the G-\eqn{\rho,\lambda} family of statistics for testing the differences of two or more survival curves.}
\usage{
\method{FHtestrcp}{default}(L, R, group, rho = 0, lambda = 0, alternative, method = NULL,
          methodRule = methodRuleIC1, exact = NULL, permcontrol = permControl(), ...)
\method{FHtestrcp}{formula}(formula, data, subset, na.action, ...)
}
\arguments{
  \item{L}{Numeric vector of the left endpoints of the censoring intervals (exact and right-censored data are represented as intervals of [a,a] and (a, infinity) respectively).}
  \item{R}{Numeric vector of the right endpoints of the censoring intervals (exact and right-censored data are represented as intervals of [a,a] and (a, infinity) respectively).}
  \item{group}{A vector denoting the group variable for which the test is desired. If \code{group} is a factor or character, then a k-sample test is performed, where k is the number of unique values of \code{group}. If \code{group} is numeric, then a trend ("correlation" type) test is performed. If there are only two groups, both methods give the same results.}
  \item{rho}{A scalar parameter that controls the type of test (see details).}
  \item{lambda}{A scalar parameter that controls the type of test (see details).}
  \item{alternative}{Character giving the type of alternative hypothesis for two-sample and trend tests: \code{"different"}, \code{"increasing"} or \code{"decreasing"} survival functions. For the k-sample case, \code{"different"} should be chosen.}
  \item{method}{A character value, one of \code{"pclt"}, \code{"exact.network"}, \code{"exact.ce"}, \code{"exact.mc"}. If no value is specified, function \code{methodRule} chooses the value.}
  \item{methodRule}{A function used to choose the method. Default value is \code{methodRuleIC1} (see details in \link[perm]{perm}).}
  \item{exact}{A logical value, where \code{TRUE} denotes exact test. Ignored if \code{method} is not \code{NULL}.}
  \item{permcontrol}{List of arguments for controlling permutation tests. Default value is \code{permControl}.}
  \item{formula}{A formula with a numeric vector as response (which assumes no censoring) or \code{Surv} object. The right side of the formula is the group variable. No \code{strata()} is allowed.}
  \item{data}{Data frame for variables in \code{formula}.}
  \item{subset}{An optional vector specifying a subset of observations to be used.}
  \item{na.action}{A function that indicates what should happen if the data contain \code{NA}s. Default value is set to \code{getOption("na.action")}.}
  \item{\dots}{Additional arguments.}
}
\details{
The appropriate selection of the parameters \code{rho} and \code{lambda} gives emphasis to early, middle or late hazard differences. For instance, in a given clinical trial, if one would like to assess whether the effect of a treatment or therapy on the survival is stronger at the earlier phases of the therapy, we should choose \code{lambda= 0}, with increasing values of \code{rho} emphasizing stronger early differences. If there were a clinical reason to believe that the effect of the therapy would be more pronounced towards the middle or the end of the follow-up period, it would make sense to choose \code{rho = lambda > 0} or \code{rho = 0} respectively, with increasing values of \code{lambda} emphasizing stronger middle or late differences. The choice of the weights has to be made prior to the examination of the data and taking into account that they should provide the greatest statistical power, which in turns depends on how it is believed the null is violated.

Many standard statistical tests may be put into the form of the permutation test (see Graubard and Korn, 1987). There is a choice of four different methods to calculate the \emph{p}-values (the last two are only available for the two-sample test): (1) \code{pclt}: using permutational central limit theorem (see, e.g., Sen, 1985). (2) \code{exact.mc}: exact method using Monte Carlo. (3) \code{exact.network}: exact method using a network algorithm (see, e.g., Agresti, Mehta, and Patel, 1990). Currently, the network method does not implement many of the time saving suggestions such as clubbing. (4) \code{exact.ce}: exact method using complete enumeration. This is good for very small sample sizes and when doing simulations, since the complete enumeration matrix need only be calculated once for the simulation.

There are several ways to perform the permutation test, and the function \code{methodRuleIC1} chooses which of these ways will be used. The choice is basically between using a permutational central limit theorem (\code{method="pclt"}) or using an exact method. There are several algorithms for the exact method. Note that there are two exact two-sided methods for calculating p-values (see \code{permControl} and the \code{tsmethod} option).}

\value{
        \item{information}{Full description of the test.}
        \item{data.name}{Description of data variables.}
        \item{n}{Number of observations in each group.}
        \item{diff}{The weighted observed minus expected number of events in each group.}
        \item{scores}{Vector with the same length as \code{L} and \code{R}, containing the rank scores (see Kalbfleisch and Prentice, 2003).}
        \item{statistic}{Either the chi-square or Z statistic.}
        \item{var}{The variance matrix of the test.}
        \item{alt.phrase}{Phrase used to describe the alternative hypothesis.}
        \item{pvalue}{\emph{p}-value associated with the alternative hypothesis.}
        \item{p.conf.int}{Confidence interval of \emph{p}-value. For \code{method='exact.mc'} only.}
        \item{call}{The matched call.}
}
\references{
        Abd-Elfattah, E. F. and Butler, R. W. (2007). The weighted log-rank class of permutation tests: P-values and confidence intervals using saddlepoint methods. Biometrika \bold{94}, 543--551.

        Fleming, T. R. and Harrington, D. P. (2005). \emph{Counting Processes and Survival Analysis} New York: Wiley.

        Harrington, D. P. and Fleming, T. R. (1982). A class of rank test procedures for censored survival data. Biometrika \bold{69}, 553--566.

        Kalbfleisch, J. D. and Prentice, R. L. (2002). \emph{The Statistical Analysis of Failure Time Data.} New York: Wiley, 2nd Edition.

        Lawless, J. F. (2003). \emph{Statistical Models and Methods for Lifetime Data.} New York: Wiley, 2nd Edition.
}
\author{R. Oller and K. Langohr}
\seealso{\link{FHtestrcc}}
\examples{
## Two-sample tests	
FHtestrcp(Surv(futime, fustat)~rx, data=ovarian)
FHtestrcp(Surv(futime, fustat)~rx, data=ovarian, method="exact.network")
FHtestrcp(Surv(futime, fustat)~rx, data=ovarian, rho=1)

## Trend tests
library(KMsurv)
data(bmt)
FHtestrcp(Surv(t2, d3)~group, data=bmt, rho=1, alternative="decreasing")
FHtestrcp(Surv(t2, d3)~group, data=bmt, rho=1, alternative="decreasing", exact=TRUE)

## K-sample test
FHtestrcp(Surv(t2, d3)~as.character(group), data=bmt, rho=1, lambda=1)
}

\keyword{survival}
