import feathers.controls.Application;
import feathers.controls.Button;
import feathers.controls.TextCallout;
import feathers.events.TriggerEvent;
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
	}

	public function button_triggerHandler(event:TriggerEvent):Void {
		var button = cast(event.currentTarget, Button);
		TextCallout.show("Hello World", button);
	}
}
