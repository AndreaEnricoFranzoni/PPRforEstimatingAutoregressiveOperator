/**
 * @file nsga2.hpp
 * @author Sayan Goswami
 * @author Nanubala Gnana Sai
 *
 * NSGA-II is a multi-objective optimization algorithm, widely used in
 * many real-world applications. NSGA-II generates offsprings using
 * crossover and mutation and then selects the next generation according
 * to non-dominated-sorting and crowding distance comparison.
 *
 * ensmallen is free software; you may redistribute it and/or modify it under
 * the terms of the 3-clause BSD license.  You should have received a copy of
 * the 3-clause BSD license along with ensmallen.  If not, see
 * http://www.opensource.org/licenses/BSD-3-Clause for more information.
 */

#ifndef ENSMALLEN_NSGA2_NSGA2_HPP
#define ENSMALLEN_NSGA2_NSGA2_HPP

namespace ens {

/**
 * NSGA-II (Non-dominated Sorting Genetic Algorithm - II) is a multi-objective
 * optimization algorithm. This class implements the NSGA-II algorithm.
 *
 * The algorithm works by generating a candidate population from a fixed
 * starting point. At each stage of optimization, a new population of children
 * is generated. This new population along with its predecessor is sorted using
 * non-domination as the metric. Following this, the population is further
 * segregated in fronts. A new population is generated from these fronts having
 * size equal to that of the starting population.
 *
 * During evolution, two parents are randomly chosen using binary tournament
 * selection. A pair of children are generated by crossing over these two
 * candidates followed by mutation.
 *
 * The best front (Pareto optimal) is returned by the Optimize() method.
 *
 * For more information, see the following:
 *
 * @code
 * @article{10.1109/4235.996017,
 *   author = {Deb, K. and Pratap, A. and Agarwal, S. and Meyarivan, T.},
 *   title = {A Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II},
 *   year = {2002},
 *   url = {https://doi.org/10.1109/4235.996017},
 *   journal = {Trans. Evol. Comp}}
 * @endcode
 *
 * NSGA-II can optimize arbitrary multi-objective functions. For more details,
 * see the documentation on function types included with this distribution or
 * on the ensmallen website.
 */
class NSGA2
{
 public:
  /**
   * Constructor for the NSGA2 optimizer.
   *
   * The default values provided over here are not necessarily suitable for a
   * given function. Therefore it is highly recommended to adjust the
   * parameters according to the problem.
   *
   * @param populationSize The number of candidates in the population.
   *     This should be atleast 4 in size and a multiple of 4.
   * @param maxGenerations The maximum number of generations allowed for NSGA-II.
   * @param crossoverProb The probability that a crossover will occur.
   * @param mutationProb The probability that a mutation will occur.
   * @param mutationStrength The strength of the mutation.
   * @param epsilon The minimum difference required to distinguish between
   *     candidate solutions.
   * @param lowerBound Lower bound of the coordinates of the initial population.
   * @param upperBound Upper bound of the coordinates of the initial population.
   */
  NSGA2(const size_t populationSize = 100,
        const size_t maxGenerations = 2000,
        const double crossoverProb = 0.6,
        const double mutationProb = 0.3,
        const double mutationStrength = 1e-3,
        const double epsilon = 1e-6,
        const arma::vec& lowerBound = arma::zeros(1, 1),
        const arma::vec& upperBound = arma::ones(1, 1));

  /**
   * Constructor for the NSGA2 optimizer. This constructor provides an overload
   * to use `lowerBound` and `upperBound` of type double.
   *
   * The default values provided over here are not necessarily suitable for a
   * given function. Therefore it is highly recommended to adjust the
   * parameters according to the problem.
   *
   * @param populationSize The number of candidates in the population.
   *     This should be atleast 4 in size and a multiple of 4.
   * @param maxGenerations The maximum number of generations allowed for NSGA-II.
   * @param crossoverProb The probability that a crossover will occur.
   * @param mutationProb The probability that a mutation will occur.
   * @param mutationStrength The strength of the mutation.
   * @param epsilon The minimum difference required to distinguish between
   *     candidate solutions.
   * @param lowerBound Lower bound of the coordinates of the initial population.
   * @param upperBound Upper bound of the coordinates of the initial population.
   */
  NSGA2(const size_t populationSize = 100,
        const size_t maxGenerations = 2000,
        const double crossoverProb = 0.6,
        const double mutationProb = 0.3,
        const double mutationStrength = 1e-3,
        const double epsilon = 1e-6,
        const double lowerBound = 0,
        const double upperBound = 1);

