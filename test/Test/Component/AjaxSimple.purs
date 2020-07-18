module Test.Component.AjaxSimple where

import Prelude
import Data.Foldable (foldMap, for_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Foreign.Object as Object
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (ReactComponent, reactComponent, fragment, useState, (/\))
import React.Basic.Hooks as React

type GetUserId
  = Aff (Maybe Int)

mkAjaxSimple ∷ GetUserId -> Effect (ReactComponent {})
mkAjaxSimple getUserId = do
  reactComponent "Ajax" \props -> React.do
    maybeUserId /\ setUserId <- useState Nothing
    let
      getAndSetUser = do
        remoteUserId <- getUserId
        liftEffect $ for_ remoteUserId \uid -> setUserId \_ -> Just uid
    pure
      $ fragment
          [ R.button
              { onClick: handler_ $ launchAff_ getAndSetUser
              , children: [ R.text $ "Get User" ]
              , id: "get-user-button"
              }
          , R.label
              { htmlFor: "get-user-button"
              , children:
                [ R.text "Get User" ]
              }
          , maybeUserId
              # foldMap \userId ->
                  R.div
                    { _data: Object.singleton "testid" "userId"
                    , children: [ R.text (show userId) ]
                    }
          ]
