{-
Welcome to your new Dhall package-set!

Below are instructions for how to edit this file for most use
cases, so that you don't need to know Dhall to use it.

## Warning: Don't Move This Top-Level Comment!

Due to how `dhall format` currently works, this comment's
instructions cannot appear near corresponding sections below
because `dhall format` will delete the comment. However,
it will not delete a top-level comment like this one.

## Use Cases

Most will want to do one or both of these options:
1. Override/Patch a package's dependency
2. Add a package not already in the default package set

This file will continue to work whether you use one or both options.
Instructions for each option are explained below.

### Overriding/Patching a package

Purpose:
- Change a package's dependency to a newer/older release than the
    default package set's release
- Use your own modified version of some dependency that may
    include new API, changed API, removed API by
    using your custom git repo of the library rather than
    the package set's repo

Syntax:
Replace the overrides' "{=}" (an empty record) with the following idea
The "//" or "⫽" means "merge these two records and
  when they have the same value, use the one on the right:"
-------------------------------
let override =
  { packageName =
      upstream.packageName // { updateEntity1 = "new value", updateEntity2 = "new value" }
  , packageName =
      upstream.packageName // { version = "v4.0.0" }
  , packageName =
      upstream.packageName // { repo = "https://www.example.com/path/to/new/repo.git" }
  }
-------------------------------

Example:
-------------------------------
let overrides =
  { halogen =
      upstream.halogen // { version = "master" }
  , halogen-vdom =
      upstream.halogen-vdom // { version = "v4.0.0" }
  }
-------------------------------

### Additions

Purpose:
- Add packages that aren't already included in the default package set

Syntax:
Replace the additions' "{=}" (an empty record) with the following idea:
-------------------------------
let additions =
  { "package-name" =
       mkPackage
         [ "dependency1"
         , "dependency2"
         ]
         "https://example.com/path/to/git/repo.git"
         "tag ('v4.0.0') or branch ('master')"
  , "package-name" =
       mkPackage
         [ "dependency1"
         , "dependency2"
         ]
         "https://example.com/path/to/git/repo.git"
         "tag ('v4.0.0') or branch ('master')"
  , etc.
  }
-------------------------------

Example:
-------------------------------
let additions =
  { benchotron =
      mkPackage
        [ "arrays"
        , "exists"
        , "profunctor"
        , "strings"
        , "quickcheck"
        , "lcg"
        , "transformers"
        , "foldable-traversable"
        , "exceptions"
        , "node-fs"
        , "node-buffer"
        , "node-readline"
        , "datetime"
        , "now"
        ]
        "https://github.com/hdgarrood/purescript-benchotron.git"
        "v7.0.0"
  }
-------------------------------
-}
let upstream =
      https://raw.githubusercontent.com/purescript/package-sets/prepare-0.15/src/packages.dhall
        sha256:b1c6d06132b7cbf1e93b1e5343044fba1604b50bfbe02d8f80a3002e71569c59

in  upstream
  with spec =
    { repo = "https://github.com/purescript-spec/purescript-spec.git"
    , version = "master"
    , dependencies =
      [ "aff"
      , "ansi"
      , "avar"
      , "console"
      , "exceptions"
      , "foldable-traversable"
      , "fork"
      , "now"
      , "pipes"
      , "prelude"
      , "strings"
      , "transformers"
      ]
    }
  with react-basic =
    { dependencies = [ "prelude", "effect", "record" ]
    , repo = "https://github.com/lumihq/purescript-react-basic.git"
    , version = "v16.0.0"
    }
  with react-basic-dom =
    { dependencies =
      [ "prelude"
      , "console"
      , "effect"
      , "foreign-object"
      , "psci-support"
      , "react-basic"
      , "unsafe-coerce"
      , "web-dom"
      , "web-events"
      , "web-file"
      , "web-html"
      ]
    , repo = "https://github.com/lumihq/purescript-react-basic-dom.git"
    , version = "v4.2.0"
    }
  with react-basic-emotion =
    { dependencies =
      [ "colors"
      , "console"
      , "effect"
      , "foreign"
      , "foreign-object"
      , "numbers"
      , "prelude"
      , "react-basic"
      , "react-basic-hooks"
      , "typelevel-prelude"
      , "unsafe-reference"
      ]
    , repo = "https://github.com/lumihq/purescript-react-basic-emotion.git"
    , version = "es-modules"
    }
  with react-basic.repo
       =
      "https://github.com/working-group-purescript-es/purescript-react-basic.git"
  with react-basic.version = "es-modules"
  with react-basic-dom.repo
       =
      "https://github.com/working-group-purescript-es/purescript-react-basic-dom.git"
  with react-basic-dom.version = "es-modules"
  with react-basic-hooks =
    { dependencies =
      [ "aff"
      , "aff-promise"
      , "bifunctors"
      , "console"
      , "control"
      , "datetime"
      , "effect"
      , "either"
      , "exceptions"
      , "foldable-traversable"
      , "functions"
      , "indexed-monad"
      , "integers"
      , "maybe"
      , "newtype"
      , "now"
      , "nullable"
      , "ordered-collections"
      , "prelude"
      , "psci-support"
      , "react-basic"
      , "refs"
      , "tuples"
      , "type-equality"
      , "unsafe-coerce"
      , "unsafe-reference"
      , "web-html"
      ]
    , repo = "https://github.com/spicydonuts/purescript-react-basic-hooks.git"
    , version = "purs-0.15-updates"
    }
  with variant =
    { dependencies =
      [ "enums"
      , "lists"
      , "maybe"
      , "partial"
      , "prelude"
      , "record"
      , "tuples"
      , "unsafe-coerce"
      ]
    , repo =
        "https://github.com/working-group-purescript-es/purescript-variant.git"
    , version = "v0.15.0-update"
    }
  with run =
    { dependencies =
      [ "aff"
      , "effect"
      , "either"
      , "free"
      , "maybe"
      , "newtype"
      , "prelude"
      , "profunctor"
      , "tailrec"
      , "tuples"
      , "type-equality"
      , "typelevel-prelude"
      , "unsafe-coerce"
      , "variant"
      ]
    , repo = "https://github.com/natefaubion/purescript-run.git"
    , version = "v4.0.0"
    }
