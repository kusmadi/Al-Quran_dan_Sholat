import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  late RewardedAd _rewardedAd;
  bool _isRewardedAdLoaded = false;

  late NativeAd _nativeAd;
  bool _isNativeAdLoaded = false;

  AdState({bool test = false}) {
    if (test) {
      initTestAd();
    }
  }

  String get unitId {
    List<String> adUnit = [
      'ca-app-pub-4813901769436696/5482640782',
      'ca-app-pub-4813901769436696/2173649163',
      'ca-app-pub-4813901769436696/6993591969',
      'ca-app-pub-4813901769436696/4429111562',
      'ca-app-pub-4813901769436696/4568712360',
      'ca-app-pub-4813901769436696/3393725163',
      'ca-app-pub-4813901769436696/6534215612',
      'ca-app-pub-4813901769436696/6098283102',
      'ca-app-pub-4813901769436696/8777235579'
    ];
    if (Platform.isAndroid) {
      return adUnit[Random().nextInt(adUnit.length)];
    } else {
      return adUnit[Random().nextInt(adUnit.length)];
    }
  }

  initTestAd() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String deviceId = "";
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    print('request: $deviceId');
    final RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: <String>[deviceId, '71026F5E37812E1AC393DE2324309582'],
    );
    await MobileAds.instance.updateRequestConfiguration(configuration);
  }

  ///Banner
  initBanner() {
    _bottomBannerAd = BannerAd(
      adUnitId: unitId,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBottomBannerAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          _isBottomBannerAdLoaded = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    _bottomBannerAd.load();
  }

  get isBottomBannerAdLoaded {
    return _isBottomBannerAdLoaded;
  }

  bannerDispose() {
    _bottomBannerAd.dispose();
  }

  displayBanner() {
    return SizedBox(
      height: _bottomBannerAd.size.height.toDouble(),
      width: _bottomBannerAd.size.width.toDouble(),
      child: AdWidget(ad: _bottomBannerAd),
    );
  }

  ///Interstitial
  bool initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isInterstitialAdLoaded = false;
          _interstitialAd?.dispose();
        },
      ),
    );
    return _isInterstitialAdLoaded;
  }

  interstitialAdShow() {
    _interstitialAd?.show();
  }

  interstitialAdDispose() {
    _interstitialAd?.dispose();
  }

  ///reward
  bool initReward() {
    RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _isRewardedAdLoaded = false;
            },
          );
          _isRewardedAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _isRewardedAdLoaded = false;
        },
      ),
    );
    return _isRewardedAdLoaded = false;
    ;
  }

  get isRewardedAdLoaded {
    return _isRewardedAdLoaded;
  }

  rewardShow() {
    _rewardedAd.show(
      onUserEarnedReward: (ad, reward) {
        // perform operation when earned rewards
      },
    );
  }

  rewardDispose() {
    _interstitialAd?.dispose();
  }

  bool initNative(String factoryId) {
    final NativeAdListener listener = NativeAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        _isNativeAdLoaded = true;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        _isNativeAdLoaded = false;
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
      // Called when a click is recorded for a NativeAd.
      onAdClicked: (Ad ad) => print('Ad clicked.'),
    );

    const AdRequest request = AdRequest(
      keywords: <String>[
        'mobil',
        'motor',
        'rumah',
        'hosting',
        'payment',
        'oil'
      ],
      contentUrl:
          'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-4813901769436696',
      nonPersonalizedAds: true,
    );
    NativeAd(
        adUnitId: unitId,
        factoryId: factoryId,
        listener: listener,
        request: request);
    return _isNativeAdLoaded;
  }

  get isNativeAdLoaded {
    return _isNativeAdLoaded;
  }

  displayNative(nativeContext) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(nativeContext).size.width - 20,
      child: AdWidget(ad: _nativeAd),
    );
  }
}
