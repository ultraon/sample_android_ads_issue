# Sample Android Ads Issue

It is a sample app to see the video Ads playback issue on Android.
The issue is that the video Ads are not pausing when the ads widget frame isn't visible on Android devices.
On iOS it works fine.

The original issue is created here https://github.com/googleads/googleads-mobile-flutter/issues/1047

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart
```