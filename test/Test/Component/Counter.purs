module Test.Component.Counter where

import Prelude
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (ReactComponent, reactComponent, fragment, useEffectAlways, useState, (/\))
import React.Basic.Hooks as React

mkCounter ∷ Effect (ReactComponent { onRender :: Effect Unit })
mkCounter = do
  reactComponent "Counter" \props -> React.do
    counter /\ setCounter <- useState 0
    useEffectAlways do
      props.onRender
      pure (pure unit)
    pure
      $ fragment
          [ R.button
              { onClick: handler_ $ setCounter (_ + 1)
              , children: [ R.text $ "Increment: " <> show counter ]
              , id: "basic-counter"
              }
          , R.label
              { htmlFor: "basic-counter"
              , children:
                [ R.text "A simple counter" ]
              }
          ]
