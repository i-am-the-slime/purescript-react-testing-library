module Test.Component.Tags where

import Prelude
import Data.Array (filter)
import Effect (Effect)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (ReactComponent, reactComponent, useState, (/\))
import React.Basic.Hooks as React

mkTags ∷ Effect (ReactComponent {})
mkTags = do
  reactComponent "Tags" \props -> React.do
    tags /\ setTags <- useState [ "1", "2", "3" ]
    pure
      $ R.div_
      $ map
          ( \tag ->
              R.span
                { role: "tag"
                , onClick: handler_ $ setTags (filter (_ /= tag))
                , children: [ R.text tag ]
                }
          )
          tags
