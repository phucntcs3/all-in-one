import 'dart:io';

import 'package:aio_mobile/configs/app_configs.dart';

class AdConfigs {
  static const int count = 7;

  static const String _androidBannerTest =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _iosBannerTest = 'ca-app-pub-3940256099942544/2934735716';

  static const String _androidInterstitialTest =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _iosInterstitialTest =
      'ca-app-pub-3940256099942544/4411468910';

  //

  static const String _androidBannerPro =
      "ca-app-pub-5953802733490905/7412337534";
  static const String _androidInterstitialPro =
      "ca-app-pub-5953802733490905/8589101107";

  static String getBannerAd() {
    if (Platform.isIOS) {
      return _iosBannerTest;
    }

    return AppConfigs.isTest ? _androidBannerTest : _androidBannerPro;
  }

  static String getInterstitialAd() {
    if (Platform.isIOS) {
      return _iosInterstitialTest;
    }

    return AppConfigs.isTest
        ? _androidInterstitialTest
        : _androidInterstitialPro;
  }
}
