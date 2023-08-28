package com.feathersui.todomvc;

import feathers.controls.Application;
import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.TabBar;
import feathers.controls.TextInput;
import feathers.controls.ToggleButton;
import feathers.data.ArrayCollection;
import feathers.data.ListViewItemState;
import feathers.events.TriggerEvent;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalListFixedRowLayout;
import feathers.style.Theme;
import feathers.utils.DisplayObjectRecycler;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import com.feathersui.todomvc.vo.TodoItem;
import com.feathersui.todomvc.vo.FilterItem;

@:build(mxhx.macros.MXHXComponent.build())
class Main extends Application {
	public static final CHILD_VARIANT_CONTENT:String = "todos_content";
	public static final CHILD_VARIANT_NEW_TODO_TEXT_INPUT:String = "todos_newTodoTextInput";
	public static final CHILD_VARIANT_TITLE_LABEL:String = "todos_titleLabel";
	public static final CHILD_VARIANT_SELECT_ALL_TOGGLE:String = "todos_selectAllToggle";
	public static final CHILD_VARIANT_BOTTOM_BAR:String = "todos_bottomBar";
	public static final CHILD_VARIANT_FOOTER_TEXT:String = "todos_footerText";

	public function new() {
		Theme.setTheme(new TodoTheme());
		super();
	}

	private var contentContainer:Panel;
	private var bottomBar:LayoutGroup;
	private var selectAllToggle:ToggleButton;
	private var newTodoInput:TextInput;
	private var todosListView:ListView;
	private var filterTabs:TabBar;
	private var incompleteLabel:Label;
	private var clearButton:Button;

	private var todosCollection = new ArrayCollection<TodoItem>();

	private var _ignoreSelectAllChange = false;

	override private function initialize():Void {
		super.initialize();

		this.todosCollection.addEventListener(Event.CHANGE, todosCollection_changeHandler);

		this.selectAllToggle.addEventListener(Event.CHANGE, selectAllToggle_changeHandler);

		this.newTodoInput.addEventListener(KeyboardEvent.KEY_DOWN, newTodoInput_keyDownHandler);

		this.todosListView.itemRendererRecycler = DisplayObjectRecycler.withFunction(() -> {
			var itemRenderer = new TodoItemRenderer();
			itemRenderer.addEventListener(TodoItemRenderer.EVENT_COMPLETED_CHANGE, todoItemRenderer_completedChangeHandler);
			itemRenderer.addEventListener(TodoItemRenderer.EVENT_TEXT_CHANGE, todoItemRenderer_textChangeHandler);
			itemRenderer.addEventListener(TodoItemRenderer.EVENT_DELETE_ITEM, todoItemRenderer_deleteItemHandler);
			return itemRenderer;
		}, null, null, (itemRenderer) -> {
			itemRenderer.removeEventListener(TodoItemRenderer.EVENT_COMPLETED_CHANGE, todoItemRenderer_completedChangeHandler);
			itemRenderer.removeEventListener(TodoItemRenderer.EVENT_TEXT_CHANGE, todoItemRenderer_textChangeHandler);
			itemRenderer.removeEventListener(TodoItemRenderer.EVENT_DELETE_ITEM, todoItemRenderer_deleteItemHandler);
		});
		this.todosListView.dataProvider = todosCollection;
		this.todosListView.itemToText = (item:TodoItem) -> item.text;

		this.filterTabs.itemToText = item -> item.text;
		this.filterTabs.addEventListener(Event.CHANGE, filterTabs_changeHandler);

		this.clearButton.addEventListener(TriggerEvent.TRIGGER, clearButton_triggerHandler);
	}

	private function todoItemToText(item:TodoItem):String {
		return item.text;
	}

	private function filterItemToText(item:FilterItem):String {
		return item.text;
	}

	private function createNewTodo(text:String):Void {
		var todoText = StringTools.trim(text);
		if (todoText.length == 0) {
			return;
		}
		var item = new TodoItem(todoText);
		this.todosCollection.add(item);
	}

