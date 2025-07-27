# Moneybox iOS Tech Task

This project is a lightweight iOS app built using SwiftUI, TCA (The Composable Architecture), and MVVM. It covers key functionality such as logging in, viewing accounts, and adding money to a product.

[GitHub Repo](https://github.com/xLuciferSx/moneybox-tech-task)

## Architecture

**MVVM** is used for the Login and Accounts screens.  
**TCA** is used for the product detail features to manage state and side effects cleanly.

## Features

- Login with email and password
- View user accounts and total plan value
- View individual product details
- Add custom amount to your personal investor funds
- Keychain token storage
- Logout support
- Localised strings
- Accessibility labels

## Testing

Tests use the Swift `@Test` macro system with stubbed data.

Tested components:
- `LoginManager`
- `AccountsManager`

Mocks are injected using `Factory` and JSON responses are loaded using a simple `StubData` loader.

## Credentials

You can use any of these test accounts:

| Email                     | Password   |
|--------------------------|------------|
| test+ios@moneyboxapp.com | TechTask25 |
| test+ios2@moneyboxapp.com| TechTask25 |
| test+ios3@moneyboxapp.com| TechTask25 |

## Setup

1. Clone the repo  
2. Open `MoneyBox.xcodeproj`  
3. Run on iOS 15.0 or later
