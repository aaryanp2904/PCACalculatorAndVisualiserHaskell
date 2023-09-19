-- Take a list of observations of X and a list of observations of Y and returns their covariance
getCovariance:: [Double] -> [Double] -> Double
getCovariance [] [] = 0
getCovariance xs ys = getCovarianceHelper xs ys (getMean xs) (getMean ys) 0 0

-- Takes a list of observations of X and a list of observations of Y along, the mean of X and the mean of Y with the number of observations previously traversed and
-- the sum of the product of the items from each list
getCovarianceHelper:: [Double] -> [Double] -> Double -> Double -> Double -> Double -> Double
getCovarianceHelper [] [] _ _ traversed tot = tot / (traversed - 1)
getCovarianceHelper (x: xs) (y: ys) meanx meany traversed tot = getCovarianceHelper xs ys meanx meany (traversed+1) (tot + (x - meanx) * (y - meany))

-- Takes a table of samples represented as a list of list of Doubles and calculates the covariance matrix for the STANDARDIZED versions columns in data
getCovarianceMatrix:: [[Double]] -> [[Double]]
getCovarianceMatrix [[]] = []
getCovarianceMatrix xxs = covMatrixAsList
  where covMatrixAsList = [ [getCovariance a b | b <- xxs] | a <- xxs]