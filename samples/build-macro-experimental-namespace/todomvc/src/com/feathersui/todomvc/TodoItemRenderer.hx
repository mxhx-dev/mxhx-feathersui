package com.feathersui.todomvc;

import feathers.controls.Button;
import feathers.controls.Check;
import feathers.controls.TextInput;
import feathers.controls.dataRenderers.ItemRenderer;
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
class TodoItemRenderer extends ItemRenderer {
	public static final EVENT_TEXT_CHANGE = "textChange";
	public static final EVENT_COMPLETED_CHANGE = "completedChange";
	public static final EVENT_DELETE_ITEM = "deleteItem";
	public static final CHILD_VARIANT_DELETE_BUTTON = "todoItemRenderer_deleteButton";

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

	override private function initialize():Void {
		super.initialize();

		this.textField.doubleClickEnabled = true;
		this.textField.addEventListener(MouseEvent.DOUBLE_CLICK, textField_doubleClickHandler);

		this.completedCheck.addEventListener(Event.CHANGE, completedCheck_changeHandler);

		this.deleteButton.addEventListener(TriggerEvent.TRIGGER, deleteButton_triggerHandler);

		this.addChild(this.editingTextInput);
		this.editingTextInput.addEventListener(FocusEvent.FOCUS_OUT, editingTextInput_focusOutHandler);
		this.editingTextInput.addEventListener(KeyboardEvent.KEY_DOWN, editingTextInput_keyDownHandler);
	}

	override private function layoutChildren():Void {
		super.layoutChildren();

		this.editingTextInput.x = this.textField.x;
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
		this.accessoryView = this.deleteButton;
	}

	private function todoItemRenderer_rollOutHandler(event:MouseEvent):Void {
		this.accessoryView = null;
	}

	private function textField_doubleClickHandler(event:MouseEvent):Void {
		this.accessoryView = null;
		this.editingTextInput.text = this.text;
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
