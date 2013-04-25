pkgname <- "FHtest"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('FHtest')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("FHtesticp")
### * FHtesticp

flush(stderr()); flush(stdout())

### Name: FHtesticp
### Title: The Fleming-Harrington test for interval-censored data based on
###   a permutation distribution
### Aliases: FHtesticp FHtesticp.default FHtesticp.formula
### Keywords: survival

### ** Examples

## Performs a two-sample test
data(bcos)
FHtesticp(Surv(left,right,type="interval2")~treatment,data=bcos)

FHtesticp(Surv(left,right,type="interval2")~treatment,data=bcos,exact=TRUE)

FHtesticp(Surv(left,right,type="interval2")~treatment,data=bcos,rho=1)

data(duser)
FHtesticp(Surv(left,right,type="interval2")~as.factor(age>21), data=duser,rho=1,
          Lin=TRUE,Rin=TRUE,subset=(zper==3), icontrol=icfitControl(maxit=100000))

## Performs a trend test
data(illust3)
FHtesticp(Surv(left,right,type="interval2")~group,data=illust3,alternative="increasing",
          subset=c(1:100,601:700,1201:1300),lambda=1,Lin=TRUE,Rin=TRUE)

## Performs a k-sample test
FHtesticp(Surv(left,right,type="interval2")~as.character(zper),data=duser,rho=3,lambda=3,
          Lin=TRUE,Rin=TRUE,subset=(zper>1)&(zgen==0))



cleanEx()
nameEx("FHtestics")
### * FHtestics

flush(stderr()); flush(stdout())

### Name: FHtestics
### Title: The Fleming-Harrington test for interval-censored data based on
###   a score vector distribution
### Aliases: FHtestics FHtestics.default FHtestics.formula
### Keywords: survival

### ** Examples

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



cleanEx()
nameEx("FHtestrcc")
### * FHtestrcc

flush(stderr()); flush(stdout())

### Name: FHtestrcc
### Title: The Fleming-Harrington test for right-censored data based on
###   counting processes
### Aliases: FHtestrcc FHtestrcc.default FHtestrcc.formula
### Keywords: survival

### ** Examples

## Performs a two-sample  test
FHtestrcc(Surv(futime, fustat) ~ rx,data=ovarian)

FHtestrcc(Surv(futime, fustat) ~ rx,data=ovarian, rho=1)

## Performs a trend test
library(KMsurv)
data(bmt)
FHtestrcc(Surv(t2,d3)~group,data=bmt,rho=1,alternative="decreasing")

## Performs a k-sample test
FHtestrcc(Surv(t2,d3)~as.character(group),data=bmt,rho=1,lambda=1)



cleanEx()
nameEx("FHtestrcp")
### * FHtestrcp

flush(stderr()); flush(stdout())

### Name: FHtestrcp
### Title: The Fleming-Harrington test for right-censored data based on
###   permutations
### Aliases: FHtestrcp FHtestrcp.default FHtestrcp.formula
### Keywords: survival

### ** Examples

## Performs a two-sample  test	
FHtestrcp(Surv(futime, fustat) ~ rx,data=ovarian)

FHtestrcp(Surv(futime, fustat) ~ rx,data=ovarian,method="exact.network")

FHtestrcp(Surv(futime, fustat) ~ rx,data=ovarian,rho=1)

## Performs a trend test
library(KMsurv)
data(bmt)
FHtestrcp(Surv(t2,d3)~group,data=bmt,rho=1,alternative="decreasing")

FHtestrcp(Surv(t2,d3)~group,data=bmt,rho=1,alternative="decreasing",exact=TRUE)

## Performs a k-sample test
FHtestrcp(Surv(t2,d3)~as.character(group),data=bmt,rho=1,lambda=1)



### * <FOOTER>
###
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
