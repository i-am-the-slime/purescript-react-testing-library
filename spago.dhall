{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "purescript-react-basic-testing-library"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "arrays"
  , "avar"
  , "bifunctors"
  , "control"
  , "datetime"
  , "effect"
  , "either"
  , "exceptions"
  , "foldable-traversable"
  , "foreign"
  , "foreign-object"
  , "functions"
  , "identity"
  , "integers"
  , "lists"
  , "maybe"
  , "newtype"
  , "nullable"
  , "partial"
  , "prelude"
  , "react-basic"
  , "react-basic-dom"
  , "react-basic-hooks"
  , "record"
  , "remotedata"
  , "run"
  , "spec"
  , "strings"
  , "transformers"
  , "tuples"
  , "typelevel-prelude"
  , "unsafe-coerce"
  , "variant"
  , "web-dom"
  , "web-events"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
, repository =
    "https://github.com/i-am-the-slime/purescript-react-testing-library"
}
