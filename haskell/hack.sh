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

executable $1
  default-language:     Haskell2010
  hs-source-dirs:       src
  main-is:              Main.hs
  default-extensions:   BangPatterns
                        InstanceSigs
                        LambdaCase
                        MultiWayIf
                        NamedWildCards
                        NoMonomorphismRestriction
                        NoStarIsType
                        NumericUnderscores
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
:set prompt "\ESC[92m\STX\nλ %l > \ESC[m\STX"
:set prompt-cont "\ESC[93m\STX  %l | \ESC[m\STX"
EOF

cd ..
