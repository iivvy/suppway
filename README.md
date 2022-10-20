# SuppWayy Mobile Application

REEWAYY's Mobile Application for SuppWAYY

## Prerequisites 

- [Install Flutter](https://flutter.dev/docs/get-started/install)
- [Setup VSCode for Flutter](https://flutter.dev/docs/get-started/editor?tab=vscode) 

**IMPORTANT** make sure flutter version is **2.5.3**
## Developpement 

Clone the repository
```
git clone https://gitlab.reewayy.io/reewayy/suppwayy_mobile.git
```

Update the project and start coding
```
cd suppwayy_mobile
flutter pub get
code .
```


Useful commands to run the project 
```bash
adb start-server
emulator -list-avds
emulator -avd <AVD NAME>
flutter run
```

Useful commands for project cache invalidation 
```bash
flutter clean
cd ./android
./gradlew clean 
rm -rf .gradle 
```

## Build a release

- Follow this guide for project setup [https://docs.flutter.dev/deployment/android](https://docs.flutter.dev/deployment/android)
- [Flutter launcher icons documentation](https://pub.dev/packages/flutter_launcher_icons) 

```bash
flutter pub get
flutter pub run flutter_launcher_icons:main
flutter build appbundle
```

## Check intent

For android
```bash
adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "http://reewayy.io/" dz.transformatek.suppwayy_mobile
```

## Contibution
- [Contributing Guidelines](/docs/CONTRIBUTING.md)

## Ressources for Getting Started with Flutter 

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Online documentation](https://flutter.dev/docs)
 