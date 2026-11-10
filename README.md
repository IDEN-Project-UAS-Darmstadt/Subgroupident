# Subgroup Identification and Simulation Study

This repository contains the R code to recreate the simulation study used in "Combining machine learning methods for subgroup identification in time-to-event
data with approximate Bayesian computation for bias correction", submitted to the Journal of Biopharmaceutical Statistics.

## Setup

This script should be run with R version 4.4.3. The following commands can be used under linux to install `rig` and the right R version (without root privileges):

```sh
curl -LsSf https://r-lib.github.io/rig/install.sh | sh
# reopen your terminal

rig system user-mode
rig add 4.4.3
rig default 4.4.3
# reopen your terminal

# We require R Markdown
rig pkg install rmarkdown@=2.31 renv@=1.1.7
```

## Running

The following commands run the simulations shown in the study:

```sh
Rscript run_simulation_study.R MOB marginal strong ideal

Rscript run_simulation_study.R MOB marginal strong linf

Rscript run_simulation_study.R MOB marginal strong minf
```

```sh
Rscript run_simulation_study.R MOB marginal moderate ideal

Rscript run_simulation_study.R MOB marginal moderate linf

Rscript run_simulation_study.R MOB marginal moderate minf
```

```sh
Rscript run_simulation_study.R MOB marginal null ideal

Rscript run_simulation_study.R MOB marginal null linf

Rscript run_simulation_study.R MOB marginal null minf
```

Run results are written to the folder "results" 

Child simulation processes may keep running when force quitting the parent process. These can be stopped with `killall R`.  
