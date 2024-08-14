import feathers.controls.Application;
import feathers.controls.Button;
import feathers.controls.HDividedBox;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.VDividedBox;
import mxhx.macros.MXHXComponent;
import utest.Assert;
import utest.Test;

class MXHXComponentTests extends Test {
	public function testMXHXComponent_Application():Void {
		var result = MXHXComponent.withMarkup('
			<f:Application xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<mx:Declarations>
					<mx:Float id="float">123.4</mx:Float>
					<mx:Int id="integer">5678</mx:Int>
					<mx:Bool id="boolean">true</mx:Bool>
					<mx:String id="string">hello</mx:String>
				</mx:Declarations>
				<f:Button id="button" text="hi"/>
			</f:Application>
		');
		Assert.notNull(result);
		Assert.isOfType(result, Application);

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

	public function testMXHXComponent_LayoutGroupChildren():Void {
		var result = MXHXComponent.withMarkup('
			<f:LayoutGroup xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:LayoutGroup>
		');
		Assert.notNull(result);
		Assert.isOfType(result, LayoutGroup);

		Assert.notNull(result.button);
		Assert.isOfType(result.button, Button);
		Assert.equals("hi", result.button.text);
		Assert.equals(result, result.button.parent);

		Assert.notNull(result.label);
		Assert.isOfType(result.label, Label);
		Assert.equals("hello", result.label.text);
		Assert.equals(result, result.label.parent);

		Assert.equals(2, result.numChildren);
		var child0 = result.getChildAt(0);
		Assert.equals(result.button, child0);
		var child1 = result.getChildAt(1);
		Assert.equals(result.label, child1);
	}

	public function testMXHXComponent_ScrollContainerChildren():Void {
		var result = MXHXComponent.withMarkup('
			<f:ScrollContainer xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:ScrollContainer>
		');
		Assert.notNull(result);
		Assert.isOfType(result, ScrollContainer);

		Assert.notNull(result.button);
		Assert.isOfType(result.button, Button);
		Assert.equals("hi", result.button.text);
		Assert.equals(result, result.button.parent.parent);

		Assert.notNull(result.label);
		Assert.isOfType(result.label, Label);
		Assert.equals("hello", result.label.text);
		// children are added to the view port,
		// so the ScrollContainer isn't a direct parent
		Assert.equals(result, result.label.parent.parent);

		Assert.equals(2, result.numChildren);
		var child0 = result.getChildAt(0);
		Assert.equals(result.button, child0);
		var child1 = result.getChildAt(1);
		Assert.equals(result.label, child1);
	}

	public function testMXHXComponent_PanelChildren():Void {
		var result = MXHXComponent.withMarkup('
			<f:Panel xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:Panel>
		');
		Assert.notNull(result);
		Assert.isOfType(result, Panel);

		Assert.notNull(result.button);
		Assert.isOfType(result.button, Button);
		Assert.equals("hi", result.button.text);
		Assert.equals(result, result.button.parent.parent);

		Assert.notNull(result.label);
		Assert.isOfType(result.label, Label);
		Assert.equals("hello", result.label.text);
		// children are added to the view port,
		// so the Panel isn't a direct parent
		Assert.equals(result, result.label.parent.parent);

		Assert.equals(2, result.numChildren);
		var child0 = result.getChildAt(0);
		Assert.equals(result.button, child0);
		var child1 = result.getChildAt(1);
		Assert.equals(result.label, child1);
	}

	public function testMXHXComponent_HDividedBoxChildren():Void {
		var result = MXHXComponent.withMarkup('
			<f:HDividedBox xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:HDividedBox>
		');
		Assert.notNull(result);
		Assert.isOfType(result, HDividedBox);

		Assert.notNull(result.button);
		Assert.isOfType(result.button, Button);
		Assert.equals("hi", result.button.text);
		Assert.equals(result, result.button.parent);

		Assert.notNull(result.label);
		Assert.isOfType(result.label, Label);
		Assert.equals("hello", result.label.text);
		Assert.equals(result, result.label.parent);

		Assert.equals(2, result.numChildren);
		var child0 = result.getChildAt(0);
		Assert.equals(result.button, child0);
		var child1 = result.getChildAt(1);
		Assert.equals(result.label, child1);
	}

	public function testMXHXComponent_VDividedBoxChildren():Void {
		var result = MXHXComponent.withMarkup('
			<f:VDividedBox xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:VDividedBox>
		');
		Assert.notNull(result);
		Assert.isOfType(result, VDividedBox);

		Assert.notNull(result.button);
		Assert.isOfType(result.button, Button);
		Assert.equals("hi", result.button.text);
		Assert.equals(result, result.button.parent);

		Assert.notNull(result.label);
		Assert.isOfType(result.label, Label);
		Assert.equals("hello", result.label.text);
		Assert.equals(result, result.label.parent);

		Assert.equals(2, result.numChildren);
		var child0 = result.getChildAt(0);
		Assert.equals(result.button, child0);
		var child1 = result.getChildAt(1);
		Assert.equals(result.label, child1);
	}

	public function testMXHXComponent_ListViewItemToText():Void {
		var result = MXHXComponent.withMarkup('
			<f:ListView xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:itemToText>
					<mx:MapToCallback property="title"/>
				</f:itemToText>
				<f:ArrayCollection>
					<mx:Struct id="one" title="One"/>
					<mx:Struct id="two" title="Two"/>
					<mx:Struct id="three" title="Three"/>
				</f:ArrayCollection>
			</f:ListView>
		');
		Assert.notNull(result);
		Assert.isOfType(result, ListView);

		Assert.notNull(result.itemToText);
		Assert.isTrue(Reflect.isFunction(result.itemToText));
		Assert.equals("My Title", result.itemToText({title: "My Title"}));

		Assert.notNull(result.two);
		var itemState = result.itemToItemState(result.two);
		Assert.notNull(itemState);
		Assert.equals("Two", itemState.text);
	}
}
