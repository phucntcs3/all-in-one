import 'package:aio_mobile/extensions/string_ext.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/v_space.dart';

class TimeFunc extends StatefulWidget {
  const TimeFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<TimeFunc> createState() => TimeFuncState();
}

class TimeFuncState extends State<TimeFunc> {
  final TextEditingController millisecondController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController weekController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController decadeController = TextEditingController();
  final TextEditingController centuryController = TextEditingController();

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
                    controller: millisecondController,
                    title: 'Milliseconds:',
                    placeholder: 'Milliseconds',
                    onChanged: (value) =>
                        convertFromMilliseconds(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: secondController,
                    title: 'Seconds:',
                    placeholder: 'Seconds',
                    onChanged: (value) => convertFromSeconds(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: minuteController,
                    title: 'Minutes:',
                    placeholder: 'Minutes',
                    onChanged: (value) => convertFromMinutes(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: hourController,
                    title: 'Hours:',
                    placeholder: 'Hours',
                    onChanged: (value) => convertFromHours(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: dayController,
                    title: 'Days:',
                    placeholder: 'Days',
                    onChanged: (value) => convertFromDays(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: weekController,
                    title: 'Weeks:',
                    placeholder: 'Weeks',
                    onChanged: (value) => convertFromWeeks(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: monthController,
                    title: 'Months:',
                    placeholder: 'Months',
                    onChanged: (value) => convertFromMonths(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: yearController,
                    title: 'Years:',
                    placeholder: 'Years',
                    onChanged: (value) => convertFromYears(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: decadeController,
                    title: 'Decades:',
                    placeholder: 'Decades',
                    onChanged: (value) => convertFromDecades(value.toDouble()),
                  ),
                  const VSpace(),
                  InputNumber(
                    controller: centuryController,
                    title: 'Centuries:',
                    placeholder: 'Centuries',
                    onChanged: (value) =>
                        convertFromCenturies(value.toDouble()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void convertFromMilliseconds(double value) {
    setState(() {
      secondController.text = (value / 1000).toString();
      minuteController.text = (value / (1000 * 60)).toString();
      hourController.text = (value / (1000 * 60 * 60)).toString();
      dayController.text = (value / (1000 * 60 * 60 * 24)).toString();
      weekController.text = (value / (1000 * 60 * 60 * 24 * 7)).toString();
      monthController.text = (value / (1000 * 60 * 60 * 24 * 30)).toString();
      yearController.text = (value / (1000 * 60 * 60 * 24 * 365)).toString();
      decadeController.text =
          (value / (1000 * 60 * 60 * 24 * 365 * 10)).toString();
      centuryController.text =
          (value / (1000 * 60 * 60 * 24 * 365 * 100)).toString();
    });
  }

  void convertFromSeconds(double value) {
    setState(() {
      millisecondController.text = (value * 1000).toString();
      minuteController.text = (value / 60).toString();
      hourController.text = (value / 3600).toString();
      dayController.text = (value / 86400).toString();
      weekController.text = (value / (86400 * 7)).toString();
      monthController.text = (value / (86400 * 30)).toString();
      yearController.text = (value / (86400 * 365)).toString();
      decadeController.text = (value / (86400 * 365 * 10)).toString();
      centuryController.text = (value / (86400 * 365 * 100)).toString();
    });
  }

  void convertFromMinutes(double value) {
    setState(() {
      millisecondController.text = (value * 60 * 1000).toString();
      secondController.text = (value * 60).toString();
      hourController.text = (value / 60).toString();
      dayController.text = (value / (60 * 24)).toString();
      weekController.text = (value / (60 * 24 * 7)).toString();
      monthController.text = (value / (60 * 24 * 30)).toString();
      yearController.text = (value / (60 * 24 * 365)).toString();
      decadeController.text = (value / (60 * 24 * 365 * 10)).toString();
      centuryController.text = (value / (60 * 24 * 365 * 100)).toString();
    });
  }

  void convertFromHours(double value) {
    setState(() {
      millisecondController.text = (value * 60 * 60 * 1000).toString();
      secondController.text = (value * 3600).toString();
      minuteController.text = (value * 60).toString();
      dayController.text = (value / 24).toString();
      weekController.text = (value / (24 * 7)).toString();
      monthController.text = (value / (24 * 30)).toString();
      yearController.text = (value / (24 * 365)).toString();
      decadeController.text = (value / (24 * 365 * 10)).toString();
      centuryController.text = (value / (24 * 365 * 100)).toString();
    });
  }

  void convertFromDays(double value) {
    setState(() {
      millisecondController.text = (value * 24 * 60 * 60 * 1000).toString();
      secondController.text = (value * 86400).toString();
      minuteController.text = (value * 24 * 60).toString();
      hourController.text = (value * 24).toString();
      weekController.text = (value / 7).toString();
      monthController.text = (value * 30.436875).toString();
      yearController.text = (value / 365).toString();
      decadeController.text = (value / (365 * 10)).toString();
      centuryController.text = (value / (365 * 100)).toString();
    });
  }

  void convertFromWeeks(double value) {
    setState(() {
      millisecondController.text = (value * 7 * 24 * 60 * 60 * 1000).toString();
      secondController.text = (value * 7 * 86400).toString();
      minuteController.text = (value * 7 * 24 * 60).toString();
      hourController.text = (value * 7 * 24).toString();
      dayController.text = (value * 7).toString();
      monthController.text = (value * 4.34524).toString();
      yearController.text = (value / 52.1429).toString();
      decadeController.text = (value / (52.1429 * 10)).toString();
      centuryController.text = (value / (52.1429 * 100)).toString();
    });
  }

  void convertFromMonths(double value) {
    setState(() {
      millisecondController.text =
          (value * 30.436875 * 24 * 60 * 60 * 1000).toString();
      secondController.text = (value * 30.436875 * 86400).toString();
      minuteController.text = (value * 30.436875 * 24 * 60).toString();
      hourController.text = (value * 30.436875 * 24).toString();
      dayController.text = (value * 30.436875).toString();
      weekController.text = (value / 4.34524).toString();
      yearController.text = (value / 12).toString();
      decadeController.text = (value / (12 * 10)).toString();
      centuryController.text = (value / (12 * 100)).toString();
    });
  }

  void convertFromYears(double value) {
    setState(() {
      millisecondController.text =
          (value * 365 * 24 * 60 * 60 * 1000).toString();
      secondController.text = (value * 365 * 86400).toString();
      minuteController.text = (value * 365 * 24 * 60).toString();
      hourController.text = (value * 365 * 24).toString();
      dayController.text = (value * 365).toString();
      weekController.text = (value * 52.1429).toString();
      monthController.text = (value * 12).toString();
      decadeController.text = (value / 10).toString();
      centuryController.text = (value / 100).toString();
    });
  }

  void convertFromDecades(double value) {
    setState(() {
      millisecondController.text =
          (value * 3650 * 24 * 60 * 60 * 1000).toString();
      secondController.text = (value * 3650 * 86400).toString();
      minuteController.text = (value * 3650 * 24 * 60).toString();
      hourController.text = (value * 3650 * 24).toString();
      dayController.text = (value * 3650).toString();
      weekController.text = (value * 521.429).toString();
      monthController.text = (value * 120).toString();
      yearController.text = (value * 10).toString();
      centuryController.text = (value / 10).toString();
    });
  }

  void convertFromCenturies(double value) {
    setState(() {
      millisecondController.text =
          (value * 36500 * 24 * 60 * 60 * 1000).toString();
      secondController.text = (value * 36500 * 86400).toString();
      minuteController.text = (value * 36500 * 24 * 60).toString();
      hourController.text = (value * 36500 * 24).toString();
      dayController.text = (value * 36500).toString();
      weekController.text = (value * 5214.29).toString();
      monthController.text = (value * 1200).toString();
      yearController.text = (value * 100).toString();
      decadeController.text = (value * 10).toString();
    });
  }
}
