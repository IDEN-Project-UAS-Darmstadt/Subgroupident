#!/usr/bin/env Rscript

main <- function() {
  renv::use(
    abind          = "abind@1.4-8",
    askpass        = "askpass@1.2.1",
    backports      = "backports@1.5.1",
    base64enc      = "base64enc@0.1-6",
    bit            = "bit@4.6.0",
    bit64          = "bit64@4.8.0",
    blob           = "blob@1.3.0",
    boot           = "boot@1.3-32",
    broom          = "broom@1.0.12",
    bslib          = "bslib@0.10.0",
    cachem         = "cachem@1.1.0",
    calculus       = "calculus@1.1.0",
    callr          = "callr@3.7.6",
    car            = "car@3.1-5",
    carData        = "carData@3.0-6",
    cellranger     = "cellranger@1.1.0",
    CensRCalc      = "IDEN-Project-UAS-Darmstadt/CensRCalc@d7da8743099e86c90404c37f8cc240958d9b0606",
    checkmate      = "checkmate@2.3.4",
    cli            = "cli@3.6.6",
    clipr          = "clipr@0.8.0",
    codetools      = "codetools@0.2-20",
    colorspace     = "colorspace@2.1-2",
    colourpicker   = "colourpicker@1.3.0",
    commonmark     = "commonmark@2.0.0",
    conflicted     = "conflicted@1.2.0",
    corrplot       = "corrplot@0.95",
    cowplot        = "cowplot@1.2.0",
    cpp11          = "cpp11@0.5.5",
    crayon         = "crayon@1.5.3",
    cubature       = "cubature@2.1.4-1",
    curl           = "curl@7.1.0",
    data.table     = "data.table@1.18.2.1",
    DBI            = "DBI@1.3.0",
    dbplyr         = "dbplyr@2.5.2",
    Deriv          = "Deriv@4.2.0",
    digest         = "digest@0.6.39",
    doBy           = "doBy@4.7.1",
    dplyr          = "dplyr@1.2.1",
    dtplyr         = "dtplyr@1.3.3",
    evaluate       = "evaluate@1.0.5",
    farver         = "farver@2.1.2",
    fastmap        = "fastmap@1.2.0",
    fontawesome    = "fontawesome@0.5.3",
    forcats        = "forcats@1.0.1",
    foreach        = "foreach@1.5.2",
    forecast       = "forecast@9.0.2",
    Formula        = "Formula@1.2-5",
    fracdiff       = "fracdiff@1.5-3",
    fs             = "fs@2.1.0",
    gargle         = "gargle@1.6.1",
    generics       = "generics@0.1.4",
    ggExtra        = "ggExtra@0.11.0",
    ggfortify      = "ggfortify@0.4.19",
    ggplot2        = "ggplot2@4.0.3",
    ggpubr         = "ggpubr@0.6.3",
    ggrepel        = "ggrepel@0.9.8",
    ggsci          = "ggsci@5.0.0",
    ggsignif       = "ggsignif@0.6.4",
    glmnet         = "glmnet@4.1-10",
    glue           = "glue@1.8.1",
    googledrive    = "googledrive@2.1.2",
    googlesheets4  = "googlesheets4@1.1.2",
    gridExtra      = "gridExtra@2.3",
    gtable         = "gtable@0.3.6",
    haven          = "haven@2.5.5",
    highr          = "highr@0.12",
    hms            = "hms@1.1.4",
    htmltools      = "htmltools@0.5.9",
    htmlwidgets    = "htmlwidgets@1.6.4",
    httpuv         = "httpuv@1.6.17",
    httr           = "httr@1.4.8",
    ids            = "ids@1.0.1",
    inum           = "inum@1.0-5",
    isoband        = "isoband@0.3.0",
    iterators      = "iterators@1.0.14",
    jquerylib      = "jquerylib@0.1.4",
    jsonlite       = "jsonlite@2.0.0",
    knitr          = "knitr@1.51",
    labeling       = "labeling@0.4.3",
    later          = "later@1.4.8",
    latex2exp      = "latex2exp@0.9.8",
    lattice        = "lattice@0.22-9",
    libcoin        = "libcoin@1.0-12",
    lifecycle      = "lifecycle@1.0.5",
    lme4           = "lme4@2.0-1",
    lmtest         = "lmtest@0.9-40",
    logger         = "logger@0.4.1",
    lubridate      = "lubridate@1.9.5",
    magrittr       = "magrittr@2.0.5",
    MASS           = "MASS@7.3-65",
    mathjaxr       = "mathjaxr@2.0-0",
    Matrix         = "Matrix@1.7-5",
    MatrixModels   = "MatrixModels@0.5-4",
    memoise        = "memoise@2.0.1",
    mgcv           = "mgcv@1.9-4",
    microbenchmark = "microbenchmark@1.5.0",
    mime           = "mime@0.13",
    miniUI         = "miniUI@0.1.2",
    minqa          = "minqa@1.2.8",
    modelr         = "modelr@0.1.11",
    mvtnorm        = "mvtnorm@1.3-7",
    nlme           = "nlme@3.1-169",
    nloptr         = "nloptr@2.2.1",
    nnet           = "nnet@7.3-20",
    numDeriv       = "numDeriv@2016.8-1.1",
    openssl        = "openssl@2.4.0",
    otel           = "otel@0.2.0",
    partykit       = "partykit@1.2-27",
    patchwork      = "patchwork@1.3.2",
    pbapply        = "pbapply@1.7-4",
    pbkrtest       = "pbkrtest@0.5.5",
    pillar         = "pillar@1.11.1",
    pkgconfig      = "pkgconfig@2.0.3",
    polynom        = "polynom@1.4-1",
    prettyunits    = "prettyunits@1.2.0",
    processx       = "processx@3.9.0",
    profvis        = "profvis@0.4.0",
    progress       = "progress@1.2.3",
    progressr      = "progressr@0.19.0",
    promises       = "promises@1.5.0",
    ps             = "ps@1.9.3",
    purrr          = "purrr@1.2.2",
    quantreg       = "quantreg@6.1",
    R6             = "R6@2.6.1",
    ragg           = "ragg@1.5.2",
    rappdirs       = "rappdirs@0.3.4",
    rbibutils      = "rbibutils@2.4.1",
    RColorBrewer   = "RColorBrewer@1.1-3",
    Rcpp           = "Rcpp@1.1.1-1.1",
    RcppArmadillo  = "RcppArmadillo@15.2.6-1",
    RcppEigen      = "RcppEigen@0.3.4.0.2",
    Rdpack         = "Rdpack@2.6.6",
    readr          = "readr@2.2.0",
    readxl         = "readxl@1.4.5",
    reformulas     = "reformulas@0.4.4",
    rematch        = "rematch@2.0.0",
    rematch2       = "rematch2@2.1.2",
    # renv           = "renv@1.1.7",
    reprex         = "reprex@2.1.1",
    rlang          = "rlang@1.2.0",
    rmarkdown      = "rmarkdown@2.31",
    rpart          = "rpart@4.1.27",
    rstatix        = "rstatix@0.7.3",
    rstudioapi     = "rstudioapi@0.18.0",
    rvest          = "rvest@1.0.5",
    S7             = "S7@0.2.2",
    sandwich       = "sandwich@3.1-1",
    sass           = "sass@0.4.10",
    scales         = "scales@1.4.0",
    selectr        = "selectr@0.5-1",
    shape          = "shape@1.4.6.1",
    shiny          = "shiny@1.13.0",
    shinyjs        = "shinyjs@2.1.1",
    sourcetools    = "sourcetools@0.1.7-2",
    SparseM        = "SparseM@1.84-2",
    stringi        = "stringi@1.8.7",
    stringr        = "stringr@1.6.0",
    strucchange    = "strucchange@1.5-4",
    survival       = "survival@3.8-6",
    sys            = "sys@3.4.3",
    systemfonts    = "systemfonts@1.3.2",
    textshaping    = "textshaping@1.0.5",
    tibble         = "tibble@3.3.1",
    tidyr          = "tidyr@1.3.2",
    tidyselect     = "tidyselect@1.2.1",
    tidyverse      = "tidyverse@2.0.0",
    timechange     = "timechange@0.4.0",
    timeDate       = "timeDate@4052.112",
    tinytex        = "tinytex@0.59",
    truncnorm      = "truncnorm@1.0-9",
    tzdb           = "tzdb@0.5.0",
    urca           = "urca@1.3-4",
    utf8           = "utf8@1.2.6",
    uuid           = "uuid@1.2-2",
    vctrs          = "vctrs@0.7.3",
    viridisLite    = "viridisLite@0.4.3",
    vroom          = "vroom@1.7.1",
    withr          = "withr@3.0.2",
    xfun           = "xfun@0.57",
    xml2           = "xml2@1.5.2",
    xtable         = "xtable@1.8-8",
    yaml           = "yaml@2.3.12",
    zoo            = "zoo@1.8-15"
  )
}

