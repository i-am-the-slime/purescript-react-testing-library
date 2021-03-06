"use strict";

// We're not using jest or any other compatible framework
require("@testing-library/react/dont-cleanup-after-each");
// So that we have a "document"
require("jsdom-global")(undefined, { url: "https://purescript.org", pretendToBeVisual: true });
var T = require("@testing-library/react/pure");
var UE = require("@testing-library/user-event");

T.configure({ defaultHidden: true });
exports.cleanupImpl = T.cleanup;

exports.renderImpl = T.render;

exports.findByTextImpl = T.findByText;

exports.queryImpl = just => nothing => query => elem => {
  let result = query(elem);
  return result === null ? nothing : just(result);
};

exports.fireEventImpl = T.fireEvent;
exports.fireEventCopyImpl = T.fireEvent.copy;
exports.fireEventCutImpl = T.fireEvent.cut;
exports.fireEventPasteImpl = T.fireEvent.paste;
exports.fireEventCompositionEndImpl = T.fireEvent.compositionEnd;
exports.fireEventCompositionStartImpl = T.fireEvent.compositionStart;
exports.fireEventCompositionUpdateImpl = T.fireEvent.compositionUpdate;
exports.fireEventKeyDownImpl = T.fireEvent.keyDown;
exports.fireEventKeyUpImpl = T.fireEvent.keyUp;
exports.fireEventKeyPressImpl = T.fireEvent.keyPress;
exports.fireEventFocusImpl = T.fireEvent.focus;
exports.fireEventBlurImpl = T.fireEvent.blur;
exports.fireEventFocusInImpl = T.fireEvent.focusIn;
exports.fireEventFocusOutImpl = T.fireEvent.focusOut;
exports.fireEventChangeImpl = T.fireEvent.change;
exports.fireEventInputImpl = T.fireEvent.input;
exports.fireEventInvalidImpl = T.fireEvent.invalid;
exports.fireEventSubmitImpl = T.fireEvent.submit;
exports.fireEventClickImpl = T.fireEvent.click;
exports.fireEventContextMenuImpl = T.fireEvent.contextMenu;
exports.fireEventDblClickImpl = T.fireEvent.dblClick;
exports.fireEventDragImpl = T.fireEvent.drag;
exports.fireEventDragEndImpl = T.fireEvent.dragEnd;
exports.fireEventDragEnterImpl = T.fireEvent.dragEnter;
exports.fireEventDragExitImpl = T.fireEvent.dragExit;
exports.fireEventDragLeaveImpl = T.fireEvent.dragLeave;
exports.fireEventDragOverImpl = T.fireEvent.dragOver;
exports.fireEventDragStartImpl = T.fireEvent.dragStart;
exports.fireEventDropImpl = T.fireEvent.drop;
exports.fireEventMouseDownImpl = T.fireEvent.mouseDown;
exports.fireEventMouseEnterImpl = T.fireEvent.mouseEnter;
exports.fireEventMouseLeaveImpl = T.fireEvent.mouseLeave;
exports.fireEventMouseMoveImpl = T.fireEvent.mouseMove;
exports.fireEventMouseOutImpl = T.fireEvent.mouseOut;
exports.fireEventMouseOverImpl = T.fireEvent.mouseOver;
exports.fireEventMouseUpImpl = T.fireEvent.mouseUp;
exports.fireEventSelectImpl = T.fireEvent.select;
exports.fireEventTouchCancelImpl = T.fireEvent.touchCancel;
exports.fireEventTouchEndImpl = T.fireEvent.touchEnd;
exports.fireEventTouchMoveImpl = T.fireEvent.touchMove;
exports.fireEventTouchStartImpl = T.fireEvent.touchStart;
exports.fireEventScrollImpl = T.fireEvent.scroll;
exports.fireEventWheelImpl = T.fireEvent.wheel;
exports.fireEventAbortImpl = T.fireEvent.abort;
exports.fireEventCanPlayImpl = T.fireEvent.canPlay;
exports.fireEventCanPlayThroughImpl = T.fireEvent.canPlayThrough;
exports.fireEventDurationChangeImpl = T.fireEvent.durationChange;
exports.fireEventEmptiedImpl = T.fireEvent.emptied;
exports.fireEventEncryptedImpl = T.fireEvent.encrypted;
exports.fireEventEndedImpl = T.fireEvent.ended;
exports.fireEventLoadedDataImpl = T.fireEvent.loadedData;
exports.fireEventLoadedMetadataImpl = T.fireEvent.loadedMetadata;
exports.fireEventLoadStartImpl = T.fireEvent.loadStart;
exports.fireEventPauseImpl = T.fireEvent.pause;
exports.fireEventPlayImpl = T.fireEvent.play;
exports.fireEventPlayingImpl = T.fireEvent.playing;
exports.fireEventProgressImpl = T.fireEvent.progress;
exports.fireEventRateChangeImpl = T.fireEvent.rateChange;
exports.fireEventSeekedImpl = T.fireEvent.seeked;
exports.fireEventSeekingImpl = T.fireEvent.seeking;
exports.fireEventStalledImpl = T.fireEvent.stalled;
exports.fireEventSuspendImpl = T.fireEvent.suspend;
exports.fireEventTimeUpdateImpl = T.fireEvent.timeUpdate;
exports.fireEventVolumeChangeImpl = T.fireEvent.volumeChange;
exports.fireEventWaitingImpl = T.fireEvent.waiting;
exports.fireEventLoadImpl = T.fireEvent.load;
exports.fireEventErrorImpl = T.fireEvent.error;
exports.fireEventAnimationStartImpl = T.fireEvent.animationStart;
exports.fireEventAnimationEndImpl = T.fireEvent.animationEnd;
exports.fireEventAnimationIterationImpl = T.fireEvent.animationIteration;
exports.fireEventTransitionEndImpl = T.fireEvent.transitionEnd;
exports.fireEventDoubleClickImpl = T.fireEvent.doubleClick;
exports.fireEventPointerOverImpl = T.fireEvent.pointerOver;
exports.fireEventPointerEnterImpl = T.fireEvent.pointerEnter;
exports.fireEventPointerDownImpl = T.fireEvent.pointerDown;
exports.fireEventPointerMoveImpl = T.fireEvent.pointerMove;
exports.fireEventPointerUpImpl = T.fireEvent.pointerUp;
exports.fireEventPointerCancelImpl = T.fireEvent.pointerCancel;
exports.fireEventPointerOutImpl = T.fireEvent.pointerOut;
exports.fireEventPointerLeaveImpl = T.fireEvent.pointerLeave;
exports.fireEventGotPointerCaptureImpl = T.fireEvent.gotPointerCapture;
exports.fireEventLostPointerCaptureImpl = T.fireEvent.lostPointerCapture;

exports.typeImpl = UE.default.type;
