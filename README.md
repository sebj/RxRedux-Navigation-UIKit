# 🔄 🗺

This is a basic Redux-like implementation in Swift using RxSwift, allowing the current app navigation state to be  represented within a central `Store`.

See [ReSwift's documentation](https://github.com/ReSwift/ReSwift/blob/master/README.md) for a better explanation of some of the common principles. [Majid Jabrayilov](https://swiftwithmajid.com/2019/09/18/redux-like-state-container-in-swiftui/) also has a similar SwiftUI/Combine Store implementation.

*Developed to target Swift 5.1.*

## Usage

Copy & build upon the contents of `Sources`.

* States and sub-states should be `Equatable` structs.
* Pure actions should be structs implementing `Action`
* Actions with side-effects can be structs or functions that provide a `Thunk<..>`

See `Example` for small sample implementations of the following.

* Create a Store with your app's state
* Create a Router, providing a factory function to create a `UIViewController` from a given `Screen`, the root store, and a presenter (for example a `UINavigationController`)
* Ensure view controllers implement `Navigatable`
* To navigate from one screen to another, dispatch a `NavigationAction` of `replace` (to replace the screen hierarchy) or `push`  (to push a new screen onto the stack)