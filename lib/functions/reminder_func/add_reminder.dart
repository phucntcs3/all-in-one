import 'package:aio_mobile/extensions/date_ext.dart';
import 'package:aio_mobile/extensions/duration_ext.dart';
import 'package:aio_mobile/widgets/bottom_sheet_time_picker.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../router/core_router.dart';
import '../../widgets/bottom_sheet_date_picker.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _buildHeader(),
              TextField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Enter your work...',
                  // prefixIcon: Icon(Icons.notifications),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
              const VSpace(),
              ListTile(
                title: const Text('Date'),
                subtitle: Text(currentDate.toddMMyyyy()),
                leading: const Icon(Icons.date_range),
                onTap: onDatePressed,
              ),
              ListTile(
                title: const Text('Time'),
                subtitle: Text(currentTime.toHHmm()),
                leading: const Icon(Icons.timer),
                onTap: onTimePressed,
              ),
              ListTile(
                title: const Text('Repeat'),
                subtitle: Text('Every ${repeatTime.toHHmmss()}'),
                leading: const Icon(Icons.repeat),
                onTap: onRepeatTimePressed,
              ),
              ListTile(
                title: const Text('Repeat interval'),
                subtitle: Text(repeatCount.toString()),
                leading: const Icon(Icons.repeat_one_rounded),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime currentDate = DateTime.now();
  Duration currentTime = const Duration(seconds: 0, milliseconds: 0, hours: 0);
  Duration repeatTime = const Duration(seconds: 0, milliseconds: 0, hours: 0);
  int repeatCount = 1;

  void onDatePressed() {
    CoreRouter.showBottomSheet(
      builder: (BuildContext context) {
        return BottomSheetDatePicker(
          title: 'Select Date',
          initValue: currentDate,
          onDone: (DateTime value) {
            setState(() {
              currentDate = value;
            });
          },
        );
      },
    );
  }

  void onTimePressed() {
    CoreRouter.showBottomSheet(
      builder: (BuildContext context) {
        return BottomSheetTimePicker(
          title: 'Select time',
          initValue: currentTime,
          mode: CupertinoTimerPickerMode.hm,
          onDone: (Duration value) {
            setState(() {
              currentTime = value;
            });
          },
        );
      },
    );
  }

  void onRepeatTimePressed() {
    CoreRouter.showBottomSheet(
      builder: (BuildContext context) {
        return BottomSheetTimePicker(
          title: 'Select repeat time',
          initValue: repeatTime,
          mode: CupertinoTimerPickerMode.hms,
          onDone: (Duration value) {
            setState(() {
              repeatTime = value;
            });
          },
        );
      },
    );
  }
}

Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                CoreRouter.pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                color: AppColor.iconGray,
              ),
            ),
            Row(
              children: const [
                Text(
                  'Add reminder',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                CoreRouter.pop();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                CoreRouter.pop();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
