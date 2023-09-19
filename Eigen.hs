module Eigen (removeSmallestEigen) where

import Numeric.LinearAlgebra

getSmallestEigen:: (Floating a, Ord a) => [a] -> a -> a
getSmallestEigen [] smallestEigenVal = smallestEigenVal
getSmallestEigen (eigenval:eigenvals) smallestEigenVal 
  | eigenval < smallestEigenVal = getSmallestEigen eigenvals eigenval
  | otherwise = getSmallestEigen eigenvals smallestEigenVal

removeSmallestEigen:: (Floating a, Eq a, Ord a) => [a] -> [[a]] -> ([a], [[a]])
removeSmallestEigen eigenvals eigenvecs = removeSmallestEigenHelper eigenvals eigenvecs smallestEigen
  where smallestEigen = getSmallestEigen eigenvals (eigenvals !! 0)

-- Eigenvalues, eigenvectors, smallest eigenvalue, return remaining eigenvalues and eigenvectors
removeSmallestEigenHelper:: (Floating a, Eq a) => [a] -> [[a]] -> a -> ([a], [[a]])
removeSmallestEigenHelper [] [] _ = ([], [[]])
removeSmallestEigenHelper (eigenval: eigenvals) (eigenvec: eigenvecs) smallestEigen  
  | eigenval == smallestEigen = (eigenvals, eigenvecs)
  | otherwise = (eigenval: restEigenvals, eigenvec: restEigenvecs)
  where (restEigenvals, restEigenvecs) = removeSmallestEigenHelper eigenvals eigenvecs smallestEigen