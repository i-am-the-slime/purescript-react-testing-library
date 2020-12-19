{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "purescript-react-basic-testing-library"
, dependencies =
  [ "aff-promise"
  , "console"
  , "effect"
  , "foreign"
  , "foreign-object"
  , "react-basic-dom"
  , "react-basic-hooks"
  , "remotedata"
  , "run"
  , "simple-json"
  , "spec"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "MIT"
, repository = "https://github.com/i-am-the-slime/purescript-react-testing-library"
}
