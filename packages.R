### Write down what package versions work with your R code, and
### attempt to download and load those packages. The first argument is
### the version of R that you used, e.g. "3.0.2" and then the rest of
### the arguments are package versions. For
### CRAN/Bioconductor/R-Forge/etc packages, write
### e.g. RColorBrewer="1.0.5" and if RColorBrewer is not installed
### then we use install.packages to get the most recent version, and
### warn if the installed version is not the indicated version. For
### GitHub packages, write "user/repo@commit"
### e.g. "tdhock/animint@f877163cd181f390de3ef9a38bb8bdd0396d08a4" and
### we use install_github to get it, if necessary.
works_with_R <- function(Rvers,...){
  pkg_ok_have <- function(pkg,ok,have){
    stopifnot(is.character(ok))
    if(!as.character(have) %in% ok){
      warning("works with ",pkg," version ",
              paste(ok,collapse=" or "),
              ", have ",have)
    }
  }
  pkg_ok_have("R",Rvers,getRversion())
  pkg.vers <- list(...)
  for(pkg.i in seq_along(pkg.vers)){
    vers <- pkg.vers[[pkg.i]]
    pkg <- if(is.null(names(pkg.vers))){
      ""
    }else{
      names(pkg.vers)[[pkg.i]]
    }
    if(pkg == ""){# Then it is from GitHub.
      ## suppressWarnings is quieter than quiet.
      if(!suppressWarnings(require(requireGitHub))){
        ## If requireGitHub is not available, then install it using
        ## devtools.
        if(!suppressWarnings(require(devtools))){
          install.packages("devtools")
          require(devtools)
        }
        install_github("tdhock/requireGitHub")
        require(requireGitHub)
      }
      requireGitHub(vers)
    }else{# it is from a CRAN-like repos.
      if(!suppressWarnings(require(pkg, character.only=TRUE))){
        install.packages(pkg)
      }
      pkg_ok_have(pkg, vers, packageVersion(pkg))
      library(pkg, character.only=TRUE)
    }
  }
}
options(repos="http://cloud.r-project.org")
works_with_R(
  "3.3.3",
  httr="1.2.1",
  gtable="0.2.0",
  reshape2="1.4.1",
  plyr="1.8.4",
  scales="0.4.1",
  "faizan-khan-iit/ggplot2@5fb99d0cece13239bbbc09c6b8a7da7f86ac58e2",
  ggdendro="0.1.20",
  testthat="1.0.2",
  RJSONIO="1.3.1",
  hexbin="1.27.1",
  xtable="1.7.4",
  doParallel="1.0.6",
  future="1.4.0",
  geometry="0.3.6",#for penaltyLearning.
  data.table="1.10.4",
  directlabels="2017.3.31",
  "tdhock/penaltyLearning@cd865e1bc1537268d51575b4a555673b1129a964",
  "tdhock/PeakError@b0f0b4edc413176ebb183fc68f1504c9d86e3ef7",
  "tdhock/coseg@2a98e7649f6085051a5fda12a25d992b892f5431",
  "tdhock/animint@78974d8788930034109289e42f8c90f1ee804290",
  "tdhock/PeakSegJoint@08067ba5794c4641224102a20e5f838900bd4c1c",
  "tdhock/cosegData@83e6f787bf4f9f9ec7d299bb9e6b32db522021a2",
  "tdhock/namedCapture@05175927a45c301a18e8c6ebae67ea39a842d264",
  "tdhock/WeightedROC@ef8f35ba7ae85e2995fa66afe13732cebb8b5633")
