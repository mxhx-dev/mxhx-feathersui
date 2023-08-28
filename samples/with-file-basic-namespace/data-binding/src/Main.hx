import mxhx.bindable.DataBinding;
import feathers.controls.Application;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import mxhx.macros.MXHXComponent;

class Main extends Application {
	public function new() {
		super();
	}

	override private function initialize():Void {
		super.initialize();

		layout = new AnchorLayout();

		var content = MXHXComponent.withFile("Main.mxhx");
		content.layoutData = AnchorLayoutData.fill();
		addChild(content);

		DataBinding.bind(Std.string(content.slider.value), content.label.text, this);
	}
}
