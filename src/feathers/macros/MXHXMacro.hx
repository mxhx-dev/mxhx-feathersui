/*
	mxhx-feathersui
	Copyright 2024 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.macros;

#if macro
class MXHXMacro {
	public static function initialize():Void {
		#if mxhx_component
		mxhx.macros.MXHXComponent.setDataBindingCallback(createDataBindingExpression);
		mxhx.macros.MXHXComponent.setDispatchEventCallback(createDispatchEventExpression);
		mxhx.macros.MXHXComponent.setAddEventListenerCallback(createAddEventListenerExpression);
		#end
	}

	private static function createDataBindingExpression(sourceExpr:String, destExpr:String, documentExpr:String):String {
		return 'mxhx.bindable.DataBinding.bind(${sourceExpr}, ${destExpr}, ${documentExpr})';
	}

	private static function createDispatchEventExpression(dispatcherExpr:String, eventName:String):String {
		return '${dispatcherExpr}.dispatchEvent(new openfl.events.Event("${eventName}"))';
	}

	private static function createAddEventListenerExpression(dispatcherExpr:String, eventName:String, listenerExpr:String):String {
		listenerExpr = StringTools.trim(listenerExpr);
		if (~/\w+(?:\.\w+)*\(event\)/.match(listenerExpr)) {
			var modifiedListenerExpr = listenerExpr.substr(0, listenerExpr.length - 7);
			return '${dispatcherExpr}.addEventListener("${eventName}", ${modifiedListenerExpr})';
		}
		return '${dispatcherExpr}.addEventListener("${eventName}", event -> ${listenerExpr})';
	}
}
#end
