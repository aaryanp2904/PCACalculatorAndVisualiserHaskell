module Covariance (standardize, getStandardizedCovarianceMatrix) where 

import Numeric.LinearAlgebra

-- Provided generic type signatures instead of constraining just to Doubles for usability in future,
-- however it is guaranteed that the provided type of a is Doubles due to the implementation of Double

-- Takes a list of floating as and returns the standardized version
standardize:: Floating a => [a] -> [a]
standardize [] = []
standardize xs = map (\x -> (x - mean) / std) xs
  where mean = getMean xs
        std = getStd xs mean

-- Takes a list of floating as and returns its mean
getMean:: Floating a => [a] -> a
getMean xs = total / count
  where
    (total, count) = foldl (\(accTotal, accCount) x -> (accTotal + x, accCount + 1)) (0, 0) xs

-- Takes a list of floating as and their mean and returns its standard deviation
getStd:: Floating a => [a] -> a -> a
getStd [] mean = 0
getStd xs mean = sqrt (tot / (count - 1))
  where (tot, count) = foldl (\(tot, count) x -> (tot + (x - mean) ** 2, count + 1)) (0,0) xs

-- Take a STANDARDISED list of observations of X and a STANDARDISED list of observations of Y and return their covariance
getStandardizedCovariance:: Floating a => [a] -> [a] -> a
getStandardizedCovariance [] [] = 0
getStandardizedCovariance xs ys = getStandardizedCovarianceHelper xs ys 0 0

-- Takes a a STANDARDISED list of observations of X and a STANDARDISED list of observations of Y along with the number of observations previously traversed and
-- the sum of the product of the items from each list
getStandardizedCovarianceHelper:: Floating a => [a] -> [a] -> a -> a -> a
getStandardizedCovarianceHelper [] [] traversed tot = tot / (traversed - 1)
getStandardizedCovarianceHelper (x: xs) (y: ys) traversed tot = getStandardizedCovarianceHelper xs ys (traversed+1) (tot + x * y)


-- Takes a table of samples represented as a list of list of floating as and calculates the covariance matrix for the STANDARDIZED versions columns in data
getStandardizedCovarianceMatrix:: (Floating a, Element a) => [[a]] -> Matrix a
getStandardizedCovarianceMatrix [[]] = fromLists []
getStandardizedCovarianceMatrix xxs = fromLists covMatrixAsList
  where standardizedValues = [standardize col | col <- xxs]
        covMatrixAsList = [ [getStandardizedCovariance a b | b <- standardizedValues] | a <- standardizedValues ]