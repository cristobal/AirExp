import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.events.ProgressEvent;
import flash.filesystem.File;
import flash.system.Capabilities;

private var _processing:Boolean = false;
private var nativeProcessStartupInfo:NativeProcessStartupInfo;
private var nativeProcess:NativeProcess;
private var applicationPath:String;
private function setupProcess():void{
	var file:File = File.applicationDirectory.resolvePath("Contents");
	var os:String = Capabilities.os;
	if(/linux/i.test(os)){
		file = file.resolvePath("Linux/pfb2otf");
	}else if(/mac/i.test(os)){
		file = file.resolvePath("Mac OS/pfb2otf");
	}else if(/windows/i.test(os)){
		// TODO: add window code here	
	}
	
	if(file){
		applicationPath = file.nativePath.substring(0, file.nativePath.length - "/pfb2otf".length).split(" ").join("\\ ");
		trace(applicationPath);
		nativeProcessStartupInfo = new NativeProcessStartupInfo();
		nativeProcessStartupInfo.executable = file;
		
		nativeProcess = new NativeProcess();
		nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onStandardOutputData);
	}
}

/**
 * @readonly processing
 */ 
private function get processing():Boolean {
	return _processing;
}

/**
 * Process
 * 
 * @param files Array of files/directories to process
 */ 
private function process(files:Array):void {
	if(processing){
		return;
	}
	_processing = true;
	//  trace("sending for process...");
	var arguments:Vector.<String> = new Vector.<String>();
	arguments.push(applicationPath);
	
	for each(var file:File in files){
		arguments.push(file.nativePath);
	}
	nativeProcessStartupInfo.arguments = arguments;
	nativeProcess.start(nativeProcessStartupInfo);
}

/**
 * On Standard Output data
 * 
 * @param event The progress event
 */ 
private function onStandardOutputData(event:ProgressEvent):void {
	_processing = false;
}
