# wt-app-scaffold
A bunch of tools to rapidly start building an app.

## Setup Launch Icon

Add the following the pubspec.yaml file.

```yaml
flutter_icons:
  image_path: assets/avocado.png
  android: true
  ios: true
```

To configure project, run:
```shell
flutter pub run flutter_launcher_icons:main
```
## Setup Splash Screen

Add the following the pubspec.yaml file.

```yaml
flutter_native_splash:
  color: "#9E9E9E"
  image: assets/avocado.png
  android_12:
  web_image_mode: center
```

To configure project, run: 
```shell
flutter pub run flutter_native_splash:create
```