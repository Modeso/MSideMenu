# MSideMenu
<p align="center">
  <img src="https://github.com/Modeso/MSideMenu/blob/master/drag.gif">
</p>

[![Build Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://img.shields.io/travis/rust-lang/rust.svg)
[![CocoaPods Compatible](https://img.shields.io/badge/Pod-compatible-4BC51D.svg
)](https://cocoapods.org
)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/badge/Platform-iOS-d3d3d3.svg)]()
[![Twitter](https://img.shields.io/badge/twitter-@modeso_ch-0B0032.svg?style=flat)](http://twitter.com/AlamofireSF)

MSideMenu is a Side Menu library written in Swift. It enables a flexible use for the Side Menu Animation

<img src="https://github.com/Modeso/MSideMenu/blob/master/SideMenuDemo.gif" alt="GifDemo">

- [Options](#options)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Communication](#communication)
- [Credits](#credits)
- [License](#license)

## Options

<img src="https://github.com/Modeso/MSideMenu/blob/master/properties.png" alt="Proprties">

- `presentationDuration`: set the duration of the presentation animation of the side menu.
- `dismissDuration`: set the duration of the dismissal animation of the side menu.
- `sideMenuViewControllerScale`: set the scale of the side menu view controller.
- `xTranslation`: set the translation in x direction for the content view controller. Default value is 0.0, and it will cause the content view controller to stay at center of the screen
- `yTranslation`: set the translation in y direction for the content view controller. Default value is 0.0, and it will cause the content view controller to stay at center of the screen
- `contentViewControllerOpacity`: set the alpha of the content view controller.
- `shouldDismissOnTappingContentVC`: enable or disable the gesture recognizer that dismisses the side menu on clicking on the content view controller.
- `interactivePresentationAndDismissal`: enable or disable the interactive gesture recognizer that presents and dismisses the side meny by dragging.
- `contentViewHasShadow`: enable or disable the shadow of the content view controller.
- `contentViewShadowColor`: set the color of the shadow of the content view controller.
- `contentViewShadowOffset`: set the offset of the shadow of the content view controller.
- `contentViewShadowOpacity`: set the opacity of the shadow of the content view controller.
- `contentViewShadowRadius`: set the radius of the shadow of the content view controller.
- `presentationAnimationSpringWithDamping`: set the spring with damping ratio for the presentation animation.
- `presentationAnimationInitialSpringVelocity`: set the initial velocity ratio for the presentation animation.
- `dismissAnimationSpringWithDamping`: set the spring with damping ratio for the dismissal animation.
- `dismissAnimationInitialSpringVelocity`: set the initial velocity ratio for the dismissal animation.

    

## Requirements

- iOS 8.0+
- Xcode 8.1+
- Swift 3.0+


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.2.0+ is required to build MSideMenu.

To integrate MSideMenu into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'MSideMenu', :git => 'https://github.com/Modeso/MSideMenu.git'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate MSideMenu into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Modeso/MSideMenu"
```

Run `carthage update` to build the framework and drag the built `MSideMenu.framework` into your Xcode project, and add it to the Embedded binaries.

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate MSideMenu into your project manually.
> Simply download zip folder and unarchieve it, drag the directory `Classes/` into your project navigation and that's it.
---

## Usage

### SideMenuNavigationController

## Creation
- Create Navigation controller in the storyboard and set the class to `SideMenuNavigationController`.
- In this RootViewController of this navigation controller, use the `override func awakeFromNib` to set the `leftSideMenuViewController` property for the navigation controller.

```swift
        guard let sideMenuNavController = self.navigationController as? SideMenuNavigationController else {
            return
        }
        sideMenuNavController.sideMenuViewController = UIStoryboard(name: "Main", bundle:  nil).instantiateViewController(withIdentifier: "leftSideViewController")

```
## Dismiss

- use `closeSideMenu()` method that's available in the `SideMenuNavigationController`

```swift
    sideMenuNavController.closeSideMenu()
```
## Change Content View Controller
- use the `setViewControllers` of the navigation controller

```swift
    sideMenuNavController.setViewControllers([newViewController], animated: false)
```

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Credits

MSideMenu is owned and maintained by [Modeso](http://modeso.ch). You can follow them on Twitter at [@modeso_ch](https://twitter.com/modeso_ch) for project updates and releases.

## License

MSideMenu is released under the MIT license. See LICENSE for details.
