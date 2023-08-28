import feathers.controls.Application;
import feathers.controls.TextCallout;
import feathers.events.TriggerEvent;

@:build(mxhx.macros.MXHXComponent.build())
class Main extends Application {
	public function new() {
		super();
	}

	private function button_triggerHandler(event:TriggerEvent):Void {
		TextCallout.show("Hello World", this.button);
	}
}
