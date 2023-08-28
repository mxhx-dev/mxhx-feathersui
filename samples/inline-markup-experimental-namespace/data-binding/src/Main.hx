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

		var content = MXHXComponent.withMarkup('
			<f:LayoutGroup xmlns:mx="https://ns.mxhx.dev/2024/mxhx"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:layout>
					<f:VerticalLayout horizontalAlign="CENTER" verticalAlign="MIDDLE"/>
				</f:layout>
				<f:HSlider id="slider" value="0" minimum="0" maximum="10" snapInterval="1"/>
				<f:Label text="{Std.string(slider.value)}"/>
			</f:LayoutGroup>
		');
		content.layoutData = AnchorLayoutData.fill();
		addChild(content);
	}
}
