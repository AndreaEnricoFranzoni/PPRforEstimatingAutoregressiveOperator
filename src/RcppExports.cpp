// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppEigen.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// PPC_KO
Rcpp::List PPC_KO(Rcpp::NumericMatrix X, std::string id_CV, double alpha, int k, double threshold_ppc, Rcpp::Nullable<NumericVector> alpha_vec, Rcpp::Nullable<IntegerVector> k_vec, double toll, Rcpp::Nullable<NumericVector> disc_ev, double left_extreme, double right_extreme, Rcpp::Nullable<int> min_size_ts, Rcpp::Nullable<int> max_size_ts, bool err_ret, bool ex_solver, Rcpp::Nullable<int> num_threads, Rcpp::Nullable<std::string> id_rem_nan);
RcppExport SEXP _PPCKO_PPC_KO(SEXP XSEXP, SEXP id_CVSEXP, SEXP alphaSEXP, SEXP kSEXP, SEXP threshold_ppcSEXP, SEXP alpha_vecSEXP, SEXP k_vecSEXP, SEXP tollSEXP, SEXP disc_evSEXP, SEXP left_extremeSEXP, SEXP right_extremeSEXP, SEXP min_size_tsSEXP, SEXP max_size_tsSEXP, SEXP err_retSEXP, SEXP ex_solverSEXP, SEXP num_threadsSEXP, SEXP id_rem_nanSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type X(XSEXP);
    Rcpp::traits::input_parameter< std::string >::type id_CV(id_CVSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< int >::type k(kSEXP);
    Rcpp::traits::input_parameter< double >::type threshold_ppc(threshold_ppcSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type alpha_vec(alpha_vecSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<IntegerVector> >::type k_vec(k_vecSEXP);
    Rcpp::traits::input_parameter< double >::type toll(tollSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type disc_ev(disc_evSEXP);
    Rcpp::traits::input_parameter< double >::type left_extreme(left_extremeSEXP);
    Rcpp::traits::input_parameter< double >::type right_extreme(right_extremeSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type min_size_ts(min_size_tsSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type max_size_ts(max_size_tsSEXP);
    Rcpp::traits::input_parameter< bool >::type err_ret(err_retSEXP);
    Rcpp::traits::input_parameter< bool >::type ex_solver(ex_solverSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type num_threads(num_threadsSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<std::string> >::type id_rem_nan(id_rem_nanSEXP);
    rcpp_result_gen = Rcpp::wrap(PPC_KO(X, id_CV, alpha, k, threshold_ppc, alpha_vec, k_vec, toll, disc_ev, left_extreme, right_extreme, min_size_ts, max_size_ts, err_ret, ex_solver, num_threads, id_rem_nan));
    return rcpp_result_gen;
END_RCPP
}
// PPC_KO_2d
Rcpp::List PPC_KO_2d(Rcpp::NumericMatrix X, std::string id_CV, double alpha, int k, double threshold_ppc, Rcpp::Nullable<NumericVector> alpha_vec, Rcpp::Nullable<IntegerVector> k_vec, double toll, Rcpp::Nullable<NumericVector> disc_ev_x1, int num_disc_ev_x1, Rcpp::Nullable<NumericVector> disc_ev_x2, int num_disc_ev_x2, double left_extreme_x1, double right_extreme_x1, double left_extreme_x2, double right_extreme_x2, Rcpp::Nullable<int> min_size_ts, Rcpp::Nullable<int> max_size_ts, bool err_ret, bool ex_solver, Rcpp::Nullable<int> num_threads, Rcpp::Nullable<std::string> id_rem_nan);
RcppExport SEXP _PPCKO_PPC_KO_2d(SEXP XSEXP, SEXP id_CVSEXP, SEXP alphaSEXP, SEXP kSEXP, SEXP threshold_ppcSEXP, SEXP alpha_vecSEXP, SEXP k_vecSEXP, SEXP tollSEXP, SEXP disc_ev_x1SEXP, SEXP num_disc_ev_x1SEXP, SEXP disc_ev_x2SEXP, SEXP num_disc_ev_x2SEXP, SEXP left_extreme_x1SEXP, SEXP right_extreme_x1SEXP, SEXP left_extreme_x2SEXP, SEXP right_extreme_x2SEXP, SEXP min_size_tsSEXP, SEXP max_size_tsSEXP, SEXP err_retSEXP, SEXP ex_solverSEXP, SEXP num_threadsSEXP, SEXP id_rem_nanSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type X(XSEXP);
    Rcpp::traits::input_parameter< std::string >::type id_CV(id_CVSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< int >::type k(kSEXP);
    Rcpp::traits::input_parameter< double >::type threshold_ppc(threshold_ppcSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type alpha_vec(alpha_vecSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<IntegerVector> >::type k_vec(k_vecSEXP);
    Rcpp::traits::input_parameter< double >::type toll(tollSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type disc_ev_x1(disc_ev_x1SEXP);
    Rcpp::traits::input_parameter< int >::type num_disc_ev_x1(num_disc_ev_x1SEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type disc_ev_x2(disc_ev_x2SEXP);
    Rcpp::traits::input_parameter< int >::type num_disc_ev_x2(num_disc_ev_x2SEXP);
    Rcpp::traits::input_parameter< double >::type left_extreme_x1(left_extreme_x1SEXP);
    Rcpp::traits::input_parameter< double >::type right_extreme_x1(right_extreme_x1SEXP);
    Rcpp::traits::input_parameter< double >::type left_extreme_x2(left_extreme_x2SEXP);
    Rcpp::traits::input_parameter< double >::type right_extreme_x2(right_extreme_x2SEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type min_size_ts(min_size_tsSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type max_size_ts(max_size_tsSEXP);
    Rcpp::traits::input_parameter< bool >::type err_ret(err_retSEXP);
    Rcpp::traits::input_parameter< bool >::type ex_solver(ex_solverSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type num_threads(num_threadsSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<std::string> >::type id_rem_nan(id_rem_nanSEXP);
    rcpp_result_gen = Rcpp::wrap(PPC_KO_2d(X, id_CV, alpha, k, threshold_ppc, alpha_vec, k_vec, toll, disc_ev_x1, num_disc_ev_x1, disc_ev_x2, num_disc_ev_x2, left_extreme_x1, right_extreme_x1, left_extreme_x2, right_extreme_x2, min_size_ts, max_size_ts, err_ret, ex_solver, num_threads, id_rem_nan));
    return rcpp_result_gen;
END_RCPP
}
// KO_check_hps
Rcpp::List KO_check_hps(Rcpp::NumericMatrix X);
RcppExport SEXP _PPCKO_KO_check_hps(SEXP XSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type X(XSEXP);
    rcpp_result_gen = Rcpp::wrap(KO_check_hps(X));
    return rcpp_result_gen;
END_RCPP
}
// KO_check_hps_2d
Rcpp::List KO_check_hps_2d(Rcpp::NumericMatrix X, int dim_x1, int dim_x2);
RcppExport SEXP _PPCKO_KO_check_hps_2d(SEXP XSEXP, SEXP dim_x1SEXP, SEXP dim_x2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type X(XSEXP);
    Rcpp::traits::input_parameter< int >::type dim_x1(dim_x1SEXP);
    Rcpp::traits::input_parameter< int >::type dim_x2(dim_x2SEXP);
    rcpp_result_gen = Rcpp::wrap(KO_check_hps_2d(X, dim_x1, dim_x2));
    return rcpp_result_gen;
END_RCPP
}
// data_2d_wrapper_from_list
Rcpp::NumericMatrix data_2d_wrapper_from_list(Rcpp::List Xt);
RcppExport SEXP _PPCKO_data_2d_wrapper_from_list(SEXP XtSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::List >::type Xt(XtSEXP);
    rcpp_result_gen = Rcpp::wrap(data_2d_wrapper_from_list(Xt));
    return rcpp_result_gen;
END_RCPP
}
// data_2d_wrapper_from_array
Rcpp::NumericMatrix data_2d_wrapper_from_array(Rcpp::NumericVector Xt);
RcppExport SEXP _PPCKO_data_2d_wrapper_from_array(SEXP XtSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type Xt(XtSEXP);
    rcpp_result_gen = Rcpp::wrap(data_2d_wrapper_from_array(Xt));
    return rcpp_result_gen;
END_RCPP
}
// PPC_KO_gen_solv
Rcpp::List PPC_KO_gen_solv(Rcpp::NumericMatrix X, std::string id_CV, double alpha, int k, double threshold_ppc, Rcpp::Nullable<NumericVector> alpha_vec, Rcpp::Nullable<IntegerVector> k_vec, double toll, Rcpp::Nullable<NumericVector> disc_ev, double left_extreme, double right_extreme, Rcpp::Nullable<int> min_size_ts, Rcpp::Nullable<int> max_size_ts, int err_ret, Rcpp::Nullable<int> num_threads, Rcpp::Nullable<std::string> id_rem_nan);
RcppExport SEXP _PPCKO_PPC_KO_gen_solv(SEXP XSEXP, SEXP id_CVSEXP, SEXP alphaSEXP, SEXP kSEXP, SEXP threshold_ppcSEXP, SEXP alpha_vecSEXP, SEXP k_vecSEXP, SEXP tollSEXP, SEXP disc_evSEXP, SEXP left_extremeSEXP, SEXP right_extremeSEXP, SEXP min_size_tsSEXP, SEXP max_size_tsSEXP, SEXP err_retSEXP, SEXP num_threadsSEXP, SEXP id_rem_nanSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type X(XSEXP);
    Rcpp::traits::input_parameter< std::string >::type id_CV(id_CVSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< int >::type k(kSEXP);
    Rcpp::traits::input_parameter< double >::type threshold_ppc(threshold_ppcSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type alpha_vec(alpha_vecSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<IntegerVector> >::type k_vec(k_vecSEXP);
    Rcpp::traits::input_parameter< double >::type toll(tollSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<NumericVector> >::type disc_ev(disc_evSEXP);
    Rcpp::traits::input_parameter< double >::type left_extreme(left_extremeSEXP);
    Rcpp::traits::input_parameter< double >::type right_extreme(right_extremeSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type min_size_ts(min_size_tsSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type max_size_ts(max_size_tsSEXP);
    Rcpp::traits::input_parameter< int >::type err_ret(err_retSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<int> >::type num_threads(num_threadsSEXP);
    Rcpp::traits::input_parameter< Rcpp::Nullable<std::string> >::type id_rem_nan(id_rem_nanSEXP);
    rcpp_result_gen = Rcpp::wrap(PPC_KO_gen_solv(X, id_CV, alpha, k, threshold_ppc, alpha_vec, k_vec, toll, disc_ev, left_extreme, right_extreme, min_size_ts, max_size_ts, err_ret, num_threads, id_rem_nan));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_PPCKO_PPC_KO", (DL_FUNC) &_PPCKO_PPC_KO, 17},
    {"_PPCKO_PPC_KO_2d", (DL_FUNC) &_PPCKO_PPC_KO_2d, 22},
    {"_PPCKO_KO_check_hps", (DL_FUNC) &_PPCKO_KO_check_hps, 1},
    {"_PPCKO_KO_check_hps_2d", (DL_FUNC) &_PPCKO_KO_check_hps_2d, 3},
    {"_PPCKO_data_2d_wrapper_from_list", (DL_FUNC) &_PPCKO_data_2d_wrapper_from_list, 1},
    {"_PPCKO_data_2d_wrapper_from_array", (DL_FUNC) &_PPCKO_data_2d_wrapper_from_array, 1},
    {"_PPCKO_PPC_KO_gen_solv", (DL_FUNC) &_PPCKO_PPC_KO_gen_solv, 16},
    {NULL, NULL, 0}
};

RcppExport void R_init_PPCKO(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
