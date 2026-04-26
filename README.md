Markdown
# Bloom Wise

A simple and beautiful Flutter app to help you to take care of your plant collection! 

## Features

* **Smart Login & Signup:** The Login screen connects to the real Reqres.in API. The Signup screen uses a simulated loading delay so you can easily create test accounts. Both screens use `SharedPreferences` to keep you logged in even after you close the app.
* **Manage Your Plants:** Easily add new plants, update their watering schedules, or delete them (Full CRUD operations).
* **Search & Filter:** Find the exact plant you are looking for by typing its name, or use the dropdown to filter by "Indoor" or "Outdoor".
* **Dark Mode:** A custom settings tab lets you instantly switch the entire app between Light and Dark themes.
* **Live Database:** Connects to MockAPI.io over the internet to save and load your plant data in real-time.
* **Native App Feel:** Includes a custom app icon and a quick splash screen when you first open the app on your phone.

## Built With

* **Flutter & Dart** - App framework
* **Provider** - Used to manage state for the Plants, Themes, and User Authentication
* **HTTP** - Used to talk to the MockAPI and Reqres databases
* **Shared Preferences** - Used to save the login token locally on the phone

## How to Run the App

1. **Clone the project:**
```bash
git clone https://github.com/danith11/Plant-Care-App.git
```
2. **Open the folder:**
```bash
    cd Plant_Care_App
```

3. **Download the packages:**
```bash
   flutter pub get
```

4. **Run it on your phone or emulator:**
 ```bash
   flutter run
```

## Note for Reviewers

To make testing the app as easy as possible, the authentication system uses a hybrid approach:

Login: Uses the live Reqres.in API to demonstrate real network requests. (Use the email  eve.holt@reqres.in and password cityslicka to test a successful login).

Signup: Uses a simulated network delay and generates a local token. This allows you to type any random name and email to test the app without being blocked by the strict Reqres user limits.
