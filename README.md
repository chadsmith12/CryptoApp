## Crypto Tracker

Crypto Tracker is a crypto currency tracking application built in Swift UI that targets iOS14. The application attempts to show a real-world app architechure that could be used when developing an application in SwiftUI. Core Features in this application include:

* Pulling Data from CoinGecko API
* Add Coins to your Portfolio
* Saving/Loading your Portfolio to CoreData
* Detail of the Coin with 7 day price history

### Screenshots

![Launch Screen](screenshots/launch.png?raw=true)
![Main Screen](screenshots/all-coins.png?raw=true)
![Portfolio Screen](screenshots/portfolio.png?raw=true)
![Edit Portfolio Screen](screenshots/edit-portfolio.png?raw=true)
![Detail Screen](screenshots/detail.png?raw=true)

### Architechure

This application attempts to use an architechure that you would see in a real-world application. This uses MVVM and uses Combine to demonstrate publishing and subscribing. The folder structure/app layout tries to demonstrate breaking your code out into different layers. There are the following:

* Utilities - Basic utility functions for network code, file manager code, or haptic engine
* Services - Houses all the services to download data from the internet
* Core - Houses all of our core models used in the application
* TestViews - This is only used to put some test views to show the color theme
* Extensions - Extensions to core Swift data structures that is used across the application
* Presentation - Presentation layer that houses all the Views, Components, and View Models

### Color Theme

This application uses the Assets.xcassets to manage the color theme as color sets. It defines a color scheme for both light and dark mode so it can easily be switched out. These are then strongly typed so they can be used in SwiftUI by extending `Color`. Example:

```swift
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
```

This allows you to use the same color theme all throughout the application, like so:
```swift
Text("Hello World")
    .foregroundColor(.theme.accent)
```

### Previews

All Previews for every view work by using `PreviewProvider` and mock data that is done by extending the PreviewProvider so you can easily access mock data in the preview. Seeing the extension for the `PreviewProvider` shows how this is done.

### Special Thanks

This application was developed using the CoinGecko API. Special Thanks to them for the amazing free API. It can be located here: https://www.coingecko.com/en

This application was also developed along side a free YouTube course from the amazing channel, Swiftful Thinking. You can location the channel [here](https://www.youtube.com/channel/UCp25X4LzOLaksp5qY0YMUzg) and if you want to support this amazing free content, consider supporting him [here](https://www.buymeacoffee.com/nicksarno)

