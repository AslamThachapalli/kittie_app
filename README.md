# kittie_app

An app that showcase all breeds of cats.

## Building From Source

1. Clone the app
2. Excecute 
```
flutter pub get
```
3. For code generation, excecute 
```
flutter pub run build_runner build --delete-conflicting-outputs
```
4. For adding your api_key, create the file `lib/core/constants/api_key.dart` and add `const String apiKey = <Your Api Key>`
5. Now run the app
```
flutter run
```
