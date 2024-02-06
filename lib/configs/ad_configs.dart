import 'dart:io';

class AdConfigs {
  static const int count = 7;

  static const String _androidBannerAdTest =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _iosBannerAdTest =
      'ca-app-pub-3940256099942544/2934735716';

  static const String _androidInterstitialAdTest =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _iosInterstitialAdTest =
      'ca-app-pub-3940256099942544/4411468910';

  static String getBannerAd() {
    if (Platform.isIOS) {
      return _iosBannerAdTest;
    }

    return _androidBannerAdTest;
  }

  static String getInterstitialAd() {
    if (Platform.isIOS) {
      return _iosInterstitialAdTest;
    }

    return _androidInterstitialAdTest;
  }
}
