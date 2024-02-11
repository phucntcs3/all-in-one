import 'package:aio_mobile/constants/app_color.dart';
import 'package:aio_mobile/functions/reminder_func/add_reminder.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30),
                  //   child: SizedBox.square(
                  //     dimension: 220,
                  //     child: Image.asset(
                  //       'assets/images/empty-box.png',
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title'),
                              const VSpace(space: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: AppColor.iconGray,
                                  ),
                                  Text('10/8/2000 20:20'),
                                ],
                              ),
                              const VSpace(space: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.repeat,
                                    color: AppColor.iconGray,
                                  ),
                                  Text('2 times (every 1 hour)'),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.notifications,
                            color: AppColor.iconGray,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CoreRouter.push(const AddReminder());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  var listReminder = [];
  /**
   * title
   * time -> dd/MMMM/yyyy hh:mm
   * repeat -> 2 times
   * repeat interval -> every 1 hour
   */
}
