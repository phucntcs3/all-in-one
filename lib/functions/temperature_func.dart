import 'package:aio_mobile/extensions/string_ext.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/v_space.dart';

class TemperatureFunc extends StatefulWidget {
  const TemperatureFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<TemperatureFunc> createState() => TemperatureFuncState();
}

class TemperatureFuncState extends State<TemperatureFunc> {
  final TextEditingController celsiusController = TextEditingController();
  final TextEditingController fahrenheitController = TextEditingController();
  final TextEditingController kelvinController = TextEditingController();
  final TextEditingController rankineController = TextEditingController();
  final TextEditingController newtonController = TextEditingController();
  final TextEditingController delisleController = TextEditingController();

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
                    controller: celsiusController,
                    title: 'Celsius:',
                    placeholder: 'Celsius',
                    onChanged: (value) => convertFromCelsius(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: fahrenheitController,
                    title: 'Fahrenheit:',
                    placeholder: 'Fahrenheit',
                    onChanged: (value) =>
                        convertFromFahrenheit(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: kelvinController,
                    title: 'Kelvin:',
                    placeholder: 'Kelvin',
                    onChanged: (value) => convertFromKelvin(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: rankineController,
                    title: 'Rankine:',
                    placeholder: 'Rankine',
                    onChanged: (value) => convertFromRankine(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: newtonController,
                    title: 'Newton:',
                    placeholder: 'Newton',
                    onChanged: (value) => convertFromNewton(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: delisleController,
                    title: 'Delisle:',
                    placeholder: 'Delisle',
                    onChanged: (value) => convertFromDelisle(value.toDouble()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convertFromCelsius(double value) {
    setState(() {
      fahrenheitController.text = ((value * 9 / 5) + 32).toString();
      kelvinController.text = (value + 273.15).toString();
      rankineController.text = ((value + 273.15) * 9 / 5).toString();
      newtonController.text = (value * 33 / 100).toString();
      delisleController.text = ((100 - value) * 3 / 2).toString();
    });
  }

  void convertFromFahrenheit(double value) {
    setState(() {
      celsiusController.text = ((value - 32) * 5 / 9).toString();
      kelvinController.text = ((value - 32) * 5 / 9 + 273.15).toString();
      rankineController.text = (value + 459.67).toString();
      newtonController.text = ((value - 32) * 11 / 60).toString();
      delisleController.text = ((212 - value) * 5 / 6).toString();
    });
  }

  void convertFromKelvin(double value) {
    setState(() {
      celsiusController.text = (value - 273.15).toString();
      fahrenheitController.text = ((value - 273.15) * 9 / 5 + 32).toString();
      rankineController.text = (value * 9 / 5).toString();
      newtonController.text = ((value - 273.15) * 33 / 100).toString();
      delisleController.text = ((373.15 - value) * 3 / 2).toString();
    });
  }

  void convertFromRankine(double value) {
    setState(() {
      celsiusController.text = ((value - 491.67) * 5 / 9).toString();
      fahrenheitController.text = (value - 459.67).toString();
      kelvinController.text = (value * 5 / 9).toString();
      newtonController.text = ((value - 491.67) * 11 / 60).toString();
      delisleController.text = ((671.67 - value) * 5 / 6).toString();
    });
  }

  void convertFromNewton(double value) {
    setState(() {
      celsiusController.text = (value * 100 / 33).toString();
      fahrenheitController.text = (value * 60 / 11 + 32).toString();
      kelvinController.text = (value * 100 / 33 + 273.15).toString();
      rankineController.text = (value * 60 / 11 + 491.67).toString();
      delisleController.text = ((33 - value) * 50 / 11).toString();
    });
  }

  void convertFromDelisle(double value) {
    setState(() {
      celsiusController.text = ((100 - value) * 2 / 3).toString();
      fahrenheitController.text = (212 - value * 6 / 5).toString();
      kelvinController.text = (373.15 - value * 2 / 3).toString();
      rankineController.text = (671.67 - value * 6 / 5).toString();
      newtonController.text = (33 - value * 11 / 50).toString();
    });
  }
}
