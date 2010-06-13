/**
 * WindowedPanel.as
 * 
 * @author Cristobal Dabed
 * @version 0.1
 */ 
import flash.desktop.NativeApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.core.Application;
import mx.core.FlexGlobals;
import mx.events.CloseEvent;


private static var panelBarHeight:uint = 25;
private static var panelBarDraggableOffset:uint = 1;


private var timerDelay:uint = 25;
private var _moving:Boolean = false;

/**
 * Init component
 */ 
private function initComponent():void {
	addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	addEventListener(CloseEvent.CLOSE, onClose);
	
	addEventListener(Event.ENTER_FRAME, onEnterFrame);

	setupDroppable();
	setupProcess();
}

/** 
 * @readonly moving
 */ 
public function get moving():Boolean {
	return _moving;
}

/**
 * Start move
 */ 
public function startMove():void {
	if(moving){
		stopMove();
	}
	_moving = true;
	NativeApplication.nativeApplication.activeWindow.startMove();
}

/**
 * Stop move
 */ 
public function stopMove():void {
	_moving = false;
}


/**
 * On enter frame
 * 
 * @param event	The event
 */ 
private function onEnterFrame(event:Event):void {
	x = 0;
	y = 0;
	if(NativeApplication.nativeApplication.activeWindow){
		if(NativeApplication.nativeApplication.activeWindow.width < width){
		NativeApplication.nativeApplication.activeWindow.width = width;
		}
	}
}

/**
 * On mouse down
 * 
 * @param event	The mouse event
 */ 
private function onMouseDown(event:MouseEvent):void {
	if(moving){
		return;
	}
	
	/**
	 * Only trigger startMove if the selected point is in the bound of the panel title bar.
	 */ 
	if((event.localY < panelBarHeight) && (event.localY > panelBarDraggableOffset) && (event.localX < width - panelBarDraggableOffset) && (event.localX > panelBarDraggableOffset)){
		startMove();
	}
}

/**
 * On mouse up
 * 
 * @param event The mouse event
 */ 
private function onMouseUp(event:MouseEvent):void {
	stopMove();
}

/**
 * On close
 */ 
private function onClose(event:CloseEvent):void {
	FlexGlobals.topLevelApplication.close();
}