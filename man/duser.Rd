\name{duser}
\alias{duser}
\docType{data}
\title{Data set of drug users in Badalona (Spain)}
\description{Data set of 940 drug users in Badalona (Spain). The data come from the detoxification unit of \emph{Hospital Universitari Germans Trias i Pujol} in Badalona, Spain}
\usage{data(duser)}
\format{
  A data frame with 940 observations on the following 5 variables.
  \describe{
    \item{\code{left}}{Left endpoint of time to HIV-infection}
    \item{\code{right}}{Right endpoint of time to HIV-infection}
    \item{\code{zper}}{Calendar period}
    \item{\code{zgen}}{Gender (0: male; 1: female)}
    \item{\code{age}}{Age}
  }
}
%\details{
%%%  ~~ If necessary, more details than the __description__ above ~~
%}
\source{Detoxification unit, Hospital Universitari Germans Trias i Pujol, Badalona, Spain.}
\references{
        Gómez, G., Calle, M. L., Egea, J. M. and Muga, R. (2000). Risk of HIV infection as a function of the duration of intravenous drug use: A non-parametric Bayesian approach. Statistics in Medicine \bold{19}, 2641--2656.

        Oller, R. and Gómez, G. (2012). A generalized Fleming and Harrington's class of tests for interval-censored data. The Canadian Journal of Statistics. doi: 10.1002/cjs.11139
}
%\examples{
%data(duser)
%## maybe str(duser) ; plot(duser) ...
%}
\keyword{datasets}
