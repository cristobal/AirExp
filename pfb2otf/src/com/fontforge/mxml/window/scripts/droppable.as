/**
 * Droppable.as
 * 
 * @author Cristobal Dabed
 * @version 0.1
 * 
 * Resources:
 * 	- http://tech.groups.yahoo.com/group/flexcoders/message/103296
 *  - http://forums.adobe.com/message/114426
 */
import flash.filesystem.File;

import mx.core.DragSource;
import mx.core.IUIComponent;
import mx.events.DragEvent;
import mx.managers.DragManager;

private static var format:String = "air:file list";

/**
 * Setup droppable
 */ 
private function setupDroppable():void {
	droppable.addEventListener(DragEvent.DRAG_ENTER, onDragEnter);
	droppable.addEventListener(DragEvent.DRAG_DROP, onDragDrop);
}

/**
 * On drag enter
 * 
 * @param event	The drag event
 */ 
private function onDragEnter(event:DragEvent):void {
	if(processing){
		return; // files already in process wait.
	}
	DragManager.acceptDragDrop(droppable as IUIComponent); // DragManager.acceptDragDrop() must be called otherwise the other drag events like dragDrop won’t fire.
}

/**
 * On drag drop
 * 
 * @param event	The drag event
 */ 
private function onDragDrop(event:DragEvent):void {
	var dragSource:DragSource = event.dragSource;
	var property:String;
	
	if(dragSource.hasFormat(format)){
		var files:Array = (dragSource.dataForFormat(format) as Array);
		process(files);
	}
}