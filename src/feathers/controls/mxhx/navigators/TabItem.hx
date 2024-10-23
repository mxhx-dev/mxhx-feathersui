package feathers.controls.mxhx.navigators;

import feathers.controls.navigators.TabNavigator;
import openfl.display.DisplayObject;
import feathers.utils.AbstractDisplayObjectFactory;

@:dox(hide)
@defaultXmlProperty("viewFactory")
class TabItem extends feathers.controls.navigators.TabItem implements IMXHXNavigatorItem {
	public function new(?viewFactory:AbstractDisplayObjectFactory<Dynamic, DisplayObject>) {
		super();
		this.viewFactory = viewFactory;
	}

	/**
		If `true`, and `TabItem.viewFactory` is `null`, a fallback view will
		be created. If `false`, then no view will be created and the navigator
		will receive `null`.
	**/
	public var fallbackViewFactoryEnabled:Bool = false;

	override private function getView(navigator:TabNavigator):DisplayObject {
		if (this.viewFactory == null && this.fallbackViewFactoryEnabled) {
			// viewFactory isn't guaranteed to be set in MXHX, but navigators expect
			// all items to return a view when requested. in some cases, it is
			// valuable to return a fallback view, such as in editor tools.
			return new LayoutGroup();
		}
		return super.getView(navigator);
	}

	override private function returnView(view:DisplayObject):Void {
		if (this.viewFactory == null && this.fallbackViewFactoryEnabled) {
			return;
		}
		super.returnView(view);
	}
}
