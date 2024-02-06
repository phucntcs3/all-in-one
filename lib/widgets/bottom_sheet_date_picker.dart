import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../router/core_router.dart';

class BottomSheetDatePicker extends StatelessWidget {
  const BottomSheetDatePicker({
    super.key,
    this.title = '',
    this.onDone,
    this.initValue,
  });

  final String title;
  final Function(DateTime)? onDone;
  final DateTime? initValue;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = initValue ?? DateTime.now();

    return Container(
      height: 350,
      padding: const EdgeInsets.only(
        top: 10,
        left: 15,
        right: 15,
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                TextButton(
                  onPressed: () {
                    onDone?.call(selectedDate);
                    CoreRouter.pop();
                  },
                  child: const Text('DONE'),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: ScrollDatePicker(
                selectedDate: selectedDate,
                locale: const Locale('en'),
                minimumDate: DateTime(1900),
                maximumDate: DateTime(2100),
                onDateTimeChanged: (DateTime value) {
                  selectedDate = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
