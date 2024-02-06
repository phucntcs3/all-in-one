import 'package:aio_mobile/configs/ad_configs.dart';
import 'package:aio_mobile/functions/age_func.dart';
import 'package:aio_mobile/functions/info_func.dart';
import 'package:aio_mobile/functions/length_func.dart';
import 'package:aio_mobile/functions/noise_func.dart';
import 'package:aio_mobile/functions/stopwatch_func.dart';
import 'package:aio_mobile/functions/temperature_func.dart';
import 'package:aio_mobile/functions/time_func.dart';
import 'package:aio_mobile/functions/tip_func.dart';
import 'package:aio_mobile/functions/volume_func.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/bottom_sheet_menu.dart';
import 'package:aio_mobile/widgets/bottom_sheet_settings.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';
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
  InterstitialAd? _interstitialAd;
  int count = AdConfigs.count;

  @override
  void initState() {
    super.initState();
    loadAd();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
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
                          count--;

                          if (count <= 0) {
                            setState(() {
                              _interstitialAd?.show();
                              count = AdConfigs.count;
                            });
                          }

                          CoreRouter.push(item.widget(item));
                        },
                        child: Column(
                          children: [
                            Flexible(
                              child: Hero(
                                tag: item.key,
                                child: Image.asset(
                                  item.icon,
                                  fit: BoxFit.contain,
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
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      CoreRouter.showBottomSheet(
                        builder: (context) {
                          return const BottomSheetMenu();
                        },
                      );
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  IconButton(
                    onPressed: () {
                      CoreRouter.showBottomSheet(
                        builder: (context) {
                          return const BottomSheetSettings();
                        },
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void init() async {}

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdConfigs.getInterstitialAd(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _interstitialAd?.dispose();
              loadAd();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd?.dispose();
              loadAd();
            },
            onAdClicked: (ad) {},
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  final listFunc = [
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
    FunctionModel(
      key: 'stopwatch',
      title: 'Stop watch',
      icon: 'assets/images/stopwatch.png',
      widget: (item) => StopWatchFunc(item: item),
    ),
    FunctionModel(
      key: 'noise',
      title: 'Noise meter',
      icon: 'assets/images/noise.png',
      widget: (item) => NoiseFunc(item: item),
    ),
  ];
}
