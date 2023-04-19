# DailyUs Flutter

This project was part of submission projects to finish the Dicoding Indonesia's Flutter Intermediate course. The main purpose of this submission was to challenge students to create a posting-stories-like app. The app being built had to be using Localization. This project is duplication of my previous [repo](https://github.com/rllyhz/DailyUs) project in Android Native that has the same features.

# Preview
<p align="center">
    <img src="art/splash_login_register_demo.gif"
        alt="Auth Demo"
        width="200" />
</p>

<p align="center">
    <img src="art/home_post_profile_demo.gif"
        alt="Home demo"
        width="200" />
</p>

# How to run

1. Clone or download this repo.
2. Create a new `secrets.json` file by copying `secrets.test.json` file in the root folder/project.
3. Set the `base_url` key to base url this project are using. This is basically for keeping the secret env values private.
3. And then, open project in VS Code or Android Studio.
4. Run the the app in IDE. You can run `flutter run --debug` command on terminal to run the project.

# Tech Stack

- Dart/Flutter
- Dependency Injection
- Navigator 2.0 (Router Delegation, Route Information Parser, and Page Configuration)
- Authentication feature (register, login and logout)
- Localization for accessibility (supports only *en* and *id*)
- Flutter Bloc
- Shimmer Effect