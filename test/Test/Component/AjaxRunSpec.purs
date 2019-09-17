module Test.Component.AjaxRunSpec where

import Prelude
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff, Milliseconds(..), delay)
import Effect.Class (liftEffect)
import React.Basic (createContext, element)
import React.TestingLibrary (cleanup, fireEventClick, fireEventInput, renderComponent)
import Run (Run, case_, interpret, on)
import Test.Component.AjaxRun (GET_USER, GetUserF(..), Ctx(..), _getUser, mkAjaxRun, mkProvider)
import Test.Spec (Spec, after_, describe, it)
import Test.Spec.Assertions.DOM (textContentShouldEqual)

interpretMock ∷ Run ( getUser ∷ GET_USER ) ~> Aff
interpretMock =
  interpret
    ( case_
        # on _getUser case _ of
            GetUser 1 reply -> delay (100.0 # Milliseconds) $> (reply $ Just "George")
            GetUser 2 reply -> pure $ reply $ Just "Ringo"
            GetUser _ reply -> pure $ reply $ Nothing
    )

spec ∷ Spec Unit
spec =
  after_ cleanup do
    describe "A component that makes AJAX calls" do
      it "can be mocked with Run and Context" do
        { findByLabelText, findByTestId } <-
          liftEffect do
            ctx <- createContext (Ctx interpretMock)
            provider <- mkProvider ctx (Ctx interpretMock)
            ajaxRun <- mkAjaxRun ctx
            renderComponent provider { children: [ element ajaxRun {} ] }
        input <- findByLabelText "User to lookup"
        button <- findByLabelText "Get User"
        fireEventInput input "1"
        fireEventClick button
        userIdElem <- findByTestId "userId"
        userIdElem `textContentShouldEqual` "George"
        fireEventInput input "2"
        fireEventClick button
        userIdElem `textContentShouldEqual` "Ringo"
