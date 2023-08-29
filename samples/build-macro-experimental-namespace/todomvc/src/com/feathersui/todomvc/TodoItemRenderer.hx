package com.feathersui.todomvc;

import feathers.controls.Button;
import feathers.controls.Check;
import feathers.controls.TextInput;
import feathers.controls.dataRenderers.LayoutGroupItemRenderer;
import feathers.events.TriggerEvent;
import openfl.events.Event;
import openfl.events.FocusEvent;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;
import com.feathersui.todomvc.vo.TodoItem;

@:event("completedChange")
@:event("deleteItem")
@:build(mxhx.macros.MXHXComponent.build())
class TodoItemRenderer extends LayoutGroupItemRenderer {
	public static final EVENT_TEXT_CHANGE = "textChange";
	public static final EVENT_COMPLETED_CHANGE = "completedChange";
	public static final EVENT_DELETE_ITEM = "deleteItem";
	public static final CHILD_VARIANT_DELETE_BUTTON = "todoItemRenderer_deleteButton";
	public static final CHILD_VARIANT_LABEL = "todoItemRenderer_label";

	public function new() {
		super();
		this.addEventListener(MouseEvent.ROLL_OVER, todoItemRenderer_rollOverHandler);
		this.addEventListener(MouseEvent.ROLL_OUT, todoItemRenderer_rollOutHandler);
	}

	private var completedCheck:Check;
	private var deleteButton:Button;
	private var editingTextInput:TextInput;

	public var completed(get, never):Bool;

	private function get_completed():Bool {
		var todoItem = cast(data, TodoItem);
		if (todoItem == null) {
			return false;
		}
		return todoItem.completed;
	}

	override private function update():Void {
		super.update();

		this.editingTextInput.x = this.label.x;
		this.editingTextInput.y = 0.0;
		this.editingTextInput.width = this.actualWidth - this.editingTextInput.x;
		this.editingTextInput.height = this.actualHeight;
	}

	private function commitUserChanges():Void {
		var todoItem = cast(data, TodoItem);
		todoItem.text = this.editingTextInput.text;
		this.cancelUserChanges();
		// since todoItem.text isn't bindable, we dispatch an event so that
		// updateAt() can be called on the dataProvider
		this.dispatchEvent(new Event(EVENT_TEXT_CHANGE));
	}

	private function cancelUserChanges():Void {
		this.editingTextInput.visible = false;
		this.editingTextInput.text = "";
	}

	private function completedCheck_changeHandler(event:Event):Void {
		var todoItem = cast(data, TodoItem);
		if (this.completedCheck.selected == todoItem.completed) {
			return;
		}
		todoItem.completed = this.completedCheck.selected;
		this.dispatchEvent(new Event(EVENT_COMPLETED_CHANGE));
	}

	private function deleteButton_triggerHandler(event:TriggerEvent):Void {
		this.dispatchEvent(new Event(EVENT_DELETE_ITEM));
	}

	private function todoItemRenderer_rollOverHandler(event:MouseEvent):Void {
		if (this.editingTextInput.visible) {
			return;
		}
		this.deleteButton.visible = true;
		this.deleteButton.includeInLayout = true;
	}

	private function todoItemRenderer_rollOutHandler(event:MouseEvent):Void {
		this.deleteButton.visible = false;
		this.deleteButton.includeInLayout = false;
	}

	private function label_doubleClickHandler(event:MouseEvent):Void {
		this.deleteButton.visible = false;
		this.deleteButton.includeInLayout = false;

		this.editingTextInput.text = this.data.text;
		this.editingTextInput.visible = true;
		this.focusManager.focus = this.editingTextInput;
		this.editingTextInput.selectAll();
	}

	private function editingTextInput_focusOutHandler(event:FocusEvent):Void {
		if (!this.editingTextInput.visible) {
			return;
		}
		this.commitUserChanges();
	}

	private function editingTextInput_keyDownHandler(event:KeyboardEvent):Void {
		if (event.isDefaultPrevented()) {
			return;
		}
		switch (event.keyCode) {
			case Keyboard.ENTER:
				this.commitUserChanges();
			case Keyboard.ESCAPE:
				this.cancelUserChanges();
		}
	}
}
