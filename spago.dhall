{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "react-testing-library"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "control"
  , "effect"
  , "exceptions"
  , "foldable-traversable"
  , "foreign"
  , "functions"
  , "identity"
  , "maybe"
  , "prelude"
  , "react-basic"
  , "spec"
  , "strings"
  , "transformers"
  , "unsafe-coerce"
  , "web-dom"
  , "web-events"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, license = "MIT"
, repository =
    "https://github.com/i-am-the-slime/purescript-react-testing-library"
}
