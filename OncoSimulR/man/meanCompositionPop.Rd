\name{meanCompositionPop}
\alias{meanCompositionPop}
\alias{stripChartPop}

\title{
Plot stripChart to see the distribution of the mean results from several 
iterations of oncoSimulPop since the half to the end of simulation.
}
\description{
It allows to see the distribution of results form several simulations from
oncosimulPop.It generates a strip chart with the average of the results from the middle to the end of a simulation for each genotype. 
}
\usage{
meanCompositionPop(objPop, ylab = "N", ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{objPop}{
Data frame from the class oncosimulpop or oncosimul which contains the results
of the simulations in \code{pop.by.time}.
}
  \item{ylab}{
  Text for y axis label.
  }
}

\author{
Sara Dorado Alfaro,
Miguel Hernandez del Valle,
Alvaro Huertas Garcia,
Diego Mannanes Cayero,
Alejandro Martin Munnoz.
}

\examples{

## Map fitness
crs <- function (a, b, c){
  data.frame(Genotype = c("WT", "C", "R"),
             Fitness = c(paste0("1 + ", a, " * f_2 - ", b, " * f_1"),
                         paste0("1 + ", b, " * f_ - ", c, " * f_2"),
                         paste0("1 + ", c, " * f_1 - ", a, " * f_")
             ))
}

## Set frequency-dependent fitness
afcrs2 <- allFitnessEffects(genotFitness = crs(10, 1, 1), 
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")

## Run simulations
resultscrs2 <- oncoSimulPop(10,
                           afcrs2,
                             model = "McFL", 
                             onlyCancer = FALSE,
                             finalTime = 100, 
                             mu = 1e-2,
                             initSize = 4000, 
                             keepPhylog = TRUE,
                             seed = NULL,
                             errorHitMaxTries = FALSE,
                             errorHitWallTime = FALSE)

## Create strip chart plot
meanCompositionPop(resultscrs2, ylab = "Number of cells", cex.lab=1.1,
     las = 1)

{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
