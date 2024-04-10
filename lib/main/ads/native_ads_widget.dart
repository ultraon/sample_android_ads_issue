import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sample_android_ads_issue/main/ads/ads_lazy_initializer.dart';

class NativeAdsWidget extends StatefulWidget {
  const NativeAdsWidget({super.key});

  @override
  State<NativeAdsWidget> createState() => _NativeAdsWidgetState();
}

class _NativeAdsWidgetState extends State<NativeAdsWidget> {
  AdWithView? _ad;

  @override
  void initState() {
    super.initState();
    AdsLazyInitializer().waitUntilInitialized().then((_) {
      createNativeTemplateAd().then((ad) {
        setState(() {
          _ad = ad;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: _ad == null
            ? const CircularProgressIndicator()
            : AspectRatio(
                aspectRatio: 1,
                child: AdWidget(ad: _ad!),
              ),
      ),
    );
  }

  Future<NativeAd?> createNativeTemplateAd() async {
    final completer = Completer<NativeAd?>();
    await NativeAd.fromAdManagerRequest(
      adUnitId: '/6499/example/native-video',
      adManagerRequest: const AdManagerAdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          completer.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (ad, error) {
          final stackTrace = StackTrace.current;
          ad.dispose();
          completer.completeError(error, stackTrace);
        },
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
      ),
      nativeAdOptions: NativeAdOptions(
        videoOptions: VideoOptions(
          startMuted: false,
        ),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
      ),
    ).load();
    return completer.future;
  }
}
