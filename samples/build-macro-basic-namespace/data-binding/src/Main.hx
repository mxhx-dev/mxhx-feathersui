import mxhx.bindable.DataBinding;
import feathers.controls.Application;

@:build(mxhx.macros.MXHXComponent.build())
class Main extends Application {
	public function new() {
		super();

		DataBinding.bind(Std.string(slider.value), label.text, this);
	}
}
