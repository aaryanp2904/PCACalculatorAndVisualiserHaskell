# Principal Component Analysis Calculator in Haskell

## Editing and trying out the code 

First, remember to have hmatrix on your system. You can do this two ways, one happened to work for me the other didn't - I was using WSL. 

### Stack method

The method that worked for me was:

1. To update the package lists for WSL

`sudo apt update`

2. You need to download these dependenceis to run hmatrix

`sudo apt install libblas-dev liblapack-dev`

3. If you don't already have stack you should probably download it

`curl -sSL https://get.haskellstack.org/ | sh`

4. Get hmatrix

`stack update`
`stack install hmatrix`

5. Check you have it using

`stack ghci`
`import Numeric.LinearAlgebra`

This shouldn't throw any errors.

### Cabal method

I already had cabal installed but doing this threw some errors for me. You can try this if you want:

`cabal update`
`cabal install hmatrix`


## Running the code

I first created a `build` directory in the working directory. This will contain all the `.o` and `.hi` files that GHC outputs. To compile the program, simply run this in the directory containing all the `.hs` files:

`ghc -o PCA Main.hs -package hmatrix -outputdir build`

This code essentially tells GHC to make a `.o` (executable) file called `PCA` using `Main.hs`. The `-package hmatrix` specifies that we are also using the hmatrix package and the `-outputdir build` says to output all the other files in the `build` directory as explained above.

To actually run the program, simply do:

`./PCA`# PCACalculatorHaskell
