module Test.Component.Input where

import Prelude
import Data.Foldable (traverse_)
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (handler)
import React.Basic.Hooks (ReactComponent, reactComponent, fragment, useState, (/\))
import React.Basic.Hooks as React

mkInput ∷ Effect (ReactComponent {})
mkInput = do
  reactComponent "Input" \props -> React.do
    text /\ setText <- useState ""
    pure
      $ fragment
          [ R.input
              { onChange: handler targetValue <<< traverse_ $ setText <<< const
              , value: text
              , type: "text"
              , id: "basic-input"
              }
          , R.label
              { htmlFor: "basic-input"
              , children:
                [ R.text "Some input" ]
              }
          ]
