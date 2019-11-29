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
name:                   {{name}}
version:                0.0.0.0

executable {{name}}
  default-language:     Haskell2010
  hs-source-dirs:       src
  main-is:              Main.hs
  default-extensions:   BangPatterns
                        InstanceSigs
                        LambdaCase
                        MultiWayIf
                        NoMonomorphismRestriction
                        OverloadedStrings
                        PartialTypeSignatures
                        PatternGuards
                        ScopedTypeVariables
                        TypeApplications
                        ViewPatterns
  ghc-options:          -Wall
                        -Wcompat
                        -Widentities
                        -Wincomplete-record-updates
                        -Wincomplete-uni-patterns
                        -Wnoncanonical-monad-instances
                        -Wnoncanonical-monadfail-instances
                        -Wpartial-fields
                        -Wredundant-constraints
                        -threaded
                        -rtsopts
                        -fdefer-typed-holes
                        -fno-warn-missing-signatures
                        -fno-warn-partial-type-signatures
  build-depends:        base
EOF

mkdir src
cat > src/Main.hs <<EOF
main = putStrLn "hello world"
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
