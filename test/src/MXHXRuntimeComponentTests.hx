import feathers.controls.Application;
import feathers.controls.Button;
import feathers.controls.HDividedBox;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.VDividedBox;
import mxhx.runtime.MXHXRuntimeComponent;
import utest.Assert;
import utest.Test;

class MXHXRuntimeComponentTests extends Test {
	public function testMXHXRuntimeComponent_Application():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
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
		', {
				idMap: idMap
			});
		Assert.isOfType(result, Application);
		var app = cast(result, Application);
		Assert.notNull(app);

		Assert.equals(123.4, idMap.get("float"));
		Assert.equals(5678, idMap.get("integer"));
		Assert.isTrue(idMap.get("boolean"));
		Assert.equals("hello", idMap.get("string"));

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(app, button.parent);

		Assert.equals(1, app.numChildren);
		var child = app.getChildAt(0);
		Assert.equals(button, child);
	}

	public function testMXHXRuntimeComponent_LayoutGroupChildren():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
			<f:LayoutGroup xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:LayoutGroup>
		', {
				idMap: idMap
			});
		Assert.isOfType(result, LayoutGroup);
		var group = cast(result, LayoutGroup);
		Assert.notNull(group);

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(group, button.parent);

		Assert.isOfType(idMap.get("label"), Label);
		var label = cast(idMap.get("label"), Label);
		Assert.notNull(label);
		Assert.equals("hello", label.text);
		Assert.equals(group, label.parent);

		Assert.equals(2, group.numChildren);
		var child0 = group.getChildAt(0);
		Assert.equals(button, child0);
		var child1 = group.getChildAt(1);
		Assert.equals(label, child1);
	}

	public function testMXHXRuntimeComponent_ScrollContainerChildren():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
			<f:ScrollContainer xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:ScrollContainer>
		', {
				idMap: idMap
			});
		Assert.isOfType(result, ScrollContainer);
		var scrollContainer = cast(result, ScrollContainer);
		Assert.notNull(scrollContainer);

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(scrollContainer, button.parent.parent);

		Assert.isOfType(idMap.get("label"), Label);
		var label = cast(idMap.get("label"), Label);
		Assert.notNull(label);
		Assert.equals("hello", label.text);
		// children are added to the view port,
		// so the ScrollContainer isn't a direct parent
		Assert.equals(scrollContainer, label.parent.parent);

		Assert.equals(2, scrollContainer.numChildren);
		var child0 = scrollContainer.getChildAt(0);
		Assert.equals(button, child0);
		var child1 = scrollContainer.getChildAt(1);
		Assert.equals(label, child1);
	}

	public function testMXHXRuntimeComponent_PanelChildren():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
			<f:Panel xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:Panel>
		', {
				idMap: idMap
			});
		Assert.isOfType(result, Panel);
		var panel = cast(result, Panel);
		Assert.notNull(panel);

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(panel, button.parent.parent);

		Assert.isOfType(idMap.get("label"), Label);
		var label = cast(idMap.get("label"), Label);
		Assert.notNull(label);
		Assert.equals("hello", label.text);
		// children are added to the view port,
		// so the Panel isn't a direct parent
		Assert.equals(panel, label.parent.parent);

		Assert.equals(2, panel.numChildren);
		var child0 = panel.getChildAt(0);
		Assert.equals(button, child0);
		var child1 = panel.getChildAt(1);
		Assert.equals(label, child1);
	}

	public function testMXHXRuntimeComponent_HDividedBoxChildren():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
			<f:HDividedBox xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:HDividedBox>
		', {
				idMap: idMap
			});
		Assert.isOfType(result, HDividedBox);
		var dividedBox = cast(result, HDividedBox);
		Assert.notNull(dividedBox);

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(dividedBox, button.parent);

		Assert.isOfType(idMap.get("label"), Label);
		var label = cast(idMap.get("label"), Label);
		Assert.notNull(label);
		Assert.equals("hello", label.text);
		Assert.equals(dividedBox, label.parent);

		Assert.equals(2, dividedBox.numChildren);
		var child0 = dividedBox.getChildAt(0);
		Assert.equals(button, child0);
		var child1 = dividedBox.getChildAt(1);
		Assert.equals(label, child1);
	}

	public function testMXHXRuntimeComponent_VDividedBoxChildren():Void {
		var idMap:Map<String, Any> = [];
		var result = MXHXRuntimeComponent.withMarkup('
			<f:VDividedBox xmlns:mx="https://ns.mxhx.dev/2024/basic"
				xmlns:f="https://ns.feathersui.com/mxhx">
				<f:Button id="button" text="hi"/>
				<f:Label id="label" text="hello"/>
			</f:VDividedBox>
		', {
				idMap: idMap
			});
		Assert.isOfType(result, VDividedBox);
		var dividedBox = cast(result, VDividedBox);
		Assert.notNull(dividedBox);

		Assert.isOfType(idMap.get("button"), Button);
		var button = cast(idMap.get("button"), Button);
		Assert.notNull(button);
		Assert.equals("hi", button.text);
		Assert.equals(dividedBox, button.parent);

		Assert.isOfType(idMap.get("label"), Label);
		var label = cast(idMap.get("label"), Label);
		Assert.notNull(label);
		Assert.equals("hello", label.text);
		Assert.equals(dividedBox, label.parent);

		Assert.equals(2, dividedBox.numChildren);
		var child0 = dividedBox.getChildAt(0);
		Assert.equals(button, child0);
		var child1 = dividedBox.getChildAt(1);
		Assert.equals(label, child1);
	}
}
