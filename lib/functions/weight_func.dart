import 'package:aio_mobile/extensions/string_ext.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/v_space.dart';

class WeightFunc extends StatefulWidget {
  const WeightFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<WeightFunc> createState() => WeightFuncState();
}

class WeightFuncState extends State<WeightFunc> {
  final TextEditingController kilogramController = TextEditingController();
  final TextEditingController hectogramController = TextEditingController();
  final TextEditingController decagramController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  final TextEditingController poundController = TextEditingController();
  final TextEditingController ounceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(item: widget.item),
              Body(
                children: [
                  InputNumber(
                    controller: kilogramController,
                    title: 'Kilograms:',
                    placeholder: 'Kilograms',
                    onChanged: (value) =>
                        convertFromKilograms(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: hectogramController,
                    title: 'Hectograms:',
                    placeholder: 'Hectograms',
                    onChanged: (value) =>
                        convertFromHectograms(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: decagramController,
                    title: 'Decagrams:',
                    placeholder: 'Decagrams',
                    onChanged: (value) =>
                        convertFromDecagrams(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: gramController,
                    title: 'Grams:',
                    placeholder: 'Grams',
                    onChanged: (value) => convertFromGrams(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: poundController,
                    title: 'Pounds:',
                    placeholder: 'Pounds',
                    onChanged: (value) => convertFromPounds(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: ounceController,
                    title: 'Ounces:',
                    placeholder: 'Ounces',
                    onChanged: (value) => convertFromOunces(value.toDouble()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convertFromKilograms(double value) {
    setState(() {
      hectogramController.text = (value * 10).toString();
      decagramController.text = (value * 100).toString();
      gramController.text = (value * 1000).toString();
      poundController.text = (value * 2.20462).toString();
      ounceController.text = (value * 35.274).toString();
    });
  }

  void convertFromHectograms(double value) {
    setState(() {
      kilogramController.text = (value / 10).toString();
      decagramController.text = (value * 10).toString();
      gramController.text = (value * 100).toString();
      poundController.text = (value * 0.220462).toString();
      ounceController.text = (value * 3.5274).toString();
    });
  }

  void convertFromDecagrams(double value) {
    setState(() {
      kilogramController.text = (value / 100).toString();
      hectogramController.text = (value / 10).toString();
      gramController.text = (value * 10).toString();
      poundController.text = (value * 0.0220462).toString();
      ounceController.text = (value * 0.35274).toString();
    });
  }

  void convertFromGrams(double value) {
    setState(() {
      kilogramController.text = (value / 1000).toString();
      hectogramController.text = (value / 100).toString();
      decagramController.text = (value / 10).toString();
      poundController.text = (value * 0.00220462).toString();
      ounceController.text = (value * 0.035274).toString();
    });
  }

  void convertFromPounds(double value) {
    setState(() {
      kilogramController.text = (value / 2.20462).toString();
      hectogramController.text = (value / 0.220462).toString();
      decagramController.text = (value / 0.0220462).toString();
      gramController.text = (value / 0.00220462).toString();
      ounceController.text = (value * 16).toString();
    });
  }

  void convertFromOunces(double value) {
    setState(() {
      kilogramController.text = (value / 35.274).toString();
      hectogramController.text = (value / 3.5274).toString();
      decagramController.text = (value / 0.35274).toString();
      gramController.text = (value / 0.035274).toString();
      poundController.text = (value / 16).toString();
    });
  }
}
