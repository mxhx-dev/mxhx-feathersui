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

	private static function createDataBindingExpression(sourceExpr:Expr, destExpr:Expr, documentExpr:Expr):Expr {
		return macro feathers.binding.DataBinding.bind($sourceExpr, $destExpr, $documentExpr);
	}

	private static function createDispatchEventExpression(dispatcherExpr:Expr, eventName:String):Expr {
		return macro $dispatcherExpr.dispatchEvent(new openfl.events.Event($v{eventName}));
	}

	private static function createAddEventListenerExpression(dispatcherExpr:Expr, eventName:String, listenerExpr:Expr):Expr {
		return macro $dispatcherExpr.addEventListener($v{eventName}, event -> $listenerExpr);
	}
}
#end

private class MXHXLookup {}
