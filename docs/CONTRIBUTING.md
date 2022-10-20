# Contributing to Flutter Project

## Android Configuration

* Check gradle minimum versions and Unify **application name**  
    - /adnroid/build.gradle
        - `ext.kotlin_version = '1.6.10'`
        - `classpath 'com.android.tools.build:gradle:7.1.3'`
    - /android/gradle/wrapper/gradle-wrapper.properties
        - `distributionUrl=https\://services.gradle.org/distributions/gradle-7.3-all.zip`
    - /android/app/build.gradle
        - `applicationId "<app_name>"`
        - `compileSdkVersion 31`
        - `minSdkVersion 23`
        - `targetSdkVersion 31`
    - /app/src/AndroidManifest.xml
        - `<activity android:name=".MainActivity" ... android:exported="true" ...`
        - `android:label="<app_name>"`

* Add application icon

## Main packages and Naming conventions
 
- Use **Material design** components
- Use **BLoC** for state management
- Use **snacke_case** for **files** and **directory** names 
- Use **camelCase** for **variables** names 
- Use **PascalCase** for variables **classes** names 

See [https://khalilstemmler.com/blogs/camel-case-snake-case-pascal-case/](https://khalilstemmler.com/blogs/camel-case-snake-case-pascal-case/) for more details 

## Dart files organization

```
+lib/
    + main.dart
    + config.dart
    + main_repository.dart
    + commons/ 
        + home_page.dart
        + drawer.dart
        + utils/
            + <useful_function_1>.dart
            + ...
        + containers/
            + ...
        + widgets/
            + ..
        + bloc/
            + ..._bloc.dart
            + ..._events.dart
            + ...states.dart
    + settings/ 
        + setting_page.dart
        + theme.dart
        + widgets/
            + ...
        + bloc/
            + ...
    + authentication/
        + login_page.dart
        + signup_page.dart
        + forgotten_password_page.dart
        + login_page.dart
        + containers/
            + ...
        + widgets/
            + ..
        + bloc/
            + ...
    + <module_name (ex:sale)>/
        + <module_name>_list.dart
        + <module_name>_details.dart
        + <module_name>_repository.dart
        + <module_name>_....dart
        + containers/
            + ...
        + widgets/
            + ..
        + models/
            + ...
        + bloc/
            + ...
    + ...
```

## Useful snippets

**lib/config.dart**

```dart
class <AppName>Config {
  static baseUrl = "...";
  static apiBaseUrl = "...";
  static apiKey1 = "...";
  ... 
  }
```

**main_repository.dart**

```dart
class MainRepository {
  static String userAgent = "<app_name> mobile/1 Flutter/2.5";
  static List<Cookie> cookies = [];

  String get getCookies {
    return cookies.join(';').toString();
  }

```
**<module_name>_repository.dart**

```dart
class <ModuleName>Repository extends MainRepository {
    Map<String, dynamic> fetch<DataName>{
        ...
        var response = await http.get(uri,
        headers: {
          "cookie": cookies.join(';').toString(),
        }, 
        body: data);
        ...
        if(success){
            ...
            return {"success":true, "<dataName>":<dataObject>};
        }else{
            ...
            return {"success":false, "message":"errorMessage"};
        }
    }
    ...
    }
```

**bloc/..._states.dart**
Always add a **loading** and **Errors** states 
```dart
...

class <ModuleName>Loading extends <ModuleName>State {}
...
class <ModuleName>Error extends <ModuleName>State {
  const <ModuleName>Error({required this.error});
  final String error;
}
...
```

**bloc/..._states.dart**
Always add a loading state and `emit` it when waiting for backend response 
```dart
on<Get<SomeData>>((event, emit) async {
      emit(<ModuleName>Loading());
      try {
        Map<String,dynamic> response = await <appName>Service.get<SomeData>(
          event.param1,
          event.param2,
          ...,
        );
        if(response['success']==true){
        emit(<ModuleNameData>Loaded(
            data: resposne['data']));
        } else {
        emit(<ModuleName>Error(error: response['message']));
        }
      } catch (e) {
        emit(<ModuleName>Error(error: e.toString()));
      }
    });
```

**main.dart** or other classes that needs **BlocProvider** creation
```dart
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  MainRepository mainService = MainRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(appNameService: mainService)
            ..add(Get<SomeEvent>()),
        ),
        ...
```

**files calling image from remote url**
```dart
Image.network(
    ...
    headers: {
        "User-Agent":
            BlocProvider.of<AuthenticationBloc>(context)
                .<appn_name>Service
                .userAgent,
        "cookie": BlocProvider.of<AuthenticationBloc>(context)
            .<appn_name>Service
            .getCookies
    },
    ...
```
