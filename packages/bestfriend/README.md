# bestfriend

"Bestfriend" is my goto self assembled flutter architecture which is based on Provider architecture and get_it.

I have assembled every bit that I think is required for any project to start with.

"bestfriend" includes services for navigation, api calls, shared preference and snackbars. It also exports some other external packages like flutter_toast and flutter_screenutil so that you don't have to add manually everytime. 

## How to install
Installation is as simple as calculating `0 + 0`
```
dependencies:
    ...

    bestfriend:
        git:
        url: git://github.com/ayyshim/bestfriend
    
    ...
```

🥂 Cheers! Bestfriend is now all set.

## Pre-setup
There are few steps that you need to do before start using *bestfriend*.

1. Create a `setup_locator.dart` file inside lib folder. And copy following code:
```dart
import 'package:bestfriend/bestfriend.dart';

Future<void> setupLocator() async {
    // Add below line if you want snackbars on your app.
    locator.registerLazySingleton<SnackbarService>(() => SnackbarServiceImplementation());

    // Add below line if you want navigation on your app.
    locator.registerLazySingleton<NavigationService>(() => NavigationServiceImplementation());
}

```
2. Now goto `main.dart` file and add following code inside `main()` function
```dart
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await setupLocator();

    ...
}
```
> Since our setupLocator() function returns a `Future` and we need to make sure that all our services are loaded we need to put `await` infront of it while invoking it so we need to make our `main()` function return `Future<void>` instead of `void` and add `async`.

----
You can checkout [example](./example) project to understand how `view`, `viewmodel`, `navigation` and other bits are used.