\name{FHtesticp}
\alias{FHtesticp}
\alias{FHtesticp.default}
\alias{FHtesticp.formula}
\title{The Fleming-Harrington test for interval-censored data based on a permutation distribution}
\description{The \code{FHtesticp} function performs a test for interval-censored data based on a permutation distribution. It uses the G-\eqn{\rho,\lambda} family of statistics for testing the differences of two or more survival curves.}
\usage{
\method{FHtesticp}{default}(L, R, group, rho=0, lambda=0, alternative, permcontrol=permControl(),
          icFIT=NULL, initfit=NULL, icontrol=icfitControl(), exact=NULL,
          method=NULL, methodRule=methodRuleIC1, Lin=NULL, Rin=NULL, ...)
\method{FHtesticp}{formula}(formula, data, subset, na.action, ...)
}
\arguments{
  \item{L}{Numeric vector of the left endpoints of the censoring intervals (equivalent to the first element of \code{Surv} when \code{type='interval2'}).}
  \item{R}{Numeric vector of the right endpoints of the censoring intervals (equivalent to the second element of \code{Surv} when \code{type='interval2'}).}
  \item{group}{A vector denoting the group variable for which the test is desired. If \code{group} is a factor or character, then a k-sample test is performed, where k is the number of unique values of \code{group}. If \code{group} is numeric, then a trend ("correlation" type) test is performed. If there are only two groups, both methods give the same results.}
  \item{rho}{A scalar parameter that controls the type of test (see details).}
  \item{lambda}{A scalar parameter that controls the type of test (see details).}
  \item{alternative}{Character giving the type of alternative hypothesis for two-sample and trend tests: \code{"different"}, \code{"increasing"} or \code{"decreasing"} survival functions. For the k-sample case, \code{"different"} should be chosen.}
  \item{icFIT}{A precalculated \code{icfit} object for increased computation speed. This should be the \code{icfit} from the pooled data. Normally \code{initfit} should be used instead (see Warning below).}
  \item{initfit}{An object of class \code{icfit} or \code{icsurv} or a character vector giving a function name, used for the initial estimate (see Warning below). Ignored if \code{icFIT} is not \code{NULL}.}
  \item{permcontrol}{List of arguments for controlling permutation tests. Default value is \code{permControl}.}
  \item{icontrol}{List of arguments for controling the NPMLE algorithm in call to \code{icfit}. Default value is \code{icfitControl}.}
  \item{exact}{A logical value, where \code{TRUE} denotes exact test. Ignored if \code{method} is not \code{NULL}.}
  \item{method}{A character value, one of \code{"pclt"}, \code{"exact.network"}, \code{"exact.ce"}, \code{"exact.mc"}. If no value is specified, function \code{methodRule} chooses the value.}
  \item{methodRule}{A function used to choose the method. Default value is \code{methodRuleIC1} (see details in \link[perm]{perm}).}
  \item{Lin}{Logical vector: should \code{L} be included in the interval?}
  \item{Rin}{Logical vector: should \code{R} be included in the interval?}
  \item{formula}{A formula with a numeric vector as response (which assumes no censoring) or \code{Surv} object. The right side of the formula is the group variable. No \code{strata()} is allowed.}
  \item{data}{Data frame for variables in \code{formula}.}
  \item{subset}{An optional vector specifying a subset of observations to be used.}
  \item{na.action}{A function that indicates what should happen if the data contain \code{NA}s. Default value is set to \code{getOption("na.action")}.}
  \item{\dots}{Additional arguments.}
}
\details{
The appropriate selection of the parameters \code{rho} and \code{lambda} gives emphasis to early, middle or late hazard differences. For instance, in a given clinical trial, if one would like to assess whether the effect of a treatment or therapy on the survival is stronger at the earlier phases of the therapy, we should choose \code{lambda= 0}, with increasing values of \code{rho} emphasizing stronger early differences. If there were a clinical reason to believe that the effect of the therapy would be more pronounced towards the middle or the end of the follow-up period, it would make sense to choose \code{rho = lambda > 0} or \code{rho = 0} respectively, with increasing values of \code{lambda} emphasizing stronger middle or late differences. The choice of the weights has to be made prior to the examination of the data and taking into account that they should provide the greatest statistical power, which in turns depends on how it is believed the null is violated.

The censoring in the default case (when \code{Lin=Rin=NULL}) assumes there are n (\code{n=length(L)}) failure times, and the \emph{i}th one is in the interval between \code{L[i]} and \code{R[i]}. The default is not to include \code{L[i]} in the interval unless \code{L[i]=R[i]}, and to include \code{R[i]} in the interval unless \code{R[i]=Inf}. When \code{Lin} and \code{Rin} are not \code{NULL} they describe whether to include \code{L} and \code{R} in the associated interval. If either \code{Lin} or \code{Rin} is length 1 then it is repeated n times, otherwise they should be logicals of length n.

Many standard statistical tests may be put into the form of the permutation test (see Graubard and Korn, 1987). There is a choice of four different methods to calculate the \emph{p}-values (the last two are only available for the two-sample test): (1) \code{pclt}: using permutational central limit theorem (see, e.g., Sen, 1985). (2) \code{exact.mc}: exact method using Monte Carlo. (3) \code{exact.network}: exact method using a network algorithm (see, e.g., Agresti, Mehta, and Patel, 1990). Currently, the network method does not implement many of the time saving suggestions such as clubbing. (4) \code{exact.ce}: exact method using complete enumeration. This is good for very small sample sizes and when doing simulations, since the complete enumeration matrix need only be calculated once for the simulation.

There are several ways to perform the permutation test, and the function \code{methodRuleIC1} chooses which of these ways will be used. The choice is basically between using a permutational central limit theorem (\code{method="pclt"}) or using an exact method. There are several algorithms for the exact method. Note that there are two exact two-sided methods for calculating p-values (see \code{permControl} and the \code{tsmethod} option).}

