# MXHX Feathers UI Samples

These samples demonstrate how to use [Feathers UI](https://feathersui.com) with [MXHX](https://mxhx.dev).

MXHX supports a number of different methods for creating components, and several samples have multiple variants. These variants have been organized into directories.

- Directories with names containing _build-macro_ use the `MXHXComponent.build()` macro to inject MXHX content into a Haxe class.
- Directories with names containing _inline-markup_ use `MXHXComponent.withMarkup()` to instantiate an MXHX component from an inline string value.
- Directories with names containing _with-file_ use `MXHXComponent.withFile()` to instantiate an MXHX component declared in a file.

Additionally, MXHX has two core language namespaces, which have different capabilities.

- Directories with names containing _basic-namespace_ use the `https://ns.mxhx.dev/2024/basic` namespace. This namespace is designed to be declarative only, and is considered the most stable and recommended option at this time.
- Directories with names containing _experimental-namespace_ use the `https://ns.mxhx.dev/2024/mxhx` namespace. This namespace enables more powerful MXHX features where Haxe code may be included inside the markup, allowing for inline event listeners and syntax for data binding.

For instance, samples contained in the _inline-markup-basic-namespace_ directory use `MXHXComponent.withMarkup()` with inline string values, and the declarative-only `https://ns.mxhx.dev/2024/basic` namespace.
