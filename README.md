
# Moneybox iOS Technical Challenge

## The Brief

Create a "mini" version of the Moneybox app that will allow users to login, check their account balances and make deposits. 
 
### The app should have
- A login screen to allow users to sign in.
- A screen to show the accounts the user holds.
- A screen to show some details of a selected account, including a button to add money.
- The button will add a fixed amount of £10. It should use the `POST /oneoffpayments` endpoint request provided. The account's displayed Moneybox amount should be updated as a result.

A prototype wireframe of all 3 screens is provided as a guideline. You are free to provide additional information if you wish.
![](wireframe.png)

### What we are looking for
 **Showcase what you can do. You can refine the UI, provide enhanced UX, use specific design patterns in code, or anything that can make the project stand out.**
 - Demonstrate clear coding style, conventions and patterns.
 - A tidy code organisation.
 - Use of either SwiftUI or autolayout & UIKit.
 - Implementation of unit tests.
 - Accessibility support.
 - The application must run on iOS 15 or later.
 - Any 3rd party library should be integrated using Swift Package Manager.

### API Usage
The Networking methods and Models for requests and responses are ready-made in the Networking package.

The base URL for the moneybox sandbox environment is `https://api-test02.moneyboxapp.com/`, which is handled automatically by the provided functionality in the Networking package.

#### Test Users
You can log in using any of the following users:

| Username | Password |
| ------------- | ------------- |
| test+ios@moneyboxapp.com | TechTask25 |
| test+ios2@moneyboxapp.com | TechTask25 |
| test+ios3@moneyboxapp.com | TechTask25 |

#### Authentication
You should obtain a bearer token from the login response and attach it as an authorization header for subsequent API requests. The Networking package has helper functionality in the Base folder to support this.

| Key | Value |
| ------------- | ------------- |
| Authorization | Bearer TsMWRkbrcu3NGrpf84gi2+pg0iOMVymyKklmkY0oI84= |

Please note that bearer tokens automatically expire after a 10 minute period of inactivity. Any API request made after this period will return an error:
```json
{
    "Name": "Bearer token expired",
    "Message": "Your session has expired. Please close the app and log in again.",
    "ValidationErrors": []
}
```

#### API Call Hint
```swift
let dataProvider = DataProvider()
dataProvider.login(request: request, completion: completion)
```
- request: Initialize your request model
- completion: Handle your API success and failure cases

## Unit Tests
The MoneyBoxTests target includes stubbed data to easily mock the responses needed for unit testing.

#### Usage Hint
You can create a DataProviderMock class via the abstracted DataProviderLogic protocol.

We've also included a StubData object with a static method for reading stubbed JSON files. The example below attempts to read "Accounts.json" from within the MoneyBoxTests target:
```swift
StubData.read(file: "Accounts", callback: completion)
```

### Troubleshooting
#### Account limit reached
If you encounter any account limit errors when depositing, please try depositing into a different account.

For "ISA" accounts, you may encounter a yearly allowance limit error. Please try depositing into one of the Savings accounts open, such as "Simple Saver", "Reward Saver" or "Day Notice" - which have more flexible limits.

If you're still encountering issues after trying the above, please reach out to us.

#### App version error
It's possible while working on the project that you may encounter an error from the API:
```json
{
    "Name": "Moneybox version expired",
    "Message": "This version of our app is no longer supported. Please update to the latest version in the App Store.",
    "ValidationErrors": []
}
```
To resolve please update the app version of your project to match the version of the latest Moneybox app in the app store. 

### How to Submit your solution:
- Use Git to manage your task.
- (Optional) Include a readme in markdown which describes your solution.
- Share a ZIP file of your repository with the hiring manager for the role.

## Good luck!
