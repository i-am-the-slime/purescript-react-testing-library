module Test.Component.AjaxRun where

import Prelude
import Data.Foldable (for_)
import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe, maybe)
import Data.Symbol (SProxy(..))
import Data.Variant.Internal (FProxy)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Foreign.Object (fromHomogeneous)
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (handler, handler_)
import React.Basic.Hooks (JSX, ReactComponent, ReactContext, component, fragment, provider, useContext, useState, (/\))
import React.Basic.Hooks as React
import Run (Run, case_, interpret, on)
import Run as Run

newtype Ctx
  = Ctx (Run ( getUser ∷ GET_USER ) ~> Aff)

mkProvider ∷
  ReactContext Ctx ->
  Ctx ->
  Effect (ReactComponent { children ∷ Array JSX })
mkProvider context interpreter = do
  component "Provider" \{ children } -> React.do
    pure $ provider context interpreter children

mkAjaxRun ∷ ReactContext Ctx -> Effect (ReactComponent {})
mkAjaxRun ctx = do
  component "Ajax" \props -> React.do
    maybeUserId /\ setUserId <- useState Nothing
    inputText /\ updateInputText <- useState ""
    Ctx run <- useContext ctx
    let
      getAndSetUser = do
        remoteUserId <- run $ getUser $ fromMaybe (-1) (Int.fromString inputText)
        liftEffect $ for_ remoteUserId \uid -> setUserId \_ -> Just uid
    pure
      $ fragment
          [ R.input
              { onChange:
                handler targetValue
                  $ fromMaybe ""
                  >>> const
                  >>> updateInputText
              , id: "user-id-input"
              , value: inputText
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
          , maybeUserId
              # maybe mempty \userId ->
                  R.div
                    { _data: fromHomogeneous { testid: "userId" }
                    , children: [ R.text userId ]
                    }
          ]

data LogF a
  = Log String a

derive instance functorLogF ∷ Functor LogF

type LOG
  = FProxy LogF

_log = SProxy ∷ SProxy "log"

log ∷ ∀ r. String -> Run ( log ∷ LOG | r ) Unit
log str = Run.lift _log (Log str unit)

data GetUserF a
  = GetUser Int (Maybe String -> a)

derive instance functorGetUserF ∷ Functor GetUserF

type GET_USER
  = FProxy GetUserF

_getUser = SProxy ∷ SProxy "getUser"

getUser ∷ ∀ r. Int -> Run ( getUser ∷ GET_USER | r ) (Maybe String)
getUser userId = Run.lift _getUser (GetUser userId identity)

interpretReal ∷ Run ( getUser ∷ GET_USER ) ~> Aff
interpretReal =
  interpret
    ( case_
        # on _getUser case _ of
            GetUser i reply -> pure $ reply $ Just "hey"
    )
