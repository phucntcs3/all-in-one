import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/utils/display.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../widgets/header.dart';

class WakeLock extends StatefulWidget {
  const WakeLock({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<WakeLock> createState() => WakeLockState();
}

class WakeLockState extends State<WakeLock> {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('OFF'),
                      Switch(
                        value: wakelockEnabled,
                        activeColor: Colors.blue,
                        onChanged: onChanged,
                      ),
                      const Text('ON'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wakelockEnabled = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    DisplayUtils.showLoading();

    final wakelockEnabled = await WakelockPlus.enabled;

    setState(() {
      this.wakelockEnabled = wakelockEnabled;
    });

    DisplayUtils.hideLoading();
  }

  void onChanged(bool enabled) async {
    setState(() {
      wakelockEnabled = enabled;
    });

    DisplayUtils.showLoading();

    if (enabled) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }

    DisplayUtils.hideLoading();
  }
}
