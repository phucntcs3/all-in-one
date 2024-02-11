import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../router/core_router.dart';

class BottomSheetTimePicker extends StatelessWidget {
  const BottomSheetTimePicker({
    super.key,
    this.title = '',
    this.onDone,
    this.initValue,
    this.mode = CupertinoTimerPickerMode.hms,
  });

  final String title;
  final Function(Duration)? onDone;
  final Duration? initValue;
  final CupertinoTimerPickerMode mode;

  @override
  Widget build(BuildContext context) {
    Duration selectedDate =
        initValue ?? const Duration(seconds: 0, minutes: 0, hours: 0);

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
              // child: ScrollDatePicker(
              //   selectedDate: selectedDate,
              //   locale: const Locale('en'),
              //   minimumDate: DateTime(1900),
              //   maximumDate: DateTime(2100),
              //   onDateTimeChanged: (DateTime value) {
              //     selectedDate = value;
              //   },
              // ),
              child: CupertinoTimerPicker(
                onTimerDurationChanged: (_) {
                  selectedDate = _;
                },
                initialTimerDuration: initValue ??
                    const Duration(seconds: 0, minutes: 0, hours: 0),
                mode: mode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
