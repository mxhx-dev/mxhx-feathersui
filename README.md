# MXHX for Feathers UI

Registers [Feathers UI](https://feathersui.com/) components for use with MXHX.

_Note:_ You will also need to install either [mxhx-component](https://github.com/mxhx-dev/mxhx-component) or [mxhx-runtime-component](https://github.com/mxhx-dev/mxhx-runtime-component), depending on whether you want to create MXHX components at compile-time or at run-time.

## Minimum Requirements

- Haxe 4.0
- Feathers UI 1.3

## Installation

This library is not yet available on Haxelib, so you'll need to install it from Github.

```sh
haxelib git mxhx-feathersui https://github.com/mxhx-dev/mxhx-feathersui.git
```

## Project Configuration

After installing the library above, add it to your OpenFL _project.xml_ file:

```xml
<haxelib name="mxhx-feathersui" />
```

You will also need to add one of the following libraries (but probably not both):

```xml
<haxelib name="mxhx-component" />
```

or

```xml
<haxelib name="mxhx-runtime-component" />
```

## Usage

The Feathers UI namespace for MXHX is _https://ns.feathersui.com/mxhx_.

```xml
<?xml version="1.0" encoding="utf-8"?>
<f:Application xmlns:mx="https://ns.mxhx.dev/2024/mxhx"
	xmlns:f="https://ns.feathersui.com/mxhx">
	<mx:Declarations>
	</mx:Declarations>
</f:Application>
```
