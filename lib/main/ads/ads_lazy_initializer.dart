import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsLazyInitializer {
  factory AdsLazyInitializer([MobileAds? mobileAds]) => _instance =
      _instance ?? AdsLazyInitializer._(mobileAds ?? MobileAds.instance);

  AdsLazyInitializer._(MobileAds mobileAds) : _mobileAds = mobileAds;

  static AdsLazyInitializer? _instance;

  final Completer<void> _initialized = Completer();
  final MobileAds _mobileAds;

  bool get isInitialized => _initialized.isCompleted;

  Future<void> waitUntilInitialized() => _initialized.future;

  Future<void> initialize() async {
    try {
      await _mobileAds.initialize();
      await [
        _mobileAds.setAppMuted(false),
        _mobileAds.updateRequestConfiguration(RequestConfiguration()),
      ].wait;
    } finally {
      _initialized.complete();
    }
  }
}
