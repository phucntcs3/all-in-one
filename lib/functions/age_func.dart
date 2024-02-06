import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:aio_mobile/widgets/date_picker_input.dart';
import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/result.dart';
import '../widgets/v_space.dart';

class AgeFunc extends StatefulWidget {
  const AgeFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<AgeFunc> createState() => _AgeFuncState();
}

class _AgeFuncState extends State<AgeFunc> {
  DateTime birthday = DateTime(2002, 8, 12);
  DateTime currentDate = DateTime.now();

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
                  DatePickerInput(
                    title: 'Select your birthday',
                    value: birthday,
                    onDone: (DateTime value) {
                      setState(() {
                        birthday = value;
                      });
                    },
                  ),
                  const VSpace(),
                  DatePickerInput(
                    title: 'Select current date',
                    value: currentDate,
                    onDone: (DateTime value) {
                      setState(() {
                        currentDate = value;
                      });
                    },
                  ),
                  const VSpace(),
                  Result(title: 'Age', value: getAge()),
                  const VSpace(),
                  Result(title: 'Next birthday', value: getNextBirthday()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getAge() {
    Duration difference = currentDate.difference(birthday);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = difference.inDays % 30;

    if (years == 0 && months == 0 && days == 0) {
      return 'Today is your birthday';
    }

    return '$years years, $months months, $days days';
  }

  String getNextBirthday() {
    DateTime nextBirthday =
        DateTime(currentDate.year, birthday.month, birthday.day);
    if (nextBirthday.isBefore(currentDate) || nextBirthday == currentDate) {
      nextBirthday =
          DateTime(currentDate.year + 1, birthday.month, birthday.day);
    }

    DateTime today = DateTime.now();

    Duration difference = nextBirthday.difference(today);

    int months = (difference.inDays % 365) ~/ 30;
    int days = difference.inDays % 30;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    return '$months months, $days days\n$hours hours, $minutes minutes';
  }
}
