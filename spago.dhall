{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "my-project"
, dependencies =
    [ "aff-promise"
    , "console"
    , "debug"
    , "effect"
    , "foreign"
    , "foreign-object"
    , "psci-support"
    , "react-basic-hooks"
    , "remotedata"
    , "run"
    , "simple-json"
    , "spec"
    , "spec-discovery"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
