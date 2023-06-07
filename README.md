# InputHandler
Generated by [Rojo](https://github.com/rojo-rbx/rojo) 7.3.0.

A new Input System, that tries to clean up User Input Service and make it easy for developers to make cross platform games

## This Input system is working now.
Though keep in mind that module is new and probably contains some bugs.
If you encounter any feel free to open an Issue or make a pull request.

## Why would you want to use it?
Despite ContextActionService doing similar things. This doesn't override the original input as it only uses UserInputService or a GuiObject to detect input.
This brings me to my second advantage as you can set custom buttton actions to do the same thing as the input this can be used to make custom buttons for mobile or for pc and console.
If you make an Inventory for example you can connect to an action that is maybe called `toggleInventory` you can have an inventory button that triggers this function as well as an keybind like `E`.
This module also offers you the possibility to get if any button in an action is pressed using `action:isPressed()`.
This can be useful, if you foraxample want to make a custom camera so you check every frame, if for example the `rightRotation` input is pressed to rotate the camera.

## How to use it
First you create a new Input Handler as give in the example Input.
This can also be a private variable though I recommend using only one and having that work globally.
Then you want to add an ActionGroup to your InputHandler, action groups are just a way to organize your input in diffrent categories.
After that you can finaly start adding actual input actions. These are the actions you will have to listen to.
Though the actions themselfs have to listen to the actual inputs using listeners, these listen to a specific input type, like `MouseButton1` or `L` which are part of the common input types, as they are already given by roblox.
You can also add your own input from GuiObjects, as shown in the example.

