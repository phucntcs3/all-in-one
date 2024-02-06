import 'package:aio_mobile/extensions/string_ext.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/v_space.dart';

class VolumeFunc extends StatefulWidget {
  const VolumeFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<VolumeFunc> createState() => VolumeFuncState();
}

class VolumeFuncState extends State<VolumeFunc> {
  final TextEditingController literController = TextEditingController();
  final TextEditingController milliliterController = TextEditingController();
  final TextEditingController gallonController = TextEditingController();
  final TextEditingController cubicMeterController = TextEditingController();

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
                    controller: literController,
                    title: 'Liters:',
                    placeholder: 'Liters',
                    onChanged: (value) => convertFromLiter(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: milliliterController,
                    title: 'Milliliters:',
                    placeholder: 'Milliliters',
                    onChanged: (value) =>
                        convertFromMilliliter(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: gallonController,
                    title: 'Gallons:',
                    placeholder: 'Gallons',
                    onChanged: (value) => convertFromGallon(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: cubicMeterController,
                    title: 'Cubic Meters:',
                    placeholder: 'Cubic Meters',
                    onChanged: (value) =>
                        convertFromCubicMeter(value.toDouble()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convertFromLiter(double value) {
    setState(() {
      milliliterController.text = (value * 1000).toString();
      gallonController.text = (value * 0.264172).toString();
      cubicMeterController.text = (value * 0.001).toString();
    });
  }

  void convertFromMilliliter(double value) {
    setState(() {
      literController.text = (value * 0.001).toString();
      gallonController.text = (value * 0.000264172).toString();
      cubicMeterController.text = (value * 1e-6).toString();
    });
  }

  void convertFromGallon(double value) {
    setState(() {
      literController.text = (value * 3.78541).toString();
      milliliterController.text = (value * 3785.41).toString();
      cubicMeterController.text = (value * 0.00378541).toString();
    });
  }

  void convertFromCubicMeter(double value) {
    setState(() {
      literController.text = (value * 1000).toString();
      milliliterController.text = (value * 1e+6).toString();
      gallonController.text = (value * 264.172).toString();
    });
  }
}
