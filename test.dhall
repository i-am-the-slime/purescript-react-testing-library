let conf = ./spago.dhall

in      conf
    //  { sources = conf.sources # [ "test/**/*.purs" ]
        , dependencies =
              conf.dependencies
            # [ "aff"
              , "aff-promise"
              , "arrays"
              , "avar"
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
              , "prelude"
              , "react-basic"
              , "react-basic-dom"
              , "react-basic-hooks"
              , "record"
              , "refs"
              , "remotedata"
              , "spec"
              , "spec-discovery"
              , "strings"
              , "transformers"
              , "tuples"
              , "typelevel-prelude"
              , "unsafe-coerce"
              , "web-dom"
              , "web-events"
              , "web-html"
              , "yoga-json"
              ]
        }