args <- commandArgs(trailingOnly = TRUE)

# No arguments: run the default function
if (length(args) == 0) {
  main()
  quit(status = 0)
}

# Validate required arguments
if (length(args) < 2) {
  cat("Error: METHOD and MODEL must be provided.\n")
  cat("Usage: Rscript run_simulation_study.R METHOD MODEL TRUE_MODEL ABC_MODEL [SUFFIX]\n")
  quit(status = 1)
}

method <- args[1]
model <- args[2]
true_model <- if (length(args) >= 3) args[3] else NULL
abc_model <- if (length(args) >= 4) args[4] else NULL
suffix <- if (length(args) >= 5) paste0("_", args[5]) else ""

# Run relative to the script's directory
script_path <- normalizePath(sub("^--file=", "", commandArgs()[grep("^--file=", commandArgs())]))
script_dir <- dirname(script_path)
setwd(script_dir)

outdir <- file.path(
  "results",
  sprintf(
    "%s_results_survival_%s_%s_%s_%s%s",
    format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
    method,
    model,
    true_model,
    abc_model,
    suffix
  )
)

cat("Writing results to", outdir, "\n")
dir.create(outdir, recursive = TRUE)

output_file <- sprintf(
  "document_%s_%s_%s_%s%s",
  method, model, true_model, abc_model, suffix
)

log_file <- file.path(
  outdir,
  sprintf(
    "run_%s_%s_%s_%s%s.log",
    method, model, true_model, abc_model, suffix
  )
)

# Capture output from the rendering process in a log file
sink(log_file, split = TRUE)
on.exit(sink(), add = TRUE)

main()

rmarkdown::render(
  "simulation_study.Rmd",
  output_file = output_file,
  output_dir = outdir,
  params = list(
    method = method,
    model = model,
    true_model = true_model,
    abc_model = abc_model,
    outdir = outdir
  )
)