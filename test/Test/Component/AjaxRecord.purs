module Test.Component.AjaxRecord where

import Prelude
import Data.Either (note)
import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Foreign.Object (fromHomogeneous)
import Network.RemoteData as RD
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (handler, handler_)
import React.Basic.Hooks (JSX, ReactChildren, ReactComponent, ReactContext, fragment, provider, reactChildrenToArray, reactComponent, reactComponentWithChildren, useContext, useState, (/\))
import React.Basic.Hooks as React

type Ctx
  = { getUser ∷ Int -> Aff (Maybe String) }

mkProvider ∷
  ReactContext Ctx ->
  Ctx ->
  Effect (ReactComponent { children ∷ ReactChildren JSX })
mkProvider context interpreter = do
  reactComponentWithChildren "Provider" \{ children } -> React.do
    pure $ provider context interpreter (reactChildrenToArray children)

mkAjaxRecord ∷ ReactContext Ctx -> Effect (ReactComponent {})
mkAjaxRecord ctx = do
  reactComponent "Ajax" \props -> React.do
    remoteUserId /\ modifyUserId <- useState RD.NotAsked
    inputText /\ updateInputText <- useState Nothing
    { getUser } <- useContext ctx
    let
      getAndSetUser = do
        liftEffect $ modifyUserId $ const RD.Loading
        remoteUser <- getUser $ fromMaybe (-1) (Int.fromString =<< inputText)
        let
          newUserId = remoteUser # note "Not Found" # RD.fromEither
        liftEffect $ modifyUserId $ const newUserId
    pure
      $ fragment
          [ R.input
              { onChange: handler targetValue $ const >>> updateInputText
              , id: "user-id-input"
              , value: fromMaybe "" inputText
              }
          , R.label
              { htmlFor: "user-id-input"
              , children: [ R.text "User to lookup" ]
              }
          , R.button
              { onClick: handler_ $ launchAff_ getAndSetUser
              , children: [ R.text $ "Get User" ]
              , id: "get-user-button"
              }
          , R.label
              { htmlFor: "get-user-button"
              , children:
                [ R.text "Get User" ]
              }
          , R.div
              { _data: fromHomogeneous { testid: "userId" }
              , children:
                [ R.text case remoteUserId of
                    RD.NotAsked -> ""
                    RD.Loading -> "Loading..."
                    RD.Failure e -> e
                    RD.Success s -> s
                ]
              }
          ]
