% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PPC_KO_Rinterface.R
\name{data_2d_wrapper_from_list}
\alias{data_2d_wrapper_from_list}
\title{data_2d_wrapper_from_list}
\arguments{
\item{Xt}{\strong{\verb{list of numeric matrices}}. Length of the list: n: number of time instants. Each matrix
needs to have the same dimensions (dim_x1,dim_x2), where dim_x1 is the number of discrete evaluations of the
surface along dimension one, dim_x2 the same along dimension two.}
}
\value{
\strong{\verb{numeric matrix}}, as described above.
}
\description{
Wrapping a R-list of numeric matrices into an numeric matrix as suitable input for \link{PPC_KO_2d} and \link{KO_check_hps_2d}. Each element of the list represents a time instant,
in which the discrete evaluations of the surface is represented by the matrix. Each column of the output matrix represents a time instants,
while each rows a discrete evaluation of the surface.
}
\details{
NaNs values have to be passed anyway as explained in \link{PPC_KO_2d}.
}
\examples{
library(PPCKO)
Xt = list(matrix(c(1,2,NaN,3),nrow=2,ncol=2),matrix(c(4,5,NaN,7),nrow=2,ncol=2))
data_2d_wrapper_from_list(Xt)
# return  [  1,   4]
#         [  2,   5]
#         [NaN, NaN]
#         [  3,   7]
}
\references{
Source code: \href{https://github.com/AndreaEnricoFranzoni/PPCforAutoregressiveOperator}{PPCKO implementation}
}
\seealso{
\link{PPC_KO_2d}, \link{KO_check_hps_2d}
}
\author{
Andrea Enrico Franzoni
}
