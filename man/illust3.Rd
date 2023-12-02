\name{illust3} 
\alias{illust3} 
\docType{data} 
\title{Data set of an AIDS clinical trial} 
\description{Data set from an AIDS clinical trial designed to study the benefits of Zidovudine therapy in patients in the early stage of HIV infection. It contains interval-censored data of 1607 individuals.}
\usage{data(illust3)} 
\format{
  A data frame with 1607 observations on the following 3 variables.
  \describe{
    \item{\code{left}}{Left endpoint of censoring interval.}
    \item{\code{right}}{Right endpoint of censoring interval.}
    \item{\code{group}}{Treatment group (1 = deferred therapy; 2 = 500 mg/day dosage; 3 = 1500 mg/day dosage).}
  }
} 
\references{
        Calle, M. L. and Gómez, G. (2001). Nonparametric Bayesian estimation from interval-censored data using Monte Carlo methods. Journal of
        Statistical Planning and Inference \bold{98}, 73--87.

        Gómez, G., Calle, M. L. and Oller, R. (2004). Frequentist and Bayesian approaches for interval-censored data and their implementation in R.
        Statistical Papers \bold{45}, 139--173.

        Volberding, P. A., Lagakos, S. W., Grimes, J. M., Stein, D. S., \emph{et al.} (1995). A Comparison of Immediate with Deferred Zidovudine
        Therapy for Asymptomatic HIV-Infected Adults with CD4 Cell Counts of 500 or More per Cubic Millimeter. The New England Journal of Medicine
        \bold{333}, 401--407.
} 
%\examples{ %data(illust3) %## maybe str(illust3) ; plot(illust3) ... %} 
\keyword{datasets}
