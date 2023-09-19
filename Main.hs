import Numeric.LinearAlgebra
import qualified Numeric.LinearAlgebra as LA
import Data.Typeable
import Covariance
import Eigen

pca:: [[Double]] -> [[Double]]
pca dataPoints = res
  where covMat = getStandardizedCovarianceMatrix dataPoints
        (eigenvalsvec, eigenvecsmat) = eig covMat
        eigenvals = map realPart (toList eigenvalsvec)
        eigenvecs = [map realPart ev | ev <- (toLists (tr eigenvecsmat))]
        (removedVals, removedVecs) = removeSmallestEigen eigenvals eigenvecs
        removedVecsMat = fromLists removedVecs
        standardizedOriginalDataset = fromLists ([standardize col | col <- dataPoints])
        res = toLists ((removedVecsMat) LA.<> (standardizedOriginalDataset))

main::IO()
main = do
    let dataset = [[11,14,16,20,23,11,8,4,10,12,5,34,15,18,12,20,12,15,20,8], [102,132,163,201,120,110,67,195,101,124,139,120,184,95,86,211,123,153,79,115], [4,3,2,6,2,3,3,3,4,4,5,7,3,1,5,4,6,6,3,4]]
    print(pca dataset)
