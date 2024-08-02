#ifndef KO_FACTORY_HPP
#define KO_FACTORY_HPP

#include <string>
#include <memory>
#include <stdexcept>
#include "PPC_KO.hpp"


template<typename T, typename... Args>
std::unique_ptr<T> make_unique(Args&&... args)
{
  return std::unique_ptr<T>(new T(std::forward<Args>(args)...));
}



//! A Factory class: A class for the choice of the cross-validation method to use for the regularization parameter alpha
class KO_Factory
{	
public:
  //! Static method that takes a string as identifier and builds a pointer to the right object for the cross-validation requested
  static 
  std::unique_ptr<PPC::PPC_KO_base> 
  KO_solver(const std::string &id, KO_Traits::StoringMatrix && X, double alpha)
  {
    if (id == "NoCV")
    {
      return make_unique<PPC::KO_NO_CV>(std::move(X), alpha);
    }
    if (id == "CV")
    {
      return make_unique<PPC::KO_CV>(std::move(X), alpha);
    }
    else
    {
      std::string error_message = "Wrong input string";
      throw std::invalid_argument(error_message);
    }
  }
};


#endif /* KO_FACTORY_HPP */


