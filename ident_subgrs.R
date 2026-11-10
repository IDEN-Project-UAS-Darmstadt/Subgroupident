ident_subgr_lasso <- function(df, d_ite, penalty_param = NA) {
    formula <- as.formula("Surv(time, cens) ~ .^2")
    # formula <- as.formula("Surv(time, cens) ~ .-trt") #.^2 # trt + X1 + X2 + X3:trt:I(X3>0.5)  #- X1:X2 - X1:X3 - X2:X3 # remove interaction terms that are not in the data
    id <- df$id
    df <- df %>% select(-id)
    mat <- model.matrix(data = df, object = formula)

    set.seed(764872)
    if (is.na(penalty_param)) {
        fit <- cv.glmnet(mat, Surv(df$time, df$cens), family = "cox", alpha = 1)
        penalty_param <- fit$lambda.min # lambda.min or lambda.1se?
    } else {
        # stop("I AM DEAD!")
        ####### catch warning from glmnet (lambda value) #######
        fit <- glmnet(mat, Surv(df$time, df$cens), family = "cox", alpha = 1, lambda = penalty_param)
        # stop("new_ass^9")
    #     if ((length(fit$jerr) != 0) && (fit$jerr != 0)) {
    #       print(str_glue("jerr: {fit$jerr}"))
    #       print(fit)
    #       print(coef(fit))
    #       stop("assinmouth")
    #     }
    }

    coefs <- coef(fit, s = penalty_param)
    coef_names <- dimnames(coefs)[[1]]
    index <- which(coefs != 0)
    nonzero_coefs <- coef_names[index]

    # Check if a true predictive biomarker is selected
    pred_correct <- ifelse(("X3:trt" %in% nonzero_coefs) || ("trt:X3" %in% nonzero_coefs), 1, 0)

    # Estimated ITE
    data_1 <- df
    data_1$trt <- 1
    newx_1 <- model.matrix(data = data_1, object = formula)
    data_0 <- df
    data_0$trt <- 0
    newx_0 <- model.matrix(data = data_0, object = formula)


    pred_0 <- predict(fit, s = penalty_param, newx = newx_0, type = "response") # "link": linear predictor, "response": hazard (not HR!)
    pred_1 <- predict(fit, s = penalty_param, newx = newx_1, type = "response") # response = exp(link)


    ite <- pred_1 / pred_0 # ==  exp((coefs[2] + coefs[4]*df$X)) in this particular model

    df$ite <- ite

    # Define observed subgroup
    # d_ite <- 0.4 # determined through simulation with n = 1000 ("historical data")
    df$id <- id
    subgr <- df[df$ite <= d_ite, ]

    return(list(subgr = subgr, penalty_param = penalty_param, pred_correct = pred_correct, nonzero_coefs = nonzero_coefs, coefs = coefs))
}


ident_subgr_cox <- function(df, d_ite) {
  formula <- as.formula("Surv(time, cens) ~ trt + X1 + X2 + X3:trt:I(X3>0.5)") # - X1:X2 - X1:X3 - X2:X3
  id <- df$id
  df <- df %>% select(-id)

  set.seed(764872)
  fit <- coxph(data=df, formula=formula)

  coefs <- coef(fit)
  coef_names <- dimnames(coefs)[[1]]
  index <- which(coef(summary(fit))[, "Pr(>|z|)"] < 0.05)
  significant_coefs <- names(index)

  # Check if a true predictive biomarker is selected
  pred_correct <- ifelse(("X3:trt" %in% significant_coefs) || ("trt:X3" %in% significant_coefs), 1, 0)

  # Estimated ITE
  data_1 <- df
  data_1$trt <- 1
  newx_1 <- model.matrix(data = data_1, object = formula)
  data_0 <- df
  data_0$trt <- 0
  newx_0 <- model.matrix(data = data_0, object = formula)


  pred_0 <- predict(fit, newdata = data_0, type = "risk") # risk = exp(linear predictor)
  pred_1 <- predict(fit, newdata = data_1, type = "risk")


  ite <- pred_1 / pred_0 # ==  exp((coefs[2] + coefs[4]*df$X)) in this particular model

  df$ite <- ite

  # Define observed subgroup
  # d_ite <- 0.4 # determined through simulation with n = 1000 ("historical data")
  df$id <- id
  subgr <- df[df$ite <= d_ite, ]

  return(list(subgr = subgr, pred_correct = pred_correct, significant_coefs = significant_coefs, coefs = coefs))
}


reg_formula <- function(df, reg_coefs = colnames(df), resp = "Surv(time, cens)", coefs_del = NULL, intercept = TRUE) {
  split_coefs <- names(df)[-which(names(df) %in% c(coefs_del, "time", "cens"))]
  formula <- as.formula(str_glue(
    "{resp}~{1*intercept}+",
    paste0(reg_coefs, collapse = "+"),
    "|",
    paste0(split_coefs, collapse = "+")
  ))
  return(formula)
}


ident_subgr_mob <- function(df, penalty_param = NA) {
    formula <- as.formula("Surv(time, cens) ~ .-trt") #.^2 #.-trt
    mat <- model.matrix(data = df %>% select(-id), object = formula)

    set.seed(764872)
    if (is.na(penalty_param)) {
        fit <- cv.glmnet(mat, Surv(df$time, df$cens), family = "cox", alpha = 1)
        penalty_param <- fit$lambda.min # lambda.min or lambda.1se?
    } else {
        fit <- glmnet(mat, Surv(df$time, df$cens), family = "cox", alpha = 1, lambda = penalty_param)
    }
    coefs <- coef(fit, s = fit$lambda.min)
    coef_names <- dimnames(coefs)[[1]]
    index <- which(coefs != 0)
    nonzero_coefs <- coef_names[index]

    # Check if a true predictive biomarker is selected
    pred_correct <- ifelse(("X3:trt" %in% nonzero_coefs) || ("trt:X3" %in% nonzero_coefs), 1, 0)

    # Define regression formula for MOB
    reg_coefs <- colnames(df)
    reg_coefs <- reg_coefs[reg_coefs %in% setdiff(nonzero_coefs, "trt")]
    reg_coefs <- c("trt", reg_coefs) # making sure trt is first variable in formula

    reg_form <- reg_formula(df %>% select(-id), reg_coefs, coefs_del = c("Surv(time, cens)", "trt"), intercept = FALSE)

    ## MOB
    mycox <- function(y, x, start = NULL, weights = NULL, offset = NULL, ...) {
      x <- as.data.frame(x)
      data <- as.data.frame(cbind(y, x))

      fit <- coxph(formula = y ~ ., data = data, weights = weights, ...) #, control = coxph.control(eps = 1e-5, toler.inf = 1e-1))

      # Sanity check (estfun is used within mob and does not return a df, if there is only "trt", numeric vector is returned)
      sandwichres <- sandwich::estfun(fit)
      if(!is.null(colnames(sandwichres))){
        stopifnot("trt" == colnames(sandwichres)[1])
      }

      return(fit)
    }

    ######### catch how many iterations throw the coxph.wtest error #########
    # Define subgroup obs (here: parm = 1 <=> parm = "trt")
    mob_tree <- mob(data = df, formula = reg_form, fit = mycox, control = mob_control(parm = 1, minsize = 20, alpha = 0.05, verbose = FALSE))#, minsize = 20, alpha = 0.05))

    # Define CATE obs
    terminal_nodes <- nodeids(mob_tree, terminal = TRUE)

    pred <- predict(mob_tree, newdata = df)

    subgr_list <- lapply(terminal_nodes, function(node) list(df[pred == node, ], node))
    coefs_list <- lapply(terminal_nodes, function(node) {
        node_model <- mob_tree[node] # partykit::fitted_node(mob_tree, id = node)
        coefs <- coef(node_model)
        return(list(coefs, node))
    })

    return(list(subgr_list = subgr_list, coefs_list = coefs_list, pred = pred, terminal_nodes = terminal_nodes, penalty_param = penalty_param, pred_correct = pred_correct, nonzero_coefs = nonzero_coefs))
}


