import 'package:aio_mobile/extensions/string_ext.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/v_space.dart';

class DataFunc extends StatefulWidget {
  const DataFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<DataFunc> createState() => _DataFuncState();
}

class _DataFuncState extends State<DataFunc> {
  final TextEditingController tbController = TextEditingController();
  final TextEditingController gbController = TextEditingController();
  final TextEditingController mbController = TextEditingController();
  final TextEditingController kbController = TextEditingController();
  final TextEditingController byteController = TextEditingController();
  final TextEditingController bitController = TextEditingController();

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
                    controller: tbController,
                    title: 'Terabyte:',
                    placeholder: 'Terabyte',
                    onChanged: (value) => convertFromTb(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: gbController,
                    title: 'Gigabyte:',
                    placeholder: 'Gigabyte',
                    onChanged: (value) => convertFromGb(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: mbController,
                    title: 'Megabyte:',
                    placeholder: 'Megabyte',
                    onChanged: (value) => convertFromMb(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: kbController,
                    title: 'Kilobyte:',
                    placeholder: 'Kilobyte',
                    onChanged: (value) => convertFromKb(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: byteController,
                    title: 'Byte:',
                    placeholder: 'Byte',
                    onChanged: (value) => convertFromByte(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: bitController,
                    title: 'Bit:',
                    placeholder: 'Bit',
                    onChanged: (value) => convertFromBit(value.toDouble()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convertFromTb(double value) {
    setState(() {
      gbController.text = (value * 1024).toStringAsFixed(2);
      mbController.text = (value * 1024 * 1024).toStringAsFixed(2);
      kbController.text = (value * 1024 * 1024 * 1024).toStringAsFixed(2);
      byteController.text =
          (value * 1024 * 1024 * 1024 * 1024).toStringAsFixed(2);
      bitController.text =
          (value * 1024 * 1024 * 1024 * 1024 * 8).toStringAsFixed(2);
    });
  }

  void convertFromGb(double value) {
    setState(() {
      tbController.text = (value / 1024).toStringAsFixed(2);
      mbController.text = (value * 1024).toStringAsFixed(2);
      kbController.text = (value * 1024 * 1024).toStringAsFixed(2);
      byteController.text = (value * 1024 * 1024 * 1024).toStringAsFixed(2);
      bitController.text = (value * 1024 * 1024 * 1024 * 8).toStringAsFixed(2);
    });
  }

  void convertFromMb(double value) {
    setState(() {
      tbController.text = (value / (1024 * 1024)).toStringAsFixed(2);
      gbController.text = (value / 1024).toStringAsFixed(2);
      kbController.text = (value * 1024).toStringAsFixed(2);
      byteController.text = (value * 1024 * 1024).toStringAsFixed(2);
      bitController.text = (value * 1024 * 1024 * 8).toStringAsFixed(2);
    });
  }

  void convertFromKb(double value) {
    setState(() {
      tbController.text = (value / (1024 * 1024 * 1024)).toStringAsFixed(2);
      gbController.text = (value / (1024 * 1024)).toStringAsFixed(2);
      mbController.text = (value / 1024).toStringAsFixed(2);
      byteController.text = (value * 1024).toStringAsFixed(2);
      bitController.text = (value * 1024 * 8).toStringAsFixed(2);
    });
  }

  void convertFromByte(double value) {
    setState(() {
      tbController.text =
          (value / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(2);
      gbController.text = (value / (1024 * 1024 * 1024)).toStringAsFixed(2);
      mbController.text = (value / (1024 * 1024)).toStringAsFixed(2);
      kbController.text = (value / 1024).toStringAsFixed(2);
      bitController.text = (value * 8).toStringAsFixed(2);
    });
  }

  void convertFromBit(double value) {
    setState(() {
      tbController.text =
          (value / (1024 * 1024 * 1024 * 1024 * 8)).toStringAsFixed(2);
      gbController.text = (value / (1024 * 1024 * 1024 * 8)).toStringAsFixed(2);
      mbController.text = (value / (1024 * 1024 * 8)).toStringAsFixed(2);
      kbController.text = (value / (1024 * 8)).toStringAsFixed(2);
      byteController.text = (value / 8).toStringAsFixed(2);
    });
  }
}
