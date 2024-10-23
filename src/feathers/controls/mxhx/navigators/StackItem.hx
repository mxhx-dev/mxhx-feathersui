package feathers.controls.mxhx.navigators;

import feathers.controls.navigators.StackNavigator;
import openfl.display.DisplayObject;
import feathers.utils.AbstractDisplayObjectFactory;

@:dox(hide)
@defaultXmlProperty("viewFactory")
class StackItem extends feathers.controls.navigators.StackItem implements IMXHXNavigatorItem {
	public function new(?viewFactory:AbstractDisplayObjectFactory<Dynamic, DisplayObject>) {
		super();
		this.viewFactory = viewFactory;
	}

	/**
		If `true`, and `StackItem.viewFactory` is `null`, a fallback view will
		be created. If `false`, then no view will be created and the navigator
		will receive `null`.
	**/
	public var fallbackViewFactoryEnabled:Bool = false;

	override private function getView(navigator:StackNavigator):DisplayObject {
		var view = super.getView(navigator);
		if (view != null) {
			return view;
		}
		if (!this.fallbackViewFactoryEnabled) {
			return null;
		}
		// viewFactory isn't guaranteed to be set in MXHX, but navigators expect
		// all items to return a view when requested. in some cases, it is
		// valuable to return a fallback view, such as in editor tools.
		return new LayoutGroup();
	}
}