\value{
        \item{information}{Full description of the test.}
        \item{data.name}{Description of data variables.}
        \item{n}{Number of observations in each group.}
        \item{fit}{Object of class \code{icfit} giving the NPMLE of all responses combined (ignoring the group variable).}
        \item{diff}{The weighted observed minus expected number of events in each group.}
        \item{scores}{Vector with the same length as \code{L} and \code{R}, containing the rank scores (see Oller and Gómez, 2012).}
        \item{statistic}{Either the chi-square or Z statistic.}
        \item{var}{The variance matrix of the test.}
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
\seealso{\link{FHtestics}, \link[interval]{icfit} (Package \code{interval}), \link[Icens]{icsurv} (Package \code{Icens}).}
\examples{
## Performs a two-sample test
data(bcos)
FHtesticp(Surv(left, right, type="interval2")~treatment, data=bcos)

FHtesticp(Surv(left, right, type="interval2")~treatment, data=bcos, exact=TRUE)

FHtesticp(Surv(left, right, type="interval2")~treatment, data=bcos, rho=1)

data(duser)
FHtesticp(Surv(left, right, type="interval2")~as.factor(age>21), data=duser, rho=1,
          Lin=TRUE, Rin=TRUE, subset=(zper==3), icontrol=icfitControl(maxit=100000))

## Performs a trend test
data(illust3)
FHtesticp(Surv(left, right, type="interval2")~group, data=illust3, alternative="increasing",
          subset=c(1:100, 601:700, 1201:1300), lambda=1, Lin=TRUE, Rin=TRUE)

## Performs a k-sample test
FHtesticp(Surv(left, right, type="interval2")~as.character(zper), data=duser, rho=3, lambda=3,
          Lin=TRUE, Rin=TRUE, subset=(zper>1)&(zgen==0))
}

\keyword{survival}
