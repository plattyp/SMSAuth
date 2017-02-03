# SMSAuth
A pod for quickly adding SMS Authentication to an iOS app

## What does this do?

This is a Cocoapod for quickly adding SMS based authentication to a iOS application. It interacts with the API routes created by the [sms_auth](https://github.com/plattyp/sms_auth) gem.

## Installation

### Import Pod

Add the following to your Podfile

```
pod 'SMSAuth'
```

Then use `pod install` in your terminal to install it within your project

### Setting Up

#### For Opening The App

If you are setting this up to be the first bit of authentication when accessing your app (e.g. it'll open directly to it and will redirect back to it on logout), then you will set it up within your AppDelegate.swift file

Import the SMSAuth library at the top of your AppDelegate

```swift
import UIKit
import SMSAuth

```

You're AppDelegate will need to implement the LoginViewDelegate (Provided by the SMSAuth library)

```swift
class AppDelegate: UIResponder, UIApplicationDelegate, LoginViewDelegate {

```

Within your didFinishLaunchingWithOptions method, you will need to configure the API path for your local API and will need to setup the LoginViewController. There are various options that can be overriden like texts of buttons, descriptions above the input, etc, that can be done here as well.

You will use the helper method showViewController in order to switch between your root controller if the user is authenticated and the login controller if the user opens the app not authenticated.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
        
    // Configure Client
    SMSAuth.setApiPath(path: "https://37db5d45.ngrok.io")
        
    // Login View Controller
    let loginViewController = LoginViewController()
    loginViewController.delegate = self
        
    SMSAuth.showViewController(window: window, authenticateViewController: MainViewController(), loginViewController: loginViewController)
        
    return true
}

```

To handle what happens after a user logs in successfully, you will need to also add this function in your AppDelegate (to conform to the LoginViewDelegate protocol). It will return the `userId` (Int) of the user and if the user is new `newUser` (Bool). You can then switch the root view controller to either the main authenticated view controller or another controller that can be used to setup the user's account.

```swift
func onLoginSuccess(userId: Int, newUser: Bool) {
    if (newUser) {
        let setupUserViewController = SetupUserViewController()
        setupUserViewController.userId = userId
        window?.rootViewController = UINavigationController(rootViewController: setupUserViewController)
    } else {
        let mainViewController = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: mainViewController)
    }
    window?.makeKeyAndVisible()
}

```
#### Handling Logging Out

Within the authenticated part of the application you will need to import the SMSAuth library in a ViewController that will offer the ability to logout.

```swift
import UIKit
import SMSAuth
```

Then create a function that is a target of a button that will use the helper method to logout and revert back to the logout screen

```swift
func logout() {
    SMSAuth.logout(callback: {
        (success, message) -> Void in
            
        if (success) {
            SMSAuth.revertToLogin()
        } else {
            print("REPORT ERROR: " + message)
        }
    })
}
```