  /**
   * Optimize a set of objectives. The initial population is generated using the
   * starting point. The output is the best generated front.
   *
   * @tparam ArbitraryFunctionType std::tuple of multiple objectives.
   * @tparam MatType Type of matrix to optimize.
   * @tparam CallbackTypes Types of callback functions.
   * @param objectives Vector of objective functions to optimize for.
   * @param iterate Starting point.
   * @param callbacks Callback functions.
   * @return MatType::elem_type The minimum of the accumulated sum over the
   *     objective values in the best front.
   */
  template<typename MatType,
           typename... ArbitraryFunctionType,
           typename... CallbackTypes>
 typename MatType::elem_type Optimize(
     std::tuple<ArbitraryFunctionType...>& objectives,
     MatType& iterate,
     CallbackTypes&&... callbacks);

  //! Get the population size.
  size_t PopulationSize() const { return populationSize; }
  //! Modify the population size.
  size_t& PopulationSize() { return populationSize; }

  //! Get the maximum number of generations.
  size_t MaxGenerations() const { return maxGenerations; }
  //! Modify the maximum number of generations.
  size_t& MaxGenerations() { return maxGenerations; }

  //! Get the crossover rate.
  double CrossoverRate() const { return crossoverProb; }
  //! Modify the crossover rate.
  double& CrossoverRate() { return crossoverProb; }

  //! Get the mutation probability.
  double MutationProbability() const { return mutationProb; }
  //! Modify the mutation probability.
  double& MutationProbability() { return mutationProb; }

  //! Get the mutation strength.
  double MutationStrength() const { return mutationStrength; }
  //! Modify the mutation strength.
  double& MutationStrength() { return mutationStrength; }

  //! Get the tolerance.
  double Epsilon() const { return epsilon; }
  //! Modify the tolerance.
  double& Epsilon() { return epsilon; }

  //! Retrieve value of lowerBound.
  const arma::vec& LowerBound() const { return lowerBound; }
  //! Modify value of lowerBound.
  arma::vec& LowerBound() { return lowerBound; }

  //! Retrieve value of upperBound.
  const arma::vec& UpperBound() const { return upperBound; }
  //! Modify value of upperBound.
  arma::vec& UpperBound() { return upperBound; }

  //! Retrieve the Pareto optimal points in variable space. This returns an empty cube
  //! until `Optimize()` has been called.
  const arma::cube& ParetoSet() const { return paretoSet; }

  //! Retrieve the best front (the Pareto frontier). This returns an empty cube until
  //! `Optimize()` has been called.
  const arma::cube& ParetoFront() const { return paretoFront; }

  /**
   * Retrieve the best front (the Pareto frontier).  This returns an empty
   * vector until `Optimize()` has been called.  Note that this function is
   * deprecated and will be removed in ensmallen 3.x!  Use `ParetoFront()`
   * instead.
   */
  [[deprecated("use ParetoFront() instead")]] const std::vector<arma::mat>& Front()
  {
    if (rcFront.size() == 0)
    {
      // Match the old return format.
      for (size_t i = 0; i < paretoFront.n_slices; ++i)
      {
        rcFront.push_back(arma::mat(paretoFront.slice(i)));
      }
    }

    return rcFront;
  }

 private:
  /**
   * Evaluate objectives for the elite population.
   *
   * @tparam ArbitraryFunctionType std::tuple of multiple function types.
   * @tparam MatType Type of matrix to optimize.
   * @param population The elite population.
   * @param objectives The set of objectives.
   * @param calculatedObjectives Vector to store calculated objectives.
   */
  template<std::size_t I = 0,
           typename MatType,
           typename ...ArbitraryFunctionType>
  typename std::enable_if<I == sizeof...(ArbitraryFunctionType), void>::type
  EvaluateObjectives(std::vector<MatType>&,
                     std::tuple<ArbitraryFunctionType...>&,
                     std::vector<arma::Col<typename MatType::elem_type> >&);

  template<std::size_t I = 0,
           typename MatType,
           typename ...ArbitraryFunctionType>
  typename std::enable_if<I < sizeof...(ArbitraryFunctionType), void>::type
  EvaluateObjectives(std::vector<MatType>& population,
                     std::tuple<ArbitraryFunctionType...>& objectives,
                     std::vector<arma::Col<typename MatType::elem_type> >&
                     calculatedObjectives);

  /**
   * Reproduce candidates from the elite population to generate a new
   * population.
   *
   * @tparam MatType Type of matrix to optimize.
   * @param population The elite population.
   * @param objectives The set of objectives.
   * @param lowerBound Lower bound of the coordinates of the initial population.
   * @param upperBound Upper bound of the coordinates of the initial population.
   */
  template<typename MatType>
  void BinaryTournamentSelection(std::vector<MatType>& population,
                                 const MatType& lowerBound,
                                 const MatType& upperBound);

