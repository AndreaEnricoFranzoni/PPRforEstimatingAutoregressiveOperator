// Copyright (c) 2024 Andrea Enrico Franzoni (andreaenrico.franzoni@gmail.com)
//
// This file is part of PPCKO
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of PPCKO and associated documentation files (the PPCKO software), to deal
// PPCKO without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of PPCKO, and to permit persons to whom PPCKO is
// furnished to do so, subject to the following conditions:
//
// PPCKO IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH PPCKO OR THE USE OR OTHER DEALINGS IN
// PPCKO.

#ifndef KO_REMOVE_NAN_HPP
#define KO_REMOVE_NAN_HPP

#include <Eigen/Dense>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <numeric>
#include <functional>
#include <vector>
#include <set>
#include <type_traits>
#include <string>
#include <stdexcept>

#include "parameters_wrapper.hpp"
#include "traits_ko.hpp"



/*!
* @file removing_nan.hpp
* @brief Contains the class to remove (dummy and not dummy) NaNs
* @author Andrea Enrico Franzoni
*/



/*!
* Doing tag dispatching for the correct way of removing non-dummy NaNs.
* @tparam MA_t: template parameter for the non-dummy NaNs removal type to be mapped by std::integral_constant
*/
template <REM_NAN MA_t>
using MAT = std::integral_constant<REM_NAN, MA_t>;


/*!
* @class removing_nan
* @brief Template class for removing NaNs from an Eigen::Matrix.
* @tparam T is the type stored
* @tparam MA_t is the way of removing non-dummy NaNs: 'MR': replacing with the average of the row. 'ZR': replacing with 0s
*/
template<typename T,REM_NAN MA_t>
class removing_nan
{
  
private:
  /*!Matrix containing data from which NaNs have to be removed*/
  KO_Traits::StoringMatrix m_data;
  /*!Number of rows of the matrix*/
  std::size_t m_m;
  /*!Number of columns of the matrix*/
  std::size_t m_n;

  /*!
  * @brief Substituting non-dummy NaNs with row mean.
  */
  void row_removal(Eigen::Block<Eigen::Matrix<T,-1,-1>,1>& row, MAT<REM_NAN::MR>);
  /*!
  * @brief Substituting non-dummy NaNs with 0s.
  */
  void row_removal(Eigen::Block<Eigen::Matrix<T,-1,-1>,1>& row, MAT<REM_NAN::ZR>);
  
public:
  
  /*!
  * @brief Constructor taking the matrix from which NaNs have to be removed
  * @param data matrix from which removing NaNs
  * @details Universal constructor: move semantic used to optimazing handling big size objects
  */
  template<typename STOR_OBJ>
  removing_nan(STOR_OBJ&& data)
    :
    m_data{std::forward<STOR_OBJ>(data)}
    { 
      m_m = m_data.rows();
      m_n = m_data.cols();
    }
  
  /*!
  * @brief Getter for the data matrix
  * @return the private m_data
  */
  inline KO_Traits::StoringMatrix data() const {return m_data;};
  
  /*!
  * @brief Substituting non-dummy NaNs. Tag-dispacther.
  * @param row row from which removing non-dummy NaNs
  * @return tag dispatching to the correct function to substitute non-dummy NaNs
  */
  void row_removal(Eigen::Block<Eigen::Matrix<T,-1,-1>,1>& row) { return row_removal(row, MAT<MA_t>{});};
  
  /*!
  * @brief Function to remove the row (dummy NaNs)
  */
  inline void remove_nan(){   for(auto row : m_data.rowwise()){   row_removal(row);} };
};


#include "removing_nan_imp.hpp"
#include "removing_nan_cleaner_imp.hpp"

#endif /*KO_REMOVE_NAN_HPP*/