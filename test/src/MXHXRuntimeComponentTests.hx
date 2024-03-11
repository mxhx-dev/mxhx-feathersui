import mxhx.runtime.MXHXRuntimeComponent;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import utest.Assert;
import utest.Test;

class MXHXRuntimeComponentTests extends Test {
	public function testMXHXComponent():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
			<f:LayoutGroup xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<mx:Declarations>
					<mx:Float id="float">123.4</mx:Float>
					<mx:Int id="integer">5678</mx:Int>
					<mx:Bool id="boolean">true</mx:Bool>
					<mx:String id="string">hello</mx:String>
				</mx:Declarations>
				<f:Button id="button" text="hi"/>
			</f:LayoutGroup>
		', {
				idMap: idMap
			});
		Assert.isOfType(result, LayoutGroup);
		var group = cast(result, LayoutGroup);
		Assert.notNull(group);

		Assert.equals(123.4, idMap.get("float"));
		Assert.equals(5678, idMap.get("integer"));
		Assert.isTrue(idMap.get("boolean"));
		Assert.equals("hello", idMap.get("string"));

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(result, button.parent);

		Assert.equals(1, group.numChildren);
		var child = group.getChildAt(0);
		Assert.equals(button, child);
	}
}
