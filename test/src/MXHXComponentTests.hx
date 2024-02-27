import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import mxhx.macros.MXHXComponent;
import utest.Assert;
import utest.Test;

class MXHXComponentTests extends Test {
	public function testMXHXComponent():Void {
		var result = MXHXComponent.withMarkup('
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
		');
		Assert.notNull(result);
		Assert.isOfType(result, LayoutGroup);

		Assert.equals(123.4, result.float);
		Assert.equals(5678, result.integer);
		Assert.isTrue(result.boolean);
		Assert.equals("hello", result.string);

		Assert.notNull(result.button);
		Assert.isOfType(result.button, Button);
		Assert.equals("hi", result.button.text);
		Assert.equals(result, result.button.parent);

		Assert.equals(1, result.numChildren);
		var child = result.getChildAt(0);
		Assert.equals(result.button, child);
	}
}
