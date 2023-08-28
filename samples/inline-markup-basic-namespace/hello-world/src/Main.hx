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

		var content = MXHXComponent.withMarkup('
			<f:LayoutGroup xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:layout>
					<f:AnchorLayout/>
				</f:layout>
				<f:Button id="button" text="Click Me">
					<f:layoutData>
						<f:AnchorLayoutData horizontalCenter="0" verticalCenter="0"/>
					</f:layoutData>
				</f:Button>
			</f:LayoutGroup>
		');
		content.layoutData = AnchorLayoutData.fill();
		addChild(content);

		// defined with id="button"
		content.button.addEventListener(TriggerEvent.TRIGGER, button_triggerHandler);
	}

	private function button_triggerHandler(event:TriggerEvent):Void {
		var button = cast(event.currentTarget, Button);
		TextCallout.show("Hello World", button);
	}
}
