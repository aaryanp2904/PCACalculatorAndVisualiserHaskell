import Numeric.LinearAlgebra
import qualified Numeric.LinearAlgebra as LA
import Data.Typeable
import Covariance
import Eigen
import Graphics.Gnuplot.Simple
import Graphics.Gnuplot.Terminal.Default
import Control.Monad (void)
import qualified Data.ByteString.Lazy as BL
import Data.Csv
import Graphics.Rendering.Chart.Easy
import qualified Graphics.Rendering.Chart.Easy as GRE
import Graphics.Rendering.Chart.Backend.Diagrams
import Data.List.Split

pca:: [[Double]] -> [[Double]]
pca dataPoints 
  | length dataPoints == 2 = dataPoints
  | otherwise = res
  where covMat = getStandardizedCovarianceMatrix dataPoints
        (eigenvalsvec, eigenvecsmat) = eig covMat
        eigenvals = map realPart (LA.toList eigenvalsvec)
        eigenvecs = [map realPart ev | ev <- (toLists (tr eigenvecsmat))]
        (removedVals, removedVecs) = removeSmallestEigen eigenvals eigenvecs
        removedVecsMat = fromLists removedVecs
        standardizedOriginalDataset = fromLists ([standardize col | col <- dataPoints])
        res = toLists ((removedVecsMat) LA.<> (standardizedOriginalDataset))


scatterPlot :: [[Double]] -> Renderable()
scatterPlot dps = toRenderable $ do
  layout_title GRE..= "Scatter Plot"
  plot $ points "Data" (zip (dps !! 0) (dps !! 1))

getFileData:: String -> [[Double]]
getFileData content = toLists datasetMatrixGroupedByColumn
  where 
    dataByRows = map (splitOn ",") $ lines (content)
    dataByRowsDouble = map convList dataByRows
    datasetMatrixGroupedByColumn = tr (fromLists dataByRowsDouble)
        
convList:: [String] -> [Double]
convList [] = []
convList [""] = []
convList xs = map (\x -> (read x :: Double)) xs

main::IO()
main = do
  putStrLn "Enter csv file: "
  fileName <- getLine
  content <- readFile fileName
  let valuesInt = getFileData content
  let transformed = pca valuesInt
  void $ renderableToFile def "scatter_plot.svg" (scatterPlot transformed)