	private function selectAllToggle_changeHandler(event:Event):Void {
		if (this._ignoreSelectAllChange) {
			return;
		}
		var needsUpdate = false;
		var completed = this.selectAllToggle.selected;
		for (todoItem in this.todosCollection.array) {
			if (todoItem.completed != completed) {
				todoItem.completed = completed;
				needsUpdate = true;
			}
		}
		this.todosCollection.updateAll();
		this.refreshIncompleteCount();
		this.refreshVisibility();
	}

	private function newTodoInput_keyDownHandler(event:KeyboardEvent):Void {
		if (event.keyCode == Keyboard.ENTER) {
			this.createNewTodo(this.newTodoInput.text);
			this.newTodoInput.text = "";
		}
	}

	private function activeFilterFunction(item:TodoItem):Bool {
		return !item.completed;
	}

	private function completedFilterFunction(item:TodoItem):Bool {
		return item.completed;
	}

	private function refreshSelectAllToggle():Void {
		var allSelected = true;
		for (todoItem in this.todosCollection.array) {
			if (!todoItem.completed) {
				allSelected = false;
				break;
			}
		}
		this._ignoreSelectAllChange = true;
		this.selectAllToggle.selected = allSelected;
		this._ignoreSelectAllChange = false;
	}

	private function refreshIncompleteCount():Void {
		var incompleteCount = 0;
		for (todoItem in this.todosCollection.array) {
			if (!todoItem.completed) {
				incompleteCount++;
			}
		}
		var itemsLeftText = Std.string(incompleteCount);
		if (incompleteCount == 1) {
			itemsLeftText += " item left";
		} else {
			itemsLeftText += " items left";
		}
		this.incompleteLabel.text = itemsLeftText;
	}

	private function refreshVisibility():Void {
		var hasItems = this.todosCollection.array.length > 0;
		var hasCompleted = false;
		for (todoItem in this.todosCollection.array) {
			if (todoItem.completed) {
				hasCompleted = true;
				break;
			}
		}
		this.clearButton.visible = hasCompleted;
		this.todosListView.visible = hasItems;
		this.todosListView.includeInLayout = this.todosListView.visible;
		this.contentContainer.footer = hasItems ? this.bottomBar : null;
		this.selectAllToggle.visible = hasItems;
	}

	private function refreshFilter():Void {
		var filterItem = cast(this.filterTabs.selectedItem, FilterItem);
		this.todosCollection.filterFunction = filterItem.filterFunction;
	}

	private function filterTabs_changeHandler(event:Event):Void {
		this.refreshFilter();
	}

	private function clearButton_triggerHandler(event:TriggerEvent):Void {
		this.todosCollection.filterFunction = null;
		var i = this.todosCollection.length - 1;
		while (i >= 0) {
			var todoItem = this.todosCollection.get(i);
			if (todoItem.completed) {
				this.todosCollection.removeAt(i);
			}
			i--;
		}
		this.refreshFilter();
	}

	private function todoItemRenderer_completedChangeHandler(event:Event):Void {
		var itemRenderer = cast(event.currentTarget, TodoItemRenderer);
		var todoItem = cast(itemRenderer.data, TodoItem);
		this.todosCollection.updateAt(this.todosCollection.indexOf(todoItem));
		this.refreshSelectAllToggle();
		this.refreshIncompleteCount();
		this.refreshVisibility();
	}

	private function todoItemRenderer_textChangeHandler(event:Event):Void {
		var itemRenderer = cast(event.currentTarget, TodoItemRenderer);
		var todoItem = cast(itemRenderer.data, TodoItem);
		this.todosCollection.updateAt(this.todosCollection.indexOf(todoItem));
	}

	private function todoItemRenderer_deleteItemHandler(event:Event):Void {
		var itemRenderer = cast(event.currentTarget, TodoItemRenderer);
		var todoItem = cast(itemRenderer.data, TodoItem);
		this.todosCollection.remove(todoItem);
	}

	private function todosCollection_changeHandler(event:Event):Void {
		this.refreshSelectAllToggle();
		this.refreshIncompleteCount();
		this.refreshVisibility();
	}
}