  /**
   * Crossover two parents to create a pair of new children.
   *
   * @tparam MatType Type of matrix to optimize.
   * @param childA A newly generated candidate.
   * @param childB Another newly generated candidate.
   * @param parentA First parent from elite population.
   * @param parentB Second parent from elite population.
   */
  template<typename MatType>
  void Crossover(MatType& childA,
                 MatType& childB,
                 const MatType& parentA,
                 const MatType& parentB);

  /**
   * Mutate the coordinates for a candidate.
   *
   * @tparam MatType Type of matrix to optimize.
   * @param child The candidate whose coordinates are being modified.
   * @param objectives The set of objectives.
   * @param lowerBound Lower bound of the coordinates of the initial population.
   * @param upperBound Upper bound of the coordinates of the initial population.
   */
  template<typename MatType>
  void Mutate(MatType& child,
              const MatType& lowerBound,
              const MatType& upperBound);

  /**
   * Sort the candidate population using their domination count and the set of
   * dominated nodes.
   *
   * @tparam MatType Type of matrix to optimize.
   * @param fronts The population is sorted into these Pareto fronts. The first
   *     front is the best, the second worse and so on.
   * @param ranks The assigned ranks, used for crowding distance based sorting.
   * @param calculatedObjectives The previously calculated objectives.
   */
  template<typename MatType>
  void FastNonDominatedSort(
      std::vector<std::vector<size_t> >& fronts,
      std::vector<size_t>& ranks,
      std::vector<arma::Col<typename MatType::elem_type> >& calculatedObjectives);

  /**
   * Operator to check if one candidate Pareto-dominates the other.
   *
   * A candidate is said to dominate the other if it is at least as good as the
   * other candidate for all the objectives and there exists at least one
   * objective for which it is strictly better than the other candidate.
   *
   * @tparam MatType Type of matrix to optimize.
   * @param calculatedObjectives The previously calculated objectives.
   * @param candidateP The candidate being compared from the elite population.
   * @param candidateQ The candidate being compared against.
   * @return true if candidateP Pareto dominates candidateQ, otherwise, false.
   */
  template<typename MatType>
  bool Dominates(
      std::vector<arma::Col<typename MatType::elem_type> >& calculatedObjectives,
      size_t candidateP,
      size_t candidateQ);

  /**
   * Assigns crowding distance metric for sorting.
   *
   * @param front The previously generated Pareto fronts.
   * @param calculatedObjectives The previously calculated objectives.
   * @param crowdingDistance The crowding distance for each individual in
   *    the population.
   */
  template <typename MatType>
  void CrowdingDistanceAssignment(
      const std::vector<size_t>& front,
      std::vector<arma::Col<typename MatType::elem_type>>& calculatedObjectives,
      std::vector<typename MatType::elem_type>& crowdingDistance);

  /**
   * The operator used in the crowding distance based sorting.
   *
   * If a candidates has a lower rank then it is preferred.
   * Otherwise, if the ranks are equal then the candidate with the larger
   * crowding distance is preferred.
   *
   * @param idxP The index of the first cadidate from the elite population being
   *     sorted.
   * @param idxQ The index of the second cadidate from the elite population
   *     being sorted.
   * @param ranks The previously calculated ranks.
   * @param crowdingDistance The crowding distance for each individual in
   *    the population.
   * @return true if the first candidate is preferred, otherwise, false.
   */
  template<typename MatType>
  bool CrowdingOperator(size_t idxP,
                        size_t idxQ,
                        const std::vector<size_t>& ranks,
                        const std::vector<typename MatType::elem_type>& crowdingDistance);

  //! The number of objectives being optimised for.
  size_t numObjectives;

  //! The numbeer of variables used per objectives.
  size_t numVariables;

  //! The number of candidates in the population.
  size_t populationSize;

  //! Maximum number of generations before termination criteria is met.
  size_t maxGenerations;

  //! Probability that crossover will occur.
  double crossoverProb;

  //! Probability that mutation will occur.
  double mutationProb;

  //! Strength of the mutation.
  double mutationStrength;

  //! The tolerance for termination.
  double epsilon;

  //! Lower bound of the initial swarm.
  arma::vec lowerBound;

  //! Upper bound of the initial swarm.
  arma::vec upperBound;

  //! The set of all the Pareto optimal points.
  //! Stored after Optimize() is called.
  arma::cube paretoSet;

  //! The set of all the Pareto optimal objective vectors.
  //! Stored after Optimize() is called.
  arma::cube paretoFront;

  //! A different representation of the Pareto front, for reverse compatibility
  //! purposes.  This can be removed when ensmallen 3.x is released!  (Along
  //! with `Front()`.)  This is only populated when `Front()` is called.
  std::vector<arma::mat> rcFront;
};

} // namespace ens

// Include implementation.
#include "nsga2_impl.hpp"

#endif
