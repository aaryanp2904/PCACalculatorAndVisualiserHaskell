# Principal Component Analysis Calculator in Haskell

## Editing and trying out the code 

First, remember to have hmatrix on your system. You need to install some packages, you can do ths using stack or cabal. Try either one to see which works.

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

I already had cabal installed but doing the method below threw some errors for me. You can try this if you want:

`cabal update`
`cabal install hmatrix`

5. Check you have it using

`stack ghci`
`import Numeric.LinearAlgebra`

This shouldn't throw any errors.

6. Similarly, get Chart, Chart-diagrams and cassava using either stack or cabal

`cabal install Chart-diagrams`
`cabal install Chart`
`cabal install cassava`

To install using stack simply replace `cabal` with `stack`.


## Running the code

I first created a `build` directory in the working directory. This will contain all the `.o` and `.hi` files that GHC outputs. To compile the program, simply run this in the directory containing all the `.hs` files:

`ghc -o PCA Main.hs -package hmatrix -outputdir build`

This code essentially tells GHC to make a `.o` (executable) file called `PCA` using `Main.hs`. The `-package hmatrix` specifies that we are also using the hmatrix package and the `-outputdir build` says to output all the other files in the `build` directory as explained above.

To actually run the program, simply do:

`./PCA`# PCACalculatorHaskell
