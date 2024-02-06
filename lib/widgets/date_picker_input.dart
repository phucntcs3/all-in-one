import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_size.dart';
import '../router/core_router.dart';
import 'bottom_sheet_date_picker.dart';

class DatePickerInput extends StatelessWidget {
  const DatePickerInput({
    super.key,
    this.title = '',
    this.value,
    this.onDone,
  });

  final String title;
  final DateTime? value;
  final Function(DateTime)? onDone;

  String getDay() {
    if (value == null) {
      return '';
    }

    return value!.day.toString();
  }

  String getMonth() {
    if (value == null) {
      return '';
    }

    return DateFormat.MMMM().format(DateTime(value!.year, value!.month));
  }

  String getYear() {
    if (value == null) {
      return '';
    }

    return value!.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        CoreRouter.showBottomSheet(
          builder: (BuildContext context) {
            return BottomSheetDatePicker(
              title: title,
              initValue: value,
              onDone: onDone,
            );
          },
        );
      },
      child: Container(
        height: AppSize.inputHeight,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getDay()),
            Text(getMonth()),
            Text(getYear()),
          ],
        ),
      ),
    );
  }
}
