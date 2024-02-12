import 'package:aio_mobile/extensions/date_ext.dart';
import 'package:aio_mobile/extensions/duration_ext.dart';
import 'package:aio_mobile/functions/reminder_func/reminder_data_model.dart';
import 'package:aio_mobile/utils/common.dart';
import 'package:aio_mobile/utils/debug.dart';
import 'package:aio_mobile/utils/display.dart';
import 'package:aio_mobile/widgets/bottom_sheet_repeat_interval_picker.dart';
import 'package:aio_mobile/widgets/bottom_sheet_time_picker.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_color.dart';
import '../../router/core_router.dart';
import '../../widgets/bottom_sheet_date_picker.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({
    super.key,
    this.item,
  });

  final ReminderData? item;

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
              _buildHeader(
                onDelete: onDelete,
                onDone: onDone,
              ),
              TextField(
                controller: titleController,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Title...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                ),
              ),
              const VSpace(),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Description...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
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
                subtitle: Text('Every ${repeatTime.toHHmmssLocale()}'),
                leading: const Icon(Icons.repeat),
                onTap: onRepeatTimePressed,
              ),
              ListTile(
                title: const Text('Repeat interval'),
                subtitle: Text(repeatCount.toString()),
                leading: const Icon(Icons.repeat_one_rounded),
                onTap: onRepeatIntervalPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ReminderData? get item => widget.item;
  bool get isEdit => widget.item != null;

  final TextEditingController titleController = TextEditingController();
  String get title => titleController.text;

  final TextEditingController descriptionController = TextEditingController();
  String get description => descriptionController.text;

  DateTime currentDate = DateTime.now();

  Duration currentTime = Duration(
    seconds: DateTime.now().second,
    minutes: DateTime.now().minute,
    hours: DateTime.now().hour,
  );

  Duration repeatTime = const Duration(
    seconds: 0,
    minutes: 5,
    hours: 0,
  );

  int repeatCount = 1;
  List<int> repeatList = const [1, 2, 3, 4, 5, 10, 20, 100];

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

  void onRepeatIntervalPressed() {
    CoreRouter.showBottomSheet(
      builder: (BuildContext context) {
        return BottomSheetRepeatIntervalPicker(
          title: 'Select repeat interval',
          initValue: repeatList.indexOf(repeatCount),
          data: repeatList,
          onDone: (int value) {
            setState(() {
              repeatCount = value;
            });
          },
        );
      },
    );
  }

  Future<void> onDelete() async {
    if (isEdit) {
      DisplayUtils.showLoading();

      await box?.delete(item?.id);

      DisplayUtils.hideLoading();

      CoreRouter.pop(true);
    } else {
      CoreRouter.pop();
    }
  }

  Future<void> onDone() async {
    try {
      final id = CommonUtils.getRandomId();

      final ReminderData submitData = ReminderData(
        id: id,
        title: title,
        description: description,
        date: currentDate,
        time: currentTime,
        repeatTime: repeatTime,
        repeatInterval: repeatCount,
      );

      DisplayUtils.showLoading();

      await box?.put(id, submitData.toJson());

      DisplayUtils.showSnackbar(message: 'Add reminder successfully');

      DisplayUtils.hideLoading();

      CoreRouter.pop(true);
    } catch (e) {
      print('%%ERROR: ${e}');
    }
  }

  Box? box;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    DisplayUtils.showLoading();

    box = await Hive.openBox('reminder');

    if (isEdit) {
      if (item?.title.isNotEmpty == true) {
        titleController.text = item!.title;
      }

      if (item?.description.isNotEmpty == true) {
        descriptionController.text = item!.description;
      }

      if (item?.date != null) {
        currentDate = item!.date;
      }

      if (item?.time != null) {
        currentTime = item!.time;
      }

      if (item?.repeatTime != null) {
        repeatTime = item!.repeatTime;
      }

      if (item?.repeatInterval != null) {
        repeatCount = item!.repeatInterval;
      }
    }

    DisplayUtils.hideLoading();
  }

  @override
  void dispose() {
    box?.close();
    super.dispose();
  }
}

Widget _buildHeader({
  Function? onDelete,
  Function? onDone,
}) {
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
                CoreRouter.pop(false);
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
              onPressed: () async {
                await onDelete?.call();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () async {
                await onDone?.call();
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
