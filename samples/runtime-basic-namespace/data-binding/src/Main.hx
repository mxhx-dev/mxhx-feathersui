import feathers.controls.Label;
import feathers.controls.HSlider;
import feathers.controls.LayoutGroup;
import feathers.controls.Application;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import mxhx.bindable.DataBinding;
import mxhx.runtime.MXHXRuntimeComponent;

class Main extends Application {
	public function new() {
		super();

		layout = new AnchorLayout();

		var idMap:Map<String, Any> = [];
		var content = cast(MXHXRuntimeComponent.withMarkup('
			<f:LayoutGroup xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:layout>
					<f:VerticalLayout horizontalAlign="CENTER" verticalAlign="MIDDLE"/>
				</f:layout>
				<f:HSlider id="slider" value="0" minimum="0" maximum="10" snapInterval="1"/>
				<f:Label id="label"/>
			</f:LayoutGroup>
		', {
				idMap: idMap
			}), LayoutGroup);
		content.layoutData = AnchorLayoutData.fill();
		addChild(content);

		var slider = cast(idMap.get("slider"), HSlider);
		var label = cast(idMap.get("label"), Label);
		DataBinding.bind(Std.string(slider.value), label.text, this);
	}
}
