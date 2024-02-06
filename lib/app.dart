import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'configs/ad_configs.dart';
import 'router/core_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: CoreRouter.onGenerateRoute,
      builder: (context, child) {
        return Stack(
          children: [
            // Main App
            Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(child: child),
                ),
                if (_bannerAd != null)
                  SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  )
              ],
            ),
            // Other
          ],
        );
      },
    );
  }

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdConfigs.getBannerAd(),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }
}