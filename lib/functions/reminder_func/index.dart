import 'package:aio_mobile/constants/app_color.dart';
import 'package:aio_mobile/extensions/date_ext.dart';
import 'package:aio_mobile/extensions/duration_ext.dart';
import 'package:aio_mobile/functions/reminder_func/add_reminder.dart';
import 'package:aio_mobile/functions/reminder_func/reminder_data_model.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/utils/debug.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../widgets/header.dart';
import '../../widgets/v_space.dart';

class ReminderFunc extends StatefulWidget {
  const ReminderFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<ReminderFunc> createState() => ReminderFuncState();
}

class ReminderFuncState extends State<ReminderFunc> {
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
                  if (listReminder.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox.square(
                        dimension: 220,
                        child: Image.asset(
                          'assets/images/empty-box.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  if (listReminder.isNotEmpty)
                    for (var item in listReminder)
                      _buildItem(item, () {
                        onItemPressed(item);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          onItemPressed(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<ReminderData> listReminder = [];

  Box? box;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    try {
      getListReminder();
    } catch (e) {
      DebugUtils.printDebug(e);
    }
  }

  @override
  void dispose() {
    box?.close();
    super.dispose();
  }

  void getListReminder() async {
    box = await Hive.openBox('reminder');

    try {
      var res = box?.toMap();

      var list =
          res?.entries.map((e) => ReminderData.fromJson(e.value)).toList();

      setState(() {
        listReminder = list ?? [];
      });
    } catch (e) {
      DebugUtils.printDebug(e);
    }
  }

  void onItemPressed(ReminderData? item) async {
    box?.close();

    final res = await CoreRouter.push(AddReminder(item: item));

    if (res == true) {
      getListReminder();
    }
  }
}

Widget _buildItem(ReminderData item, Function()? onItemPressed) {
  return InkWell(
    onTap: onItemPressed,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title),
              const VSpace(space: 5),
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    color: AppColor.iconGray,
                  ),
                  const SizedBox(width: 5),
                  Text('${item.date.toddMMyyyy()} ${item.time.toHHmm()}'),
                ],
              ),
              const VSpace(space: 5),
              Row(
                children: [
                  const Icon(
                    Icons.repeat,
                    color: AppColor.iconGray,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      '${item.repeatInterval} times (every ${item.repeatTime.toHHmmssLocale()})'),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.notifications,
            color: AppColor.iconGray,
          ),
        ],
      ),
    ),
  );
}
