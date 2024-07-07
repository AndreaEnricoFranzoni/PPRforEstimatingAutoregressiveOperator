#include <RcppEigen.h>
#include "reading_data.hpp"
#include "PPC_KO.hpp"
#include "KO_factory.hpp"

using namespace Rcpp;


//
// [[Rcpp::depends(RcppEigen)]]

//
// [[Rcpp::export]]
Rcpp::List PPC_KO(Rcpp::NumericMatrix X,
                  std::string id_CV,
                  double threshold_k,
                  double alpha,
                  int n_disc
                  )
{ 
  
  KO_Traits::StoringMatrix x = reading_data(X);

  
  //!!using std::move() to move the data (better if there are big data)!!
  std::unique_ptr<PPC::PPC_KO_base> ko = KO_Factory::KO_solver(id_CV,std::move(x));

  ko->solve();
  
  Rcpp::List l;
  
  //estimate of the predictions
  auto pred = ko->prediction();
  l["predictions"] = pred;
  
  //Rcout << "Attempt 42" << std::endl;
  
  return l;
}