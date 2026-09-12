module React.TestingLibrary.DOM
  ( Geometry
  , stubGeometry
  , captureConsole
  , waitFor
  , dispatchEvent
  ) where

import Prelude
import Effect (Effect)
import Control.Promise (Promise)
import Web.DOM.Element (Element)
import Web.Event.EventTarget (EventTarget)

type Geometry = { x :: Number, y :: Number, width :: Number, height :: Number }

-- | Override native geometry reads using a caller-owned measurement action.
-- | The returned action restores the original property descriptors.
foreign import stubGeometry :: Element -> Effect Geometry -> Effect (Effect Unit)

-- | Capture calls to a console method until the returned restore/read action runs.
foreign import captureConsole :: String -> Effect (Effect (Array String))

-- | Retry an assertion with Testing Library's DOM mutation and timer integration.
foreign import waitFor :: Effect Unit -> Int -> Effect (Promise Unit)

foreign import dispatchEvent :: String -> EventTarget -> Effect Unit
