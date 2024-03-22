import 'package:aio_mobile/constants/app_size.dart';
import 'package:aio_mobile/functions/settings_func/wake_lock.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/header.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';

class SettingsFunc extends StatefulWidget {
  const SettingsFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<SettingsFunc> createState() => _SettingsFuncState();
}

class _SettingsFuncState extends State<SettingsFunc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Header(item: widget.item),
              VSpace(space: isMobile ? 10 : 15),
              for (var item in listFunc)
                ListTile(
                  tileColor: Colors.grey.shade200,
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    CoreRouter.push(item.widget(item));
                  },
                ),

              // ListTile(
              //   tileColor: Colors.grey.shade200,
              //   title: const Text('Keep screen alive'),
              //   onTap: () {
              //     CoreRouter.push(WakeLock(item: widget.item));
              //   },
              // ),
              // const VSpace(),
              // ListTile(
              //   tileColor: Colors.grey.shade200,
              //   title: const Text('Generate QR'),
              //   onTap: () {
              //     CoreRouter.push(GenerateQr(item: widget.item));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final listFunc = [
    FunctionModel(
      key: 'settings-wakelock',
      title: 'Keep screen alive',
      icon: '',
      widget: (item) => WakeLock(item: item),
    ),
    // FunctionModel(
    //   key: 'tip',
    //   title: 'Tip',
    //   icon: 'assets/images/tip.png',
    //   widget: (item) => TipFunc(item: item),
    // ),
  ];
}
