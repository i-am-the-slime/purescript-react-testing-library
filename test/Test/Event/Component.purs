module Test.Event.Component where

import Prelude
import Data.Symbol (class IsSymbol, SProxy(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Uncurried (EffectFn1)
import Foreign.Object (Object)
import Foreign.Object as Obj
import Prim.Row (class Cons, class Lacks, class Union)
import React.Basic.DOM (CSS, Props_div, Props_img, css)
import React.Basic.DOM as R
import React.Basic.Events (EventFn, SyntheticEvent, handler)
import React.Basic.Hooks (JSX, ReactComponent, reactComponent)
import Record.Builder as RB

mkEventElem ∷
  ∀ eventFn on r props.
  Cons on (EffectFn1 SyntheticEvent Unit) ( _data ∷ Object String, style ∷ CSS ) r =>
  Lacks on ( _data ∷ Object String, style ∷ CSS ) =>
  IsSymbol on =>
  Lacks "key" props =>
  Lacks "ref" props =>
  Lacks "children" props =>
  (Record r -> JSX) ->
  SProxy on ->
  EventFn SyntheticEvent eventFn ->
  (eventFn -> Aff Unit) ->
  Effect (ReactComponent (Record props))
mkEventElem elem onWhat eventFn theHandler =
  reactComponent "EventComponent" \_ -> React.do
    pure (elem built)
  where
    built =
      RB.build attrs
        { _data: Obj.singleton "testid" "event-component"
        , style: css { width: "10px", height: "10px" }
        }

    attrs =
      RB.insert onWhat
        ( handler eventFn (launchAff_ <<< theHandler)
        )

mkEventImg ∷
  ∀ t123 t128 t129 t135 t139 t140.
  Cons
    t123
    (EffectFn1 SyntheticEvent Unit)
    ( alt ∷ String
    , tabIndex ∷ Int
    )
    t140 =>
  Lacks
    t123
    ( alt ∷ String
    , tabIndex ∷ Int
    ) =>
  IsSymbol t123 =>
  Lacks "children" t135 =>
  Lacks "key" t135 =>
  Lacks "ref" t135 =>
  Union t140 t139 Props_img =>
  SProxy t123 -> EventFn SyntheticEvent t128 -> (t128 -> Aff t129) -> Effect (ReactComponent (Record t135))
mkEventImg onWhat eventFn theHandler =
  reactComponent "EventComponent" \_ -> React.do
    pure (R.img built)
  where
    built =
      RB.build attrs
        { alt: "event-component"
        , tabIndex: 0 -- for key events
        }

    attrs =
      RB.insert onWhat
        ( handler eventFn (launchAff_ <<< theHandler)
        )

mkEventInput ∷
  ∀ t108 t112 t113 t88 t93 t94.
  Cons t88 (EffectFn1 SyntheticEvent Unit) ( children ∷ Array JSX ) t113 =>
  Lacks t88 ( children ∷ Array JSX ) =>
  IsSymbol t88 =>
  Lacks "children" t108 =>
  Lacks "key" t108 =>
  Lacks "ref" t108 =>
  Union t113 t112 Props_div => SProxy t88 -> EventFn SyntheticEvent t93 -> (t93 -> Aff t94) -> Effect (ReactComponent (Record t108))
mkEventInput onWhat eventFn theHandler =
  reactComponent "EventComponent" \_ -> React.do
    pure (R.div built)
  where
    built =
      RB.build attrs
        { children:
          [ R.input { id: "input-id" }
          , R.label { htmlFor: "input-id", children: [ R.text "Input Label" ] }
          ]
        }

    attrs =
      RB.insert onWhat
        ( handler eventFn (launchAff_ <<< theHandler)
        )

on ∷
  { abort ∷ SProxy "onAbort"
  , animationEnd ∷ SProxy "onAnimationEnd"
  , animationIteration ∷ SProxy "onAnimationIteration"
  , animationStart ∷ SProxy "onAnimationStart"
  , blur ∷ SProxy "onBlur"
  , canPlay ∷ SProxy "onCanPlay"
  , canPlayThrough ∷ SProxy "onCanPlayThrough"
  , change ∷ SProxy "onChange"
  , click ∷ SProxy "onClick"
  , compositionEnd ∷ SProxy "onCompositionEnd"
  , compositionStart ∷ SProxy "onCompositionStart"
  , compositionUpdate ∷ SProxy "onCompositionUpdate"
  , contextMenu ∷ SProxy "onContextMenu"
  , copy ∷ SProxy "onCopy"
  , cut ∷ SProxy "onCut"
  , doubleClick ∷ SProxy "onDblClick"
  , drag ∷ SProxy "onDrag"
  , dragEnd ∷ SProxy "onDragEnd"
  , dragEnter ∷ SProxy "onDragEnter"
  , dragExit ∷ SProxy "onDragExit"
  , dragLeave ∷ SProxy "onDragLeave"
  , dragOver ∷ SProxy "onDragOver"
  , dragStart ∷ SProxy "onDragStart"
  , drop ∷ SProxy "onDrop"
  , durationChange ∷ SProxy "onDurationChange"
  , emptied ∷ SProxy "onEmptied"
  , encrypted ∷ SProxy "onEncrypted"
  , ended ∷ SProxy "onEnded"
  , error ∷ SProxy "onError"
  , focus ∷ SProxy "onFocus"
  , focusIn ∷ SProxy "onFocusIn"
  , focusOut ∷ SProxy "onFocusOut"
  , gotPointerCapture ∷ SProxy "onGotPointerCapture"
  , input ∷ SProxy "onInput"
  , invalid ∷ SProxy "onInvalid"
  , keyDown ∷ SProxy "onKeyDown"
  , keyPress ∷ SProxy "onKeyPress"
  , keyUp ∷ SProxy "onKeyUp"
  , load ∷ SProxy "onLoad"
  , loadStart ∷ SProxy "onLoadStart"
  , loadedData ∷ SProxy "onLoadedData"
  , loadedMetadata ∷ SProxy "onLoadedMetadata"
  , lostPointerCapture ∷ SProxy "onLostPointerCapture"
  , mouseDown ∷ SProxy "onMouseDown"
  , mouseEnter ∷ SProxy "onMouseEnter"
  , mouseLeave ∷ SProxy "onMouseLeave"
  , mouseMove ∷ SProxy "onMouseMove"
  , mouseOut ∷ SProxy "onMouseOut"
  , mouseOver ∷ SProxy "onMouseOver"
  , mouseUp ∷ SProxy "onMouseUp"
  , paste ∷ SProxy "onPaste"
  , pause ∷ SProxy "onPause"
  , play ∷ SProxy "onPlay"
  , playing ∷ SProxy "onPlaying"
  , pointerCancel ∷ SProxy "onPointerCancel"
  , pointerDown ∷ SProxy "onPointerDown"
  , pointerEnter ∷ SProxy "onPointerEnter"
  , pointerLeave ∷ SProxy "onPointerLeave"
  , pointerMove ∷ SProxy "onPointerMove"
  , pointerOut ∷ SProxy "onPointerOut"
  , pointerOver ∷ SProxy "onPointerOver"
  , pointerUp ∷ SProxy "onPointerUp"
  , progress ∷ SProxy "onProgress"
  , rateChange ∷ SProxy "onRateChange"
  , scroll ∷ SProxy "onScroll"
  , seeked ∷ SProxy "onSeeked"
  , seeking ∷ SProxy "onSeeking"
  , select ∷ SProxy "onSelect"
  , stalled ∷ SProxy "onStalled"
  , submit ∷ SProxy "onSubmit"
  , suspend ∷ SProxy "onSuspend"
  , timeUpdate ∷ SProxy "onTimeUpdate"
  , touchCancel ∷ SProxy "onTouchCancel"
  , touchEnd ∷ SProxy "onTouchEnd"
  , touchMove ∷ SProxy "onTouchMove"
  , touchStart ∷ SProxy "onTouchStart"
  , transitionEnd ∷ SProxy "onTransitionEnd"
  , volumeChange ∷ SProxy "onVolumeChange"
  , waiting ∷ SProxy "onWaiting"
  , wheel ∷ SProxy "onWheel"
  }
on =
  { copy: SProxy ∷ SProxy "onCopy"
  , cut: SProxy ∷ SProxy "onCut"
  , paste: SProxy ∷ SProxy "onPaste"
  , compositionEnd: SProxy ∷ SProxy "onCompositionEnd"
  , compositionStart: SProxy ∷ SProxy "onCompositionStart"
  , compositionUpdate: SProxy ∷ SProxy "onCompositionUpdate"
  , keyDown: SProxy ∷ SProxy "onKeyDown"
  , keyPress: SProxy ∷ SProxy "onKeyPress"
  , keyUp: SProxy ∷ SProxy "onKeyUp"
  , focus: SProxy ∷ SProxy "onFocus"
  , blur: SProxy ∷ SProxy "onBlur"
  , focusIn: SProxy ∷ SProxy "onFocusIn"
  , focusOut: SProxy ∷ SProxy "onFocusOut"
  , change: SProxy ∷ SProxy "onChange"
  , input: SProxy ∷ SProxy "onInput"
  , invalid: SProxy ∷ SProxy "onInvalid"
  , submit: SProxy ∷ SProxy "onSubmit"
  , click: SProxy ∷ SProxy "onClick"
  , contextMenu: SProxy ∷ SProxy "onContextMenu"
  , drag: SProxy ∷ SProxy "onDrag"
  , dragEnd: SProxy ∷ SProxy "onDragEnd"
  , dragEnter: SProxy ∷ SProxy "onDragEnter"
  , dragExit: SProxy ∷ SProxy "onDragExit"
  , dragLeave: SProxy ∷ SProxy "onDragLeave"
  , dragOver: SProxy ∷ SProxy "onDragOver"
  , dragStart: SProxy ∷ SProxy "onDragStart"
  , drop: SProxy ∷ SProxy "onDrop"
  , mouseDown: SProxy ∷ SProxy "onMouseDown"
  , mouseEnter: SProxy ∷ SProxy "onMouseEnter"
  , mouseLeave: SProxy ∷ SProxy "onMouseLeave"
  , mouseMove: SProxy ∷ SProxy "onMouseMove"
  , mouseOut: SProxy ∷ SProxy "onMouseOut"
  , mouseOver: SProxy ∷ SProxy "onMouseOver"
  , mouseUp: SProxy ∷ SProxy "onMouseUp"
  , select: SProxy ∷ SProxy "onSelect"
  , touchCancel: SProxy ∷ SProxy "onTouchCancel"
  , touchEnd: SProxy ∷ SProxy "onTouchEnd"
  , touchMove: SProxy ∷ SProxy "onTouchMove"
  , touchStart: SProxy ∷ SProxy "onTouchStart"
  , scroll: SProxy ∷ SProxy "onScroll"
  , wheel: SProxy ∷ SProxy "onWheel"
  , abort: SProxy ∷ SProxy "onAbort"
  , canPlay: SProxy ∷ SProxy "onCanPlay"
  , canPlayThrough: SProxy ∷ SProxy "onCanPlayThrough"
  , durationChange: SProxy ∷ SProxy "onDurationChange"
  , emptied: SProxy ∷ SProxy "onEmptied"
  , encrypted: SProxy ∷ SProxy "onEncrypted"
  , ended: SProxy ∷ SProxy "onEnded"
  , loadedData: SProxy ∷ SProxy "onLoadedData"
  , loadedMetadata: SProxy ∷ SProxy "onLoadedMetadata"
  , loadStart: SProxy ∷ SProxy "onLoadStart"
  , pause: SProxy ∷ SProxy "onPause"
  , play: SProxy ∷ SProxy "onPlay"
  , playing: SProxy ∷ SProxy "onPlaying"
  , progress: SProxy ∷ SProxy "onProgress"
  , rateChange: SProxy ∷ SProxy "onRateChange"
  , seeked: SProxy ∷ SProxy "onSeeked"
  , seeking: SProxy ∷ SProxy "onSeeking"
  , stalled: SProxy ∷ SProxy "onStalled"
  , suspend: SProxy ∷ SProxy "onSuspend"
  , timeUpdate: SProxy ∷ SProxy "onTimeUpdate"
  , volumeChange: SProxy ∷ SProxy "onVolumeChange"
  , waiting: SProxy ∷ SProxy "onWaiting"
  , load: SProxy ∷ SProxy "onLoad"
  , error: SProxy ∷ SProxy "onError"
  , animationStart: SProxy ∷ SProxy "onAnimationStart"
  , animationEnd: SProxy ∷ SProxy "onAnimationEnd"
  , animationIteration: SProxy ∷ SProxy "onAnimationIteration"
  , transitionEnd: SProxy ∷ SProxy "onTransitionEnd"
  , doubleClick: SProxy ∷ SProxy "onDblClick"
  , pointerOver: SProxy ∷ SProxy "onPointerOver"
  , pointerEnter: SProxy ∷ SProxy "onPointerEnter"
  , pointerDown: SProxy ∷ SProxy "onPointerDown"
  , pointerMove: SProxy ∷ SProxy "onPointerMove"
  , pointerUp: SProxy ∷ SProxy "onPointerUp"
  , pointerCancel: SProxy ∷ SProxy "onPointerCancel"
  , pointerOut: SProxy ∷ SProxy "onPointerOut"
  , pointerLeave: SProxy ∷ SProxy "onPointerLeave"
  , gotPointerCapture: SProxy ∷ SProxy "onGotPointerCapture"
  , lostPointerCapture: SProxy ∷ SProxy "onLostPointerCapture"
  }
