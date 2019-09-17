module Test.Main where

import Prelude
import Data.Identity (Identity(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (un)
import Data.Time.Duration (Milliseconds(..), Seconds(..), fromDuration)
import Effect (Effect)
import Effect.Aff (delay, launchAff_)
import Effect.Class (liftEffect)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (defaultConfig, runSpecT)

main ∷ Effect Unit
main =
  launchAff_ do
    specs <- (discover "\\.*Spec") # liftEffect
    delay (1000.0 # Milliseconds)
    runSpecT
      config
      [ consoleReporter ]
      specs
      # un Identity
  where
  config =
    defaultConfig
      { slow = 5.0 # Seconds # fromDuration
      , timeout = Nothing
      }