# ident_subgr_mob_old <- function(df, penalty_param = NA) {
#     formula <- as.formula("Surv(time, cens) ~ .^2")
#     mat <- model.matrix(data = df %>% select(-id), object = formula)

#     set.seed(764872)
#     if (is.na(penalty_param)) {
#         fit <- cv.glmnet(mat, Surv(df$time, df$cens), family = "cox", alpha = 1)
#         penalty_param <- fit$lambda.min # lambda.min or lambda.1se?
#     } else {
#         fit <- glmnet(mat, Surv(df$time, df$cens), family = "cox", alpha = 1, lambda = penalty_param)
#     }
#     coefs <- coef(fit, s = fit$lambda.min)
#     coef_names <- dimnames(coefs)[[1]]
#     index <- which(coefs != 0)
#     nonzero_coefs <- coef_names[index]
    
#     # Check if a true predictive biomarker is selected
#     pred_correct <- ifelse(("X3:trt" %in% nonzero_coefs) || ("trt:X3" %in% nonzero_coefs), 1, 0)

#     # Define regression formula for MOB
#     reg_coefs <- colnames(df)
#     reg_coefs <- reg_coefs[reg_coefs %in% setdiff(nonzero_coefs, "trt")]
#     reg_coefs <- c("trt", reg_coefs) # making sure trt is first variable in formula

#     reg_form <- reg_formula(df %>% select(-id), reg_coefs, coefs_del = c("Surv(time, cens)", "trt"), intercept = FALSE)

#     ## MOB
#     mycox <- function(y, x, start = NULL, weights = NULL, offset = NULL, ...) {
#       x <- as.data.frame(x)
#       data <- as.data.frame(cbind(y, x))

#       fit <- coxph(formula = y ~ ., data = data, weights = weights, ...) #, control = coxph.control(eps = 1e-5, toler.inf = 1e-1))

#       # Sanity check (estfun is used within mob and does not return a df, if there is only "trt", numeric vector is returned)
#       sandwichres <- sandwich::estfun(fit)
#       if(!is.null(colnames(sandwichres))){
#         stopifnot("trt" == colnames(sandwichres)[1])
#       }

#       return(fit)
#     }
#     ######### catch how many iterations throw the coxph.wtest error #########
#     # Define subgroup obs (here: parm = 1 <=> parm = "trt")
#     mob_tree <- mob(data = df, formula = reg_form, fit = mycox, control = mob_control(parm = 1, minsize = 20, alpha = 0.05, verbose = FALSE))#, minsize = 20, alpha = 0.05))

#     # Define CATE obs
#     terminal_nodes <- nodeids(mob_tree, terminal = TRUE)

#     pred <- predict(mob_tree, newdata = df)

#     get_coef <- function(tree_node) {
#       res <- coef(tree_node)
#       if ("trt" %in% names(res)) {
#         return(res["trt"])
#       } else if (length(res) == 1) {
#         return(res)
#       } else {
#         return(NA)
#       }
#     }

#     # Choose subgroup with highest trt effect (!= CATE in LASSO)
#     df_subgrs <- data.frame(node = terminal_nodes, CATE = sapply(terminal_nodes, function(node) exp(get_coef(mob_tree[node]))))
#     node_subgr <- df_subgrs[which.min(df_subgrs$CATE), "node"]
#     cate <- df_subgrs[which.min(df_subgrs$CATE), "CATE"]
#     pred <- predict(mob_tree, newdata = df)
#     subgr <- df[pred == node_subgr,]
#     subgr_node <- mob_tree[[node_subgr]]
#     subgr_pred <- pred[pred == node_subgr]

#     return(list(subgr = subgr, subgr_node = subgr_node, cate = cate, df_subgrs = df_subgrs, pred = pred, terminal_nodes = terminal_nodes, penalty_param = penalty_param, pred_correct = pred_correct, nonzero_coefs = nonzero_coefs))
# }

# res <- tryCatch(expr = {print(z)}, error = function(e) {message("An error occurred: ", e$message)})
# class(res)