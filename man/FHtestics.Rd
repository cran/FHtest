\name{FHtestics}
\alias{FHtestics}
\alias{FHtestics.default}
\alias{FHtestics.formula}
\title{The Fleming-Harrington test for interval-censored data based on a score vector distribution}
\description{The \code{FHtestics} function performs a test for interval-censored data based on a score vector distribution. It uses the G-\eqn{\rho} family of statistics (being \eqn{\lambda=0}) for testing the differences of two or more survival curves.}
\usage{
\method{FHtestics}{default}(L, R, group, rho = 0, lambda = 0, alternative, tol = 10^-8, icFIT = NULL,
          initfit = NULL, icontrol = icfitControl(), Lin = NULL, Rin = NULL, ...)
\method{FHtestics}{formula}(formula, data, subset, na.action, ...)
}
\arguments{
  \item{L}{Numeric vector of the left endpoints of the censoring intervals (equivalent to the first element of \code{Surv} when \code{type='interval2'}).}
  \item{R}{Numeric vector of the right endpoints of the censoring intervals (equivalent to the second element of \code{Surv} when \code{type='interval2'}).}
  \item{group}{A vector denoting the group variable for which the test is desired. If \code{group} is a factor or character, then a k-sample test is performed, where k is the number of unique values of \code{group}. If \code{group} is numeric, then a trend ("correlation" type) test is performed. If there are only two groups, both methods give the same results.}
  \item{rho}{A scalar parameter that controls the type of test (see details).}
  \item{lambda}{A scalar parameter that controls the type of test. With this method, lambda has to be zero.}
  \item{alternative}{Character giving the type of alternative hypothesis for two-sample and trend tests: \code{"different"}, \code{"increasing"} or \code{"decreasing"} survival functions. For the k-sample case, \code{"different"} should be chosen.}
  \item{tol}{Tolerance for the calculation of the g-inverse. Values less than \code{tol} are set to zero.}
  \item{icFIT}{A precalculated \code{icfit} object for increased computation speed. This should be the \code{icfit} from the pooled data. Normally \code{initfit} should be used instead (see Warning below).}
  \item{initfit}{An object of class \code{icfit} or \code{icsurv} or a character vector giving a function name, used for the initial estimate (see Warning below). Ignored if \code{icFIT} is not \code{NULL}.}
  \item{icontrol}{List of arguments for controling the NPMLE algorithm in call to \code{icfit}. Default value is \code{icfitControl}.}
  \item{Lin}{Logical vector: should \code{L} be included in the interval?}
  \item{Rin}{Logical vector: should \code{R} be included in the interval?}
  \item{formula}{A formula with a numeric vector as response (which assumes no censoring) or \code{Surv} object. The right side of the formula is the group variable. No \code{strata()} is allowed.}
  \item{data}{Data frame for variables in \code{formula}.}
  \item{subset}{An optional vector specifying a subset of observations to be used.}
  \item{na.action}{A function that indicates what should happen if the data contain \code{NA}s. Default value is set to \code{getOption("na.action")}.}
  \item{\dots}{Additional arguments.}
}
\details{
The appropriate selection of the parameter \code{rho} gives emphasis to early hazard differences. For instance, in a given clinical trial, if one would like to assess whether the effect of a treatment or therapy on the survival is stronger at the earlier phases of the therapy, we should choose \code{rho>0} emphasizing stronger early differences.

The censoring in the default case (when \code{Lin=Rin=NULL}) assumes there are n (\code{n=length(L)}) failure times, and the \emph{i}th one is in the interval between \code{L[i]} and \code{R[i]}. The default is not to include \code{L[i]} in the interval unless \code{L[i]=R[i]}, and to include \code{R[i]} in the interval unless \code{R[i]=Inf}. When \code{Lin} and \code{Rin} are not \code{NULL} they describe whether to include \code{L} and \code{R} in the associated interval. If either \code{Lin} or \code{Rin} is length 1 then it is repeated n times, otherwise they should be logicals of length n.

It is difficult to prove the asymptotic validity of the standard score tests for this likelihood, because the number of nuisance parameters typically grows with the sample size and often many of the parameters are equal at the nonparametric MLE, i.e., they are on the boundary of the parameter space (Fay, 1996). Specifically, when the score test is performed, an adjustment is made so that the nuisance parameters are defined based on the data and do not approach the boundary of the parameter space (see Fay, 1996). Theoretically, the score test should perform well when there are many individuals but few observation times, and its advantage in this situation is that it retains validity even when the censoring mechanism may depend on the treatment.}

\value{
        \item{information}{Full description of the test.}
        \item{data.name}{Description of data variables.}
        \item{n}{Number of observations in each group.}
        \item{fit}{Object of class \code{icfit} giving the NPMLE of all responses combined (ignoring the group variable).}
        \item{diff}{The weighted observed minus expected number of events in each group.}
        \item{scores}{Vector with the same length as \code{L} and \code{R}, containing the rank scores (see Oller and Gómez, 2012).}
        \item{statistic}{Either the chi-square or Z statistic.}
        \item{var}{The variance matrix of the test.}
        \item{d2L.dB2}{Second derivative of the log-likelihood with respect to \eqn{\beta}.}
        \item{d2L.dgam2}{Second derivative of the log-likelihood with respect to \eqn{\gamma}.}
        \item{d2L.dBdgam}{Derivative of the log-likelihood with respect to \eqn{\beta} and \eqn{\gamma}.}
        \item{alt.phrase}{Phrase used to describe the alternative hypothesis.}
        \item{pvalue}{\emph{p}-value associated with the alternative hypothesis.}
        \item{p.conf.int}{Confidence interval of \emph{p}-value. For \code{method='exact.mc'} only.}
        \item{call}{The matched call.}
}
\section{Warning}{Since the input of \code{icFIT} is only for saving computational time, no checks are carried out to determine if the \code{icFIT} is in fact the correct one. Thus, one may get wrong answers with no warnings if the wrong \code{icFIT} object is chosen. A safer way to save computational time is to choose for \code{initfit} either a precalculated \code{icfit} object or an \code{icsurv} object from a function in the \code{Icens} package such as \code{EMICM}. If this is done, either the correct answer or a warning will be returned even if a bad guess for \code{initfit} is chosen. Additionally, one may specify a function name for \code{initfit}. The default is \code{NULL} which uses a simple initial fit function (the weighted average of the \code{A} matrix, see the code of \link[interval]{icfit.default} (Package \code{interval})). A fast but somewhat unstable function uses \code{initcomputeMLE} which uses function \link[MLEcens]{computeMLE} of the 'MLEcens' package. See the help for \code{icfit} for details on the \code{initfit option.}}
\references{
        Fay, M. P. (1996). Rank invariant tests for interval-censored data under the grouped continuous model. Biometrics \bold{52}, 811--822.

        Fay, M. P. (1999). Comparing several score tests for interval-censored data. Statistics in Medicine \bold{18}, 273--285.

        Gómez, G., Calle, M. L., Oller, R. and Langohr, K. (2009). Tutorial on methods for interval-censored data and their implementation in R. Statistical Modelling \bold{9}, 259--297.

        Oller, R. and Gómez, G. (2012). A generalized Fleming and Harrington's class of tests for interval-censored data. The Canadian Journal of Statistics \bold{40}, 501--516.
}
\author{R. Oller and K. Langohr}
\seealso{\link{FHtesticp}, \link[interval]{icfit} (Package \code{interval}), \link[Icens]{icsurv} (Package \code{Icens}).}
\examples{
## Performs a two-sample  test
data(bcos)
FHtestics(Surv(left,right,type="interval2")~treatment, data=bcos)

FHtestics(Surv(left,right,type="interval2")~treatment, data=bcos, rho=1)

data(duser)
FHtestics(Surv(left,right,type="interval2")~as.numeric(age>21),data=duser,rho=1,
          Lin=TRUE,Rin=TRUE,subset=(zper==3),icontrol=icfitControl(maxit=100000))

## Performs a trend test
data(illust3)
FHtestics(Surv(left,right,type="interval2")~group, data=illust3,
          subset=c(1:100,601:700,1201:1300), rho=2, alternative="increasing",
          Lin=TRUE, Rin=TRUE)

## Performs a k-sample test
FHtestics(Surv(left,right,type="interval2")~as.factor(group), data=illust3,
          subset=c(1:100,601:700,1201:1300), rho=3, Lin=TRUE, Rin=TRUE)
}

\keyword{survival}
