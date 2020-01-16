\name{compositionPop2}
\alias{compositionPop2}
\alias{simul_boxplot2}


\title{ Plot boxplot to see the distribution of the results from several 
iterations of oncoSimulPop
}
\description{
Extract the last result for each genotype from different simulations of 
oncoSimulPop to create a data frame which is used to plot boxplot with ggplot2
in order to see the distribution of the results from several simulations. 

}
\usage{
compositionPop2(objPop, cols = NULL ...)


simul_boxplot2(df, main = FALSE, xlab = "Genotype", ylab = "N", colors)
}

\arguments{
  \item{objPop}{
Data frame from the class oncosimulpop or oncosimul which contains the results
of the simulations in pop.by.time
}
  \item{cols}{
  Colours used to represent the boxplot. If cols = NULL colours from stacked plots of OncoSimulR are used. 
  }
  \item{df}{
  Data frame created by compositionPop2 which contains the last result from several simulations
  }
  \item{main}{
  Optional title for the boxplot. If main = FALSE no title is shown. If main is different from FALSE the boxplot title will be the string passed in main. 
  }
  \item{xlab}{
  Text for x axis label
  }
  \item{ylab}{
  Text for y axis label
  }
  \item{colors}{
  Parameter of simul_boxplot2 which receives the colours used to plot boxplots.
  }
}

\author{
Sara Dorado Alfaro
Miguel Hernandez del Valle,
Alvaro Huertas Garciaa,
Diego Mannanes Cayero,
Alejandro Martin Munnooz
}

\examples{
S1S2_LV <- function(r1, r2, K1, K2, a_12, a_21, awt = 1,
                    gt = c("WT", "S1", "S2")) {
  data.frame(Genotype = gt,
             Fitness = c(
               paste0("max(0.1, 1 - ", awt, " * (n_2 + n_1))"),
               paste0("1 + ", r1,
                      " * ( 1 - (n_1 + ", a_12, " * n_2)/", K1,
                      ")"),
               paste0("1 + ", r2,
                      " * ( 1 - (n_2 + ", a_21, " * n_1)/", K2,
                      ")")
             ))
}

## Show expressions for birth rates
S1S2_LV("r1", "r2", "K1", "K2", "a_12", "a_21", "awt")

S1S2_competition <-allFitnessEffects(
    genotFitness = S1S2_LV(1.2, 1.7, 350, 400, 0, 0, ## a_12, a_21 are 0
              gt = c("WT", "S1", "S2")),
    frequencyDependentFitness = TRUE,
    frequencyType = "abs", ## frequency expressed in absolute terms
    spPopSizes = c(50, 50, 50)) ## Same population, lower than K

## Plot fitness landscape of genotype "S1, S2" evaluation
data.frame("S1_fitness" = evalGenotype(genotype = "S1", 
                                       fitnessEffects = S1S2_competition), 
           "S2_fitness" = evalGenotype(genotype = "S2", 
                                       fitnessEffects = S1S2_competition))

S1S2_simulation <- oncoSimulPop(20, S1S2_competition, ## 10 simulations
                              model = "Exp",
                              mc.cores = n_cores,
                              onlyCancer = FALSE,
                              finalTime = 500,
                              mu = 1e-1, ## Allows appearance of S1 and S2
                              initSize = 4000,
                              seed = NULL,
                              errorHitMaxTries = FALSE,
                              errorHitWallTime = FALSE)
                              

## Plot boxplots                          
compositionPop2(S1S2_simulation, main = "No competition effect", 
                ylab = "Number of individuals")

{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
