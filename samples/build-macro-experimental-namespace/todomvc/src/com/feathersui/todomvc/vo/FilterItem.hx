package com.feathersui.todomvc.vo;

class FilterItem {
	public var text:String;
	public var filterFunction:(TodoItem) -> Bool;

	public function new(?text:String, ?filterFunction:(TodoItem) -> Bool) {
		this.text = text;
		this.filterFunction = filterFunction;
	}
}
