# favqs

FavQS is an iOS client that fetch the latest quotes from https://favqs.com/api endpoint.

To start the project, simply clone it and open the project (tested with Xcode 12.0.1 and iOS 14).
```shell
git clone https://github.com/leobouilloux/favqs.git
cd favqs
pod install
open Favqs.xcworkspace
```
<br/>

## Features
- Connect to an existing account
- Account page to view details and sign out.
- Refresh the list with a "pull to refresh"
- Offline ready thanks to realm
- Save your favorite quotes in a dedicated section
- Dark/Light mode are supported
- Pagination (scroll to bottom to load more quotes)

## Architecture
The project has been built using the MVVM-C (Model View ViewModel and Coordinators) architecture.
For each screen the following classes are created:
- ViewController (contains view + view interactions)
- ViewModel (handle and interact with the data that will be used by the ViewController)
- ViewModelInterface (interface for the viewModel to allow multiple implementations for example)

## Coordinators
Coordinators are a great way to handle navigation outside of ViewControllers.
The main benefit is that you can use any ViewController in any context without writting complex code to handle different cases.
Here is the current implementation of the project:
```
ApplicationCoordinator
|
| > SplashScreenCoordinator
|   |
|   | > SplashScreenPresentable
|
| > TabBarCoordinator
|   |
|   | > QuotesCoordinator
|   |   |
|   |   | > QuotesPresentable
|   |
|   | > FavoritesCoordinator
|   |   |
|   |   | > FavoritesPresentable
```

## Assets and localization
The application is translated in french and english.
I've been using swiftgen by the past, and I wanted to reproduce this logic.
I created Assets.swift and Localizable.swift to do the same work.
Here is the benefit:
```swift
// we need to implicitly type the asset name, and there's no scope facilities
let image = UIImage(named: "close")
let localizable = NSLocalizedString("splashScreen.caption", comment: "")

// Swiftgen like assets loading, sorted by scope, with autocompletion
let image = Assets.Icons.close
let localizable = Loc.SplashScreen.caption
```

## Tools and Pods
I have a private repository containing a few swift files with different tools.
I used some of them for this project and if needed, I can show you this repository content.

- Alamofire (network requests)
- Realm (persist the data)
- RxCocoa/RxSwift (React programming)
- RxRealm (Realm Rx wrapper)

## Data provider
I implemented a very simple Provider protocol with one method to fetch data.
This protocol has one implementation:
- NetworkProvider (used in the app, makes a call to the FavQs api)
This provider takes care of storing the objects in a Realm database.
The data seen on the ViewControllers is loaded thanks to RxRealm.


## Unit tests
I wrote tests using GWT style (GIVEN > WHEN > THEN)
Since I was runing out of time, I've done a 2 very simple tests case for the QuoteTableViewCellViewModel.

## Functional tests
Due to the lack of time, I wasn't able to write a functional test.
I have done some of them by the past, so we can discuss this part.

## Linter
I ran locally `swiftlint autocorrect` to clear automatically some mistakes and fixed the last ones myself using `swiftlint` commands (see commit [STEP 4]).
My .swiftgen.yml file is on the repo so you can have a look on the rules I am using.