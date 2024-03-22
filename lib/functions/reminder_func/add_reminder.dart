import 'package:aio_mobile/constants/app_size.dart';
import 'package:aio_mobile/extensions/date_ext.dart';
import 'package:aio_mobile/extensions/duration_ext.dart';
import 'package:aio_mobile/functions/reminder_func/reminder_data_model.dart';
import 'package:aio_mobile/utils/common.dart';
import 'package:aio_mobile/utils/debug.dart';
import 'package:aio_mobile/utils/display.dart';
import 'package:aio_mobile/widgets/bottom_sheet_repeat_interval_picker.dart';
import 'package:aio_mobile/widgets/bottom_sheet_time_picker.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../constants/app_color.dart';
import '../../router/core_router.dart';
import '../../widgets/bottom_sheet_date_picker.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({
    super.key,
    this.item,
    required this.box,
    this.index = 0,
  });

  final ReminderData? item;
  final Box? box;
  final int index;

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
                style: TextStyle(
                  fontSize: isMobile ? 14 : 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Title...',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 15 : 20,
                    vertical: isMobile ? 10 : 20,
                  ),
                ),
              ),
              const VSpace(),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {},
                style: TextStyle(
                  fontSize: isMobile ? 14 : 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Description...',
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 15 : 20,
                    vertical: isMobile ? 10 : 20,
                  ),
                ),
              ),
              const VSpace(),
              ListTile(
                title: Text(
                  'Date',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 20,
                  ),
                ),
                subtitle: Text(
                  currentDate.toddMMyyyy(),
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 20,
                  ),
                ),
                leading: Icon(
                  Icons.date_range,
                  size: isMobile ? null : 30,
                ),
                onTap: onDatePressed,
              ),
              ListTile(
                title: Text(
                  'Time',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 20,
                  ),
                ),
                subtitle: Text(
                  currentTime.toHHmm(),
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 20,
                  ),
                ),
                leading: Icon(
                  Icons.timer,
                  size: isMobile ? null : 30,
                ),
                onTap: onTimePressed,
              ),
              // ListTile(
              //   title: const Text('Repeat'),
              //   subtitle: Text('Every ${repeatTime.toHHmmssLocale()}'),
              //   leading: const Icon(Icons.repeat),
              //   onTap: onRepeatTimePressed,
              // ),
              // ListTile(
              //   title: const Text('Repeat interval'),
              //   subtitle: Text(repeatCount.toString()),
              //   leading: const Icon(Icons.repeat_one_rounded),
              //   onTap: onRepeatIntervalPressed,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  int get index => item?.index ?? widget.index;
  Box? get box => widget.box;

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

      await AwesomeNotifications().cancel(index);

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
        createdAt: DateTime.now(),
        index: index,
      );

      DisplayUtils.showLoading();

      await box?.put(id, submitData.toJson());

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: index,
          channelKey: 'aio_channel',
          title: title,
          body: description,
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
        ),
        schedule: NotificationCalendar.fromDate(
          date: DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            currentTime.inHours,
            currentTime.inMinutes % 60,
            0,
          ),
          allowWhileIdle: true,
          preciseAlarm: true,
        ),
      );

      DisplayUtils.showSnackbar(message: 'Add reminder successfully');

      DisplayUtils.hideLoading();

      CoreRouter.pop(true);
    } catch (e) {
      DebugUtils.printDebug('%%ERROR: $e');
    }
  }

  void requestPermission() async {
    try {} catch (e) {
      DebugUtils.printDebug(e);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    DisplayUtils.showLoading();

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
              icon: Icon(
                Icons.chevron_left,
                color: AppColor.iconGray,
                size: isMobile ? null : 30,
              ),
            ),
            Row(
              children: [
                Text(
                  'Add reminder',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 16 : 25,
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
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
                size: isMobile ? null : 40,
              ),
            ),
            IconButton(
              onPressed: () async {
                await onDone?.call();
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
                size: isMobile ? null : 40,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
