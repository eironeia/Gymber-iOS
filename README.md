# Gymber-iOS

## Description

The app resembles a well-known dating app but is heavily simplified and thereof only consists of the main screen.  Instead of swiping potential partners, the user would be swiping potential gyms.

After consuming the API the gyms must be presented like in the dating app and can be swiped to the left (which will ignore them) or to the right.
A random 5% of Gyms that are swiped to the right are ‘matches’ and may be immediately matched and display a matching animation.

## Guidelines

* The app must use Swift 4 or higher and support iOS 11 (Sorry, no SwiftUI yet)
* At OneFit we lay out views “manually” but feel free to use Storyboards, Xibs and/or
Auto-Layout for this assignment as you prefer
* Use of any external libraries (cocoapods, swift packages, ...) is allowed
* It’s not required (nor recommended) to use all parameters in the API feed, however, we would
like to see the usage of latitude & longitude to show the users distance from the gym and
correct size of the main image
* Not mandatory but would be of added value if you would incorporate (some) unit testing

## Architecture


My decision for the architecture has been use MVVM. The reason behind that is that I am familiar with it and since the models from the API doesn't require high amount of modification in terms of getting presented, I didn't chose an approach as it could be VIPER or VIP. Factory pattern in order to create dependencies in a way that can easily be tested.

Other pattern that I have would have used is Coordinator pattern for handling the navigation. 

I decoupled the app with Domain and Network layer. I have used Swift Package Manager for that, and the reason behind it, it's because it's the Apple native solution and I did want to experiment with it.

## Frameworks used

* **PKHUD:** I have used it for the loader. I didn't want to necessarily spend so many time on creating a loader since UI was important but not critical. I have had experience with this framework and it has really nice and easy integration.

* **Kingfisher:** I have used it to load the images from the URL, used mainly because of being handy, not because it's solves a big problem.

* **Shuffle:** Due to limitaation of time, I decided to use Shuffle to implement the UI for the Tinder style. The reason that I went for that library, it's because it's an open source library, maintened and you can adapt or adjust as you please. Given that I am using only few of the functionalities of the library for future iterations might be convinient to have our own framework with only the files that we need.

## App Screenshots

<img width="300" alt="Screenshot 2021-05-04 at 11 28 23" src="https://user-images.githubusercontent.com/12100457/116984718-d6fa5280-accb-11eb-8eb7-05ff796998bf.png">

<img width="300" alt="Screenshot 2021-05-04 at 11 27 42" src="https://user-images.githubusercontent.com/12100457/116984630-bf22ce80-accb-11eb-986d-eddd2111bdbf.png">

<img width="300" alt="Screenshot 2021-05-04 at 11 27 52" src="https://user-images.githubusercontent.com/12100457/116984657-c518af80-accb-11eb-8a41-61726c8d8815.png">
