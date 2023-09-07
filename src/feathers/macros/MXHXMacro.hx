/*
	Feathers UI
	Copyright 2022 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.macros;

#if macro
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;

class MXHXMacro {
	private static final NS_URI = "https://ns.feathersui.com/mxhx";
	private static final MANIFEST_FILE_NAME = "mxhx-manifest.xml";

	public static function initialize():Void {
		var libraryPath = getLibraryPath();
		if (libraryPath == null) {
			return;
		}
		var manifestPath = Path.join([libraryPath, MANIFEST_FILE_NAME]);
		mxhx.macros.MXHXComponent.registerManifest(NS_URI, manifestPath);
		mxhx.macros.MXHXComponent.setDataBindingCallback(createDataBindingExpression);
		mxhx.macros.MXHXComponent.setDispatchEventCallback(createDispatchEventExpression);
		mxhx.macros.MXHXComponent.setAddEventListenerCallback(createAddEventListenerExpression);
	}

	private static function getLibraryPath():String {
		var t = Context.getModule("feathers.macros.MXHXMacro");
		var filePath:String = null;
		switch (t[0]) {
			case TInst(t, params):
				filePath = Context.getPosInfos(t.get().pos).file;
			default:
				return null;
		}
		return Path.join([Path.directory(filePath), "..", "..", ".."]);
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

private class MXHXLookup {}
