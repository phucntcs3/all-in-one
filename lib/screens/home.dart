import 'package:aio_mobile/configs/ad_configs.dart';
import 'package:aio_mobile/configs/app_configs.dart';
import 'package:aio_mobile/functions/age_func.dart';
import 'package:aio_mobile/functions/info_func.dart';
import 'package:aio_mobile/functions/length_func.dart';
import 'package:aio_mobile/functions/qr_func/index.dart';
import 'package:aio_mobile/functions/reminder_func/index.dart';
import 'package:aio_mobile/functions/settings_func/index.dart';
import 'package:aio_mobile/functions/stopwatch_func.dart';
import 'package:aio_mobile/functions/temperature_func.dart';
import 'package:aio_mobile/functions/time_func.dart';
import 'package:aio_mobile/functions/tip_func.dart';
import 'package:aio_mobile/functions/volume_func.dart';
import 'package:aio_mobile/functions/wheel_func.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../functions/calculator_func.dart';
import '../functions/data_func.dart';
import '../functions/weight_func.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/moon.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // TextField(
                  //   onChanged: (value) {},
                  //   decoration: const InputDecoration(
                  //     hintText: 'Search...',
                  //     prefixIcon: Icon(Icons.search),
                  //     border: OutlineInputBorder(),
                  //     contentPadding: EdgeInsets.zero,
                  //   ),
                  // ),
                  const SizedBox(height: 25),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: [
                        for (var item in listFunc)
                          InkWell(
                            onTap: () {
                              onItemPressed(item, _interstitialAd);
                            },
                            child: Column(
                              children: [
                                Flexible(
                                  child: Hero(
                                    tag: item.key,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          item.icon,
                                          fit: BoxFit.contain,
                                        ),
                                        if (item.newFeature)
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Text(
                                                'new',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VSpace(space: 6),
                                SizedBox(
                                  height: 34,
                                  child: Text(
                                    item.title,
                                    maxLines: 2,
                                    textScaleFactor: 0.9,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     // IconButton(
                  //     //   onPressed: () {
                  //     //     CoreRouter.showBottomSheet(
                  //     //       builder: (context) {
                  //     //         return const BottomSheetMenu();
                  //     //       },
                  //     //     );
                  //     //   },
                  //     //   icon: const Icon(Icons.menu),
                  //     // ),
                  //     IconButton(
                  //       onPressed: () {
                  //         CoreRouter.showBottomSheet(
                  //           builder: (context) {
                  //             return const BottomSheetSettings();
                  //           },
                  //         );
                  //       },
                  //       icon: const Icon(Icons.settings),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InterstitialAd? _interstitialAd;
  int count = AdConfigs.count;

  @override
  void initState() {
    super.initState();
    loadInterstitialAd();
  }

  void loadInterstitialAd() {
    if (AppConfigs.enableAds) {
      InterstitialAd.load(
        adUnitId: AdConfigs.getInterstitialAd(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            setState(() {
              _interstitialAd = ad;
            });

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
              },
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                ad.dispose();
                _interstitialAd?.dispose();
                loadInterstitialAd();
              },
              onAdDismissedFullScreenContent: (ad) {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                ad.dispose();
                _interstitialAd?.dispose();
                loadInterstitialAd();
              },
              onAdClicked: (ad) {},
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            // debugPrint('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  void onItemPressed(FunctionModel item, dynamic interstitialAd) {
    if (AppConfigs.enableAds) {
      count--;

      if (count <= 0) {
        setState(() {
          _interstitialAd?.show();
          count = AdConfigs.count;
        });
      }
    }

    if (item.key == 'wheel') {
      CoreRouter.push(item.widget(item, interstitialAd));
    } else {
      CoreRouter.push(item.widget(item));
    }
  }

  final listFunc = [
    FunctionModel(
      key: 'wheel',
      title: 'Random Wheel',
      icon: 'assets/images/wheel.png',
      widget: (item, interstitialAd) =>
          WheelFunc(item: item, interstitialAd: interstitialAd),
      newFeature: true,
    ),
    FunctionModel(
      key: 'qr',
      title: 'Qr code',
      icon: 'assets/images/qr.png',
      widget: (item) => QrFunc(item: item),
    ),
    FunctionModel(
      key: 'settings',
      title: 'Settings',
      icon: 'assets/images/settings.png',
      widget: (item) => SettingsFunc(item: item),
    ),
    FunctionModel(
      key: 'reminder',
      title: 'Reminder',
      icon: 'assets/images/reminder.png',
      widget: (item) => ReminderFunc(item: item),
    ),
    FunctionModel(
      key: 'stopwatch',
      title: 'Stop watch',
      icon: 'assets/images/stopwatch.png',
      widget: (item) => StopWatchFunc(item: item),
    ),
    FunctionModel(
      key: 'cake',
      title: 'Age',
      icon: 'assets/images/cake.png',
      widget: (item) => AgeFunc(item: item),
    ),
    FunctionModel(
      key: 'tip',
      title: 'Tip',
      icon: 'assets/images/tip.png',
      widget: (item) => TipFunc(item: item),
    ),
    FunctionModel(
      key: 'data',
      title: 'Data',
      icon: 'assets/images/data.png',
      widget: (item) => DataFunc(item: item),
    ),
    FunctionModel(
      key: 'length',
      title: 'Length',
      icon: 'assets/images/length.png',
      widget: (item) => LengthFunc(item: item),
    ),
    FunctionModel(
      key: 'volume',
      title: 'Volume',
      icon: 'assets/images/volume.png',
      widget: (item) => VolumeFunc(item: item),
    ),
    FunctionModel(
      key: 'temperature',
      title: 'Temperature',
      icon: 'assets/images/temperature.png',
      widget: (item) => TemperatureFunc(item: item),
    ),
    FunctionModel(
      key: 'time',
      title: 'Time',
      icon: 'assets/images/time.png',
      widget: (item) => TimeFunc(item: item),
    ),
    FunctionModel(
      key: 'weight',
      title: 'Weight',
      icon: 'assets/images/weight.png',
      widget: (item) => WeightFunc(item: item),
    ),
    FunctionModel(
      key: 'info',
      title: 'Device Information',
      icon: 'assets/images/info.png',
      widget: (item) => InfoFunc(item: item),
    ),
    FunctionModel(
      key: 'calculator',
      title: 'Calculator',
      icon: 'assets/images/calculator.png',
      widget: (item) => CalculatorFunc(item: item),
    ),
  ];
}
