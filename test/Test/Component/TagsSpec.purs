module Test.Component.TagsSpec where

import Prelude
import Data.Array (length, zip)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Data.Traversable (traverse_)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import React.Basic (ReactComponent)
import React.TestingLibrary (cleanup, fireEventClick, renderComponent)
import Test.Component.Tags (mkTags)
import Test.Spec (Spec, after_, before, describe, it)
import Test.Spec.Assertions (fail, shouldEqual)
import Test.Spec.Assertions.DOM (textContentShouldEqual)

spec ∷ Spec Unit
spec =
  after_ cleanup
    $ before setup
    $ describe
        "A tag viewer" do
        it
          "renders without errors" \tags -> do
          { findAllByRole } <- renderComponent tags {}
          tags' <- findAllByRole "tag"
          let
            expectedTags = [ "1", "2", "3" ]
          length tags' `shouldEqual` length expectedTags
          traverse_ (\(Tuple elem tag) -> elem `textContentShouldEqual` tag) (zip tags' expectedTags)
        it
          "removes a tag when clicked" \tags -> do
          { findByText, queryByText } <- renderComponent tags {}
          let
            tagToDelete = "2"
          elem <- findByText tagToDelete
          fireEventClick elem
          case queryByText tagToDelete of
            Nothing -> pure unit
            Just _ -> fail $ "Tag found with text: " <> tagToDelete

setup ∷ Aff (ReactComponent {})
setup = mkTags # liftEffect
