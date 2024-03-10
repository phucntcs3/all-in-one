import 'dart:async';

import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../configs/ad_configs.dart';
import '../configs/app_configs.dart';
import '../widgets/header.dart';
import '../widgets/v_space.dart';

class WheelFunc extends StatefulWidget {
  const WheelFunc({
    super.key,
    required this.item,
    this.interstitialAd,
  });

  final FunctionModel item;
  final InterstitialAd? interstitialAd;

  @override
  State<WheelFunc> createState() => _WheelFuncState();
}

class _WheelFuncState extends State<WheelFunc> {
  TextEditingController textController =
      TextEditingController(text: 'Dog\nCat\nBird');
  final defaultNames = ['Dog', 'Cat', 'Bird'];

  StreamController<int> controller = StreamController<int>();
  int value = 0;
  bool pressed = false;
  List<FortuneItem> items = [];
  String? errorText;
  List<String> names = [];
  int count = AdConfigs.count;

  void onFinish() {
    setState(() {
      pressed = false;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: _buildDialog(),
      ),
    );
  }

  List<FortuneItem> getItems(List<String> names) {
    return names
        .mapIndexed((index, name) => FortuneItem(
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              style: FortuneItemStyle(
                borderWidth: 0,
                color: colors[index % colors.length],
              ),
            ))
        .toList();
  }

  void onPressed() {
    controller.add(
      Fortune.randomInt(0, items.length),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    setState(() {
      names = defaultNames;
      items = getItems(defaultNames);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Header(item: widget.item),
              Body(
                children: [
                  _buildWheel(),
                  const VSpace(
                    space: 20,
                  ),
                  _buildArea(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArea() {
    return TextField(
      controller: textController,
      onChanged: (value) {
        var names = value.split('\n').where((e) => e != '').toList();

        if (names.length >= 2) {
          setState(() {
            this.names = names;
            errorText = null;
            items = getItems(names);
          });
        } else {
          setState(() {
            errorText = 'Enter at least 2 names';
          });
        }
      },
      keyboardType: TextInputType.multiline,
      maxLines: 7,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Enter at least 2 names...',
        errorText: errorText,
      ),
    );
  }

  Widget _buildWheel() {
    return Stack(
      children: [
        IgnorePointer(
          child: Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: FortuneWheel(
                selected: controller.stream,
                animateFirst: false,
                items: items,
                physics: CircularPanPhysics(
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate,
                ),
                onAnimationEnd: () {
                  onFinish();
                },
                onFocusItemChanged: (value) {
                  this.value = value;
                },
                indicators: const [
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: Colors.black,
                      width: 10.0,
                      height: 10.0,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: pressed
                ? null
                : () {
                    if (AppConfigs.enableAds) {
                      count--;

                      if (count <= 0) {
                        setState(() {
                          widget.interstitialAd?.show();
                          count = AdConfigs.count;
                        });
                      }
                    }

                    setState(() {
                      pressed = true;
                    });

                    controller.add(
                      Fortune.randomInt(0, items.length),
                    );
                  },
            child: Container(
              color: Colors.white.withOpacity(0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.red,
          ),
          child: const Center(
            child: Text(
              'We have a winner!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const VSpace(space: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(names[value]),
        ),
        const VSpace(space: 20),
      ],
    );
  }
}

const colors = [
  Color.fromARGB(255, 0, 128, 255),
  Color.fromARGB(255, 255, 171, 37),
  Color.fromARGB(255, 255, 60, 0),
  Color.fromARGB(255, 28, 215, 15),
  Color.fromARGB(255, 240, 37, 247),
  Color.fromARGB(255, 131, 131, 131),
];
