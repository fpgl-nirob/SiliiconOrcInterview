# Silicon Orchard Interview

Interview test project

## Features

- Get the location of 50 restaurents within 3km of user's current location in a Map
- Can also search for a restaurant with keyword.
- Get some other info like Restaurant Type when searching for a restaurant

## Requirements

- iOS 10.0+
- Swift 5.0

## How to Build

At first, run the following command in Terminal:

```
git clone <#SSH/HTTPS#>
```

Then, install Cocoapods into project:

```
pod install
```

Finally, open ```project_name.xcworkspace``` file. Build and Run the project. That's it.

## Project Architecture

- Use MVC design pattern mostly to meet deadline.
- Also use Singleton for Network call. And use MVVM for showing Restaurant's inforamtion.

## Frameworks

- 'MBProgressHUD'
- 'Toaster'
- 'SDWebImage', '~> 5.0'
- 'Alamofire'
- 'SQLite.swift'
- 'SwiftyJSON'

## Project Tree
* README.md
* Restaurant Finder
  * Controllers
    * MapViewController.swift
    * ResultViewController.swift
    * BaseViewController.swift
  * Views
    * Storyboards
      * Main.storyboard
      * LaunchScreen.storyboard
    * MarkerInfoView.swift
    * PlaceMarker.swift
    * ResultCell.swift
    * ResultCell.xib
  * Model
    * Response.swift
    * SearchResponse.swift
    * Location.swift
    * Venue.swift
    * VenueCategory.swift
    * VenueCategoryIcon.swift
  * Viewmodel
    * ResultCellViewModel.swift
  * Utility
    * Constants.swift
    * APIService.swift
  * Extensions
    * Uiview+Extensions.swift
    * UiSearchBar+Extensions.swift
  * Support Files
    * Info.plist
    * Assets.xcassets
  * AppDelegate.swift
  * SceneDeelgate.swift
* Restaurant FinderTests
* Restaurant FinderUITests
* Products
* Pods
* Frameworks

## Limitations

- A little bit of Unit Testing Code added
- Project is build mostly on MVC which is more challenging for Unit Testing

## Future Update

- Convert the whole project to MVVM architecture pattern
- Add more Unit Test code
- Show direction from current location to Restaurant
- Show more details informations about restaurants


