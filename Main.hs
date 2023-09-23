import Numeric.LinearAlgebra
import qualified Numeric.LinearAlgebra as LA
import Data.Typeable
import Covariance
import Eigen
import Graphics.Gnuplot.Simple
import Graphics.Gnuplot.Terminal.Default
import Control.Monad (void)

import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Diagrams

pca:: [[Double]] -> [[Double]]
pca dataPoints 
  | length dataPoints == 2 = dataPoints
  | otherwise = res
  where covMat = getStandardizedCovarianceMatrix dataPoints
        (eigenvalsvec, eigenvecsmat) = eig covMat
        eigenvals = map realPart (toList eigenvalsvec)
        eigenvecs = [map realPart ev | ev <- (toLists (tr eigenvecsmat))]
        (removedVals, removedVecs) = removeSmallestEigen eigenvals eigenvecs
        removedVecsMat = fromLists removedVecs
        standardizedOriginalDataset = fromLists ([standardize col | col <- dataPoints])
        res = toLists ((removedVecsMat) LA.<> (standardizedOriginalDataset))


scatterPlot :: [[Double]] -> Renderable()
scatterPlot dps = toRenderable $ do
  layout_title .= "Scatter Plot"
  plot $ points "Data" (zip (dps !! 0) (dps !! 1))

main::IO()
main = do
  let chart = scatterPlot
  let transformed = pca [[10, 5, 4, 11, 6, 12, 19, 11, 20, 21, 18, 6, 19], [102,160,163,99,168,106,251,105,263,231,205,157,104], [-11, -35, -34, -9, -30, -9, 12, -8, 15, 8, 11, -31, -5]]
  void $ renderableToFile def "scatter_plot.svg" (chart transformed)
