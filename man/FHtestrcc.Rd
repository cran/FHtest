\name{FHtestrcc}
\alias{FHtestrcc}
\alias{FHtestrcc.default}
\alias{FHtestrcc.formula}
\title{The Fleming-Harrington test for right-censored data based on counting processes}
\description{The \code{FHtestrcc} function performs a test for right-censored data based on counting processes. It uses the G-\eqn{\rho,\lambda} family of statistics for testing the differences of two or more survival curves.}
\usage{
\method{FHtestrcc}{default}(L, R, group, rho=0, lambda=0, alternative, ...)
\method{FHtestrcc}{formula}(formula, data, subset, na.action, ...)
}
\arguments{
  \item{L}{Numeric vector of the left endpoints of the censoring intervals (exact and right-censored data are represented as intervals of [a,a] and (a, infinity) respectively).}
  \item{R}{Numeric vector of the right endpoints of the censoring intervals (exact and right-censored data are represented as intervals of [a,a] and (a, infinity) respectively).}
   \item{group}{A vector denoting the group variable for which the test is desired. If \code{group} is a factor or character, then a k-sample test is performed, where k is the number of unique values of \code{group}. If \code{group} is numeric, then a trend ("correlation" type) test is performed. If there are only two groups, both methods give the same results.}
  \item{rho}{A scalar parameter that controls the type of test (see details).}
  \item{lambda}{A scalar parameter that controls the type of test (see details).}
  \item{alternative}{Character giving the type of alternative hypothesis for two-sample and trend tests: \code{"different"}, \code{"increasing"} or \code{"decreasing"} survival functions. For the k-sample case, \code{"different"} should be chosen.}
  \item{formula}{A formula with a numeric vector as response (which assumes no censoring) or \code{Surv} object. The right side of the formula is the group variable. No \code{strata()} is allowed.}
  \item{data}{Data frame for variables in \code{formula}.}
  \item{subset}{An optional vector specifying a subset of observations to be used.}
  \item{na.action}{A function that indicates what should happen if the data contain \code{NA}s. Default value is set to \code{getOption("na.action")}.}
  \item{\dots}{Additional arguments.}
}
\details{
The appropriate selection of the parameters \code{rho} and \code{lambda} gives emphasis to early, middle or late hazard differences. For instance, in a given clinical trial, if one would like to assess whether the effect of a treatment or therapy on the survival is stronger at the earlier phases of the therapy, we should choose \code{lambda= 0}, with increasing values of \code{rho} emphasizing stronger early differences. If there were a clinical reason to believe that the effect of the therapy would be more pronounced towards the middle or the end of the follow-up period, it would make sense to choose \code{rho = lambda > 0} or \code{rho = 0} respectively, with increasing values of \code{lambda} emphasizing stronger middle or late differences. The choice of the weights has to be made prior to the examination of the data and taking into account that they should provide the greatest statistical power, which in turns depends on how it is believed the null is violated.
}

\value{
        \item{information}{Full description of the test.}
        \item{data.name}{Description of data variables.}
        \item{n}{Number of observations in each group.}
        \item{obs}{The weighted observed number of events in each group.}
        \item{exp}{The weighted expected number of events in each group.}
        \item{statistic}{Either the chi-square or Z statistic.}
        \item{var}{The variance matrix of the test.}
        \item{alt.phrase}{Phrase used to describe the alternative hypothesis.}
        \item{pvalue}{\emph{p}-value associated with the alternative hypothesis.}
        \item{call}{The matched call.}
}
\references{
        Fleming, T. R. and Harrington, D. P. (2005). \emph{Counting Processes and Survival Analysis} New York: Wiley.

        Harrington, D. P. and Fleming, T. R. (1982). A class of rank test procedures for censored survival data. Biometrika \bold{69}, 553--566.

        Kalbfleisch, J. D. and Prentice, R. L. (2002). \emph{The Statistical Analysis of Failure Time Data.} New York: Wiley, 2nd Edition.

        Lawless, J. F. (2003). \emph{Statistical Models and Methods for Lifetime Data.} New York: Wiley, 2nd Edition.
}
\author{R. Oller and K. Langohr}
\seealso{\link{FHtestrcp}}
\examples{
## Two-sample tests
FHtestrcc(Surv(futime, fustat)~rx, data=ovarian)
FHtestrcc(Surv(futime, fustat)~rx, data=ovarian, rho=1)

## Trend test
library(KMsurv)
data(bmt)
FHtestrcc(Surv(t2, d3)~group, data=bmt, rho=1, alternative="decreasing")

## K-sample test
FHtestrcc(Surv(t2, d3)~as.character(group), data=bmt, rho=1, lambda=1)
}

\keyword{survival}
