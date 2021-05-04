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

## Frameworks used

* **PKHUD:** I have used it for the loader. I didn't want to necessarily spend so many time on creating a loader since UI was important but not critical. I have had experience with this framework and it has really nice and easy integration.

* **Kingfisher:** I have used it to load the images from the URL, used mainly because of being handy, not because it's solves a big problem.
