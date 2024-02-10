import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:aio_mobile/widgets/v_space.dart';
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
                  const VSpace(space: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'OFF',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: wakelockEnabled
                              ? Colors.black
                              : Colors.blueAccent,
                        ),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Switch(
                          value: wakelockEnabled,
                          activeColor: Colors.blueAccent,
                          onChanged: onChanged,
                        ),
                      ),
                      Text(
                        'ON',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: wakelockEnabled
                              ? Colors.blueAccent
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const VSpace(space: 20),
                  IndexedStack(
                    alignment: AlignmentDirectional.center,
                    index: wakelockEnabled ? 0 : 1,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/mobile-success.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/mobile-failed.png',
                          fit: BoxFit.contain,
                        ),
                      ),
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
    final wakelockEnabled = await WakelockPlus.enabled;

    setState(() {
      this.wakelockEnabled = wakelockEnabled;
    });
  }

  void onChanged(bool enabled) async {
    setState(() {
      wakelockEnabled = enabled;
    });

    if (enabled) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }
}
