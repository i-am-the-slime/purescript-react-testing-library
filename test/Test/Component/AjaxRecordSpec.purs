module Test.Component.AjaxRecordSpec where

import Prelude
import Data.Maybe (Maybe(..))
import Effect.Aff (Milliseconds(..), delay)
import Effect.Class (liftEffect)
import React.Basic (createContext, element)
import React.Basic.Hooks (reactChildrenFromArray)
import React.TestingLibrary (cleanup, fireEventClick, fireEventInput, renderComponent)
import Test.Component.AjaxRecord (Ctx, mkAjaxRecord, mkProvider)
import Test.Spec (Spec, after_, before, describe, it)
import Test.Spec.Assertions.DOM (textContentShouldEqual)

mock ∷ Ctx
mock =
  { getUser:
      case _ of
        1 -> delay (2.0 # Milliseconds) $> Just "John"
        _ -> pure $ Nothing
  }

spec ∷ Spec Unit
spec =
  let
    renderFn = do
      { findByLabelText, findByTestId } <-
        liftEffect do
          ctx <- createContext mock
          provider <- mkProvider ctx mock
          ajaxRecord <- mkAjaxRecord ctx
          let
            children = reactChildrenFromArray [ element ajaxRecord {} ]
          renderComponent provider { children }
      input <- findByLabelText "User to lookup"
      button <- findByLabelText "Get User"
      userId <- findByTestId "userId"
      pure { input, button, userId }
  in
    after_ cleanup
      $ before renderFn
      $ describe "A component that makes AJAX calls" do
          it "indicates it is loading while it is loading"
            $ \{ input, button, userId } -> do
                userId `textContentShouldEqual` ""
                fireEventInput input "1"
                fireEventClick button
                userId `textContentShouldEqual` "Loading..."
                delay $ 2.0 # Milliseconds
                userId `textContentShouldEqual` "John"
          it "shows not found for non-existing values"
            $ \{ input, button, userId } -> do
                userId `textContentShouldEqual` ""
                fireEventInput input "2"
                fireEventClick button
                userId `textContentShouldEqual` "Not Found"
