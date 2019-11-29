#!/usr/bin/env bash

if [ -z $1 ]
then
    echo "Must provide project name, will do nothing."
    exit
fi

mkdir $1
cd $1

cat > $1.cabal <<EOF
cabal-version:          2.4
name:                   $1
version:                0.0.0.0

library
  default-language:     Haskell2010
  hs-source-dirs:       src
  exposed-modules:      Lib
  default-extensions:   PartialTypeSignatures
  ghc-options:          -Wall
                        -Werror
                        -Wcompat
                        -Widentities
                        -Wincomplete-record-updates
                        -Wincomplete-uni-patterns
                        --Wmissing-export-lists
                        --Wmissing-import-lists
                        -Wnoncanonical-monad-instances
                        -Wnoncanonical-monadfail-instances
                        -Wpartial-fields
                        -Wredundant-constraints
                        -fdefer-typed-holes
  build-depends:        base

executable $1
  default-language:     Haskell2010
  hs-source-dirs:       app
  main-is:              Main.hs
  default-extensions:   PartialTypeSignatures
  ghc-options:          -Wall
                        -Werror
                        -Wcompat
                        -Widentities
                        -Wincomplete-record-updates
                        -Wincomplete-uni-patterns
                        --Wmissing-export-lists
                        --Wmissing-import-lists
                        -Wnoncanonical-monad-instances
                        -Wnoncanonical-monadfail-instances
                        -Wpartial-fields
                        -Wredundant-constraints
                        -fdefer-typed-holes
                        -rtsopts
                        -threaded
  build-depends:        base
                      , $1

test-suite tests
  default-language:     Haskell2010
  type:                 exitcode-stdio-1.0
  hs-source-dirs:       test
  main-is:              Spec.hs
  default-extensions:   PartialTypeSignatures
  ghc-options:          -Wall
                        -Werror
                        -Wcompat
                        -Widentities
                        -Wincomplete-record-updates
                        -Wincomplete-uni-patterns
                        --Wmissing-export-lists
                        --Wmissing-import-lists
                        -Wnoncanonical-monad-instances
                        -Wnoncanonical-monadfail-instances
                        -Wpartial-fields
                        -Wredundant-constraints
                        -fdefer-typed-holes
                        -rtsopts
                        -threaded
  build-depends:        base
                      , $1
EOF

mkdir test
cat > test/Spec.hs <<EOF
import Lib

main :: IO ()
main = helloWorld
EOF

mkdir src
cat > src/Lib.hs <<EOF
module Lib where

helloWorld :: IO ()
helloWorld = putStrLn "hello world"
EOF

mkdir app
cat > app/Main.hs <<EOF
import Lib (helloWorld)

main :: IO ()
main = helloWorld
EOF

cat > .gitignore <<EOF
dist/
dist-newstyle/
.stack-work/
cabal.project.local
*~
*.lock
EOF

cat > .ghci <<EOF
:set +m
:set -Wno-type-defaults
:set editor vim
:set prompt "λ %l > "
:set prompt-cont "  %l | "
EOF

cd ..
