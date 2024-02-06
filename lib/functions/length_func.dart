import 'package:aio_mobile/extensions/string_ext.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/v_space.dart';

class LengthFunc extends StatefulWidget {
  const LengthFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<LengthFunc> createState() => LengthFuncState();
}

class LengthFuncState extends State<LengthFunc> {
  final TextEditingController kmController = TextEditingController();
  final TextEditingController mController = TextEditingController();
  final TextEditingController cmController = TextEditingController();
  final TextEditingController mmController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController footController = TextEditingController();
  final TextEditingController mileController = TextEditingController();
  final TextEditingController yardController = TextEditingController();

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
                    controller: kmController,
                    title: 'Kilometer:',
                    placeholder: 'Kilometer',
                    onChanged: (value) => convertFromKm(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: mController,
                    title: 'Meter:',
                    placeholder: 'Meter',
                    onChanged: (value) => convertFromM(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: cmController,
                    title: 'Centimeter:',
                    placeholder: 'Centimeter',
                    onChanged: (value) => convertFromCm(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: mmController,
                    title: 'Millimeter:',
                    placeholder: 'Millimeter',
                    onChanged: (value) => convertFromMm(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: inchController,
                    title: 'Inch:',
                    placeholder: 'Inch',
                    onChanged: (value) => convertFromInch(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: footController,
                    title: 'Foot:',
                    placeholder: 'Foot',
                    onChanged: (value) => convertFromFoot(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: mileController,
                    title: 'Mile:',
                    placeholder: 'Mile',
                    onChanged: (value) => convertFromMile(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: yardController,
                    title: 'Yard:',
                    placeholder: 'Yard',
                    onChanged: (value) => convertFromYard(value.toDouble()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convertFromKm(double value) {
    setState(() {
      mController.text = (value * 1000).toString();
      cmController.text = (value * 100000).toString();
      mmController.text = (value * 1e+6).toString();
      inchController.text = (value * 39370.1).toString();
      footController.text = (value * 3280.84).toString();
      mileController.text = (value * 0.621371).toString();
      yardController.text = (value * 1093.61).toString();
    });
  }

  void convertFromM(double value) {
    setState(() {
      kmController.text = (value / 1000).toString();
      cmController.text = (value * 100).toString();
      mmController.text = (value * 1000).toString();
      inchController.text = (value * 39.3701).toString();
      footController.text = (value * 3.28084).toString();
      mileController.text = (value * 0.000621371).toString();
      yardController.text = (value * 1.09361).toString();
    });
  }

  void convertFromCm(double value) {
    setState(() {
      kmController.text = (value / 100000).toString();
      mController.text = (value / 100).toString();
      mmController.text = (value * 10).toString();
      inchController.text = (value * 0.393701).toString();
      footController.text = (value * 0.0328084).toString();
      mileController.text = (value * 0.00000621371).toString();
      yardController.text = (value * 0.0109361).toString();
    });
  }

  void convertFromMm(double value) {
    setState(() {
      kmController.text = (value / 1e+6).toString();
      mController.text = (value / 1000).toString();
      cmController.text = (value / 10).toString();
      inchController.text = (value * 0.0393701).toString();
      footController.text = (value * 0.00328084).toString();
      mileController.text = (value * 0.000000621371).toString();
      yardController.text = (value * 0.00109361).toString();
    });
  }

  void convertFromInch(double value) {
    setState(() {
      kmController.text = (value * 0.0254).toString();
      mController.text = (value * 0.0254).toString();
      cmController.text = (value * 2.54).toString();
      mmController.text = (value * 25.4).toString();
      footController.text = (value * 0.0833333).toString();
      mileController.text = (value * 0.000015783).toString();
      yardController.text = (value * 0.0277778).toString();
    });
  }

  void convertFromFoot(double value) {
    setState(() {
      kmController.text = (value * 0.3048).toString();
      mController.text = (value * 0.3048).toString();
      cmController.text = (value * 30.48).toString();
      mmController.text = (value * 304.8).toString();
      inchController.text = (value * 12.0).toString();
      mileController.text = (value * 0.000189394).toString();
      yardController.text = (value * 0.333333).toString();
    });
  }

  void convertFromMile(double value) {
    setState(() {
      kmController.text = (value * 1609.34).toString();
      mController.text = (value * 1609.34).toString();
      cmController.text = (value * 160934).toString();
      mmController.text = (value * 1609340).toString();
      inchController.text = (value * 63360).toString();
      footController.text = (value * 5280).toString();
      yardController.text = (value * 1760).toString();
    });
  }

  void convertFromYard(double value) {
    setState(() {
      kmController.text = (value * 0.9144).toString();
      mController.text = (value * 0.9144).toString();
      cmController.text = (value * 91.44).toString();
      mmController.text = (value * 914.4).toString();
      inchController.text = (value * 36).toString();
      footController.text = (value * 3).toString();
      mileController.text = (value * 0.000568182).toString();
    });
  }
}
