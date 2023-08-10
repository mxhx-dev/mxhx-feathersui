import openfl.ui.Keyboard;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import feathers.controls.Application;
import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.events.TriggerEvent;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.style.Theme;

@:build(mxhx.macros.MXHXComponent.build())
class Main extends Application {
	public function new() {
		Theme.setTheme(new CalculatorTheme());

		super();

		this.tabChildren = false;

		this.stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler, true);

		this.clear();
	}

	private var inputDisplay:Label;
	private var numberButtons:Array<Button> = [];
	private var clearButton:Button;
	private var addButton:Button;
	private var subtractButton:Button;
	private var multiplyButton:Button;
	private var divideButton:Button;
	private var equalsButton:Button;

	private var pendingNewInput:Bool = true;
	private var previousNumber:Int = 0;
	private var pendingOperation:Operation = null;

	@:bindable("currentNumberChange")
	private var currentNumber(default, set):Int = 0;

	private function set_currentNumber(value:Int):Int {
		if (this.currentNumber == value) {
			return this.currentNumber;
		}
		this.currentNumber = value;
		this.dispatchEvent(new Event("currentNumberChange"));
		return this.currentNumber;
	}

	private function insertNumber(index:Int):Void {
		if (this.pendingNewInput) {
			this.previousNumber = this.currentNumber;
		}

		var newText = (this.pendingNewInput || this.currentNumber == 0) ? "" : Std.string(this.currentNumber);
		this.pendingNewInput = false;

		if (index == 0 && this.currentNumber == 0) {
			// the user pressed 0, but the value is already 0, so don't append
			return;
		}
		newText += Std.string(index);

		// max length of input
		if (newText.length >= 10) {
			return;
		}

		this.currentNumber = Std.parseInt(newText);
	}

	private function clear():Void {
		this.pendingNewInput = true;
		this.pendingOperation = null;
		this.previousNumber = 0;
		this.currentNumber = 0;
	}

	private function equalsInternal():Void {
		if (this.pendingOperation == null) {
			return;
		}
		var result = 0;
		switch (this.pendingOperation) {
			case Add:
				result = this.previousNumber + this.currentNumber;
			case Subtract:
				result = this.previousNumber - this.currentNumber;
			case Multiply:
				result = this.previousNumber * this.currentNumber;
			case Divide:
				result = Math.floor(this.previousNumber / this.currentNumber);
		}
		this.currentNumber = result;
		this.previousNumber = result;
		this.pendingOperation = null;
		this.pendingNewInput = true;
	}

	private function equals():Void {
		if (this.pendingNewInput) {
			this.pendingOperation = null;
			return;
		}
		this.equalsInternal();
	}

	private function add():Void {
		if (this.pendingOperation != null && !this.pendingNewInput) {
			this.equalsInternal();
		}
		this.pendingOperation = Add;
		this.pendingNewInput = true;
	}

	private function subtract():Void {
		if (this.pendingOperation != null && !this.pendingNewInput) {
			this.equalsInternal();
		}
		this.pendingOperation = Subtract;
		this.pendingNewInput = true;
	}

	private function multiply():Void {
		if (this.pendingOperation != null && !this.pendingNewInput) {
			this.equalsInternal();
		}
		this.pendingOperation = Multiply;
		this.pendingNewInput = true;
	}

	private function divide():Void {
		if (this.pendingOperation != null && !this.pendingNewInput) {
			this.equalsInternal();
		}
		this.pendingOperation = Divide;
		this.pendingNewInput = true;
	}

	private function subtractButton_triggerHandler(event:TriggerEvent):Void {
		this.subtract();
	}

	private function multiplyButton_triggerHandler(event:TriggerEvent):Void {
		this.multiply();
	}

	private function divideButton_triggerHandler(event:TriggerEvent):Void {
		this.divide();
	}

	private function stage_keyDownHandler(event:KeyboardEvent):Void {
		if (event.isDefaultPrevented()) {
			return;
		}
		if (event.keyCode == Keyboard.ENTER) {
			event.preventDefault();
			this.equals();
			return;
		}
		if (event.keyCode == Keyboard.ESCAPE) {
			event.preventDefault();
			this.clear();
			return;
		}
		var char = String.fromCharCode(event.charCode);
		if (~/^[0-9]$/.match(char)) {
			event.preventDefault();
			this.insertNumber(Std.parseInt(char));
			return;
		}
		switch (char) {
			case "+":
				event.preventDefault();
				this.add();
			case "-":
				event.preventDefault();
				this.subtract();
			case "*":
				event.preventDefault();
				this.multiply();
			case "/":
				event.preventDefault();
				this.divide();
			case "=":
				event.preventDefault();
				this.equals();
			case "c":
				event.preventDefault();
				this.clear();
		}
	}
}

enum Operation {
	Add;
	Subtract;
	Multiply;
	Divide;
}
