{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
module Frontend where

import Data.Text (Text)

import Obelisk.Frontend
import Obelisk.Route
import Reflex.Dom.Core

import Obelisk.Generated.Static
import Common.Route

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      elAttr "base" ("href" =: "/") blank
      elAttr "meta" ("name" =: "viewport" <> "content" =: "width=device-width, initial-scale=1") blank
      el "title" $ text "I"
      elAttr "link" ("rel" =: "stylesheet" <> "type" =: "text/css" <> "href" =: static @"semantic.min.css") blank
  , _frontend_body = divClass "ui container" $ do
      divClass "ui header" $ text "I"
      divClass "ui segment" $ do
        moodE <- moodInput
        widgetHold_ blank $ ffor moodE $ \mood ->
          el "pre" $ text mood
  }

-- | Widget for entering a mood for current moment.
moodInput :: DomBuilder t m => m (Event t Text)
moodInput = do
  valD <- divClass "ui input" $
    value <$> inputElement def
  addE <- buttonCls "ui primary button" $ text "Add"
  pure $ tag (current valD) addE


-- | Like `button` but using custom CSS classes
buttonCls :: DomBuilder t m => Text -> m a -> m (Event t ())
buttonCls cls = fmap (domEvent Click . fst) . elClass' "button" cls
