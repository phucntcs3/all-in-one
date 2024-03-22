import 'package:aio_mobile/constants/app_size.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';

class StopWatchFunc extends StatefulWidget {
  const StopWatchFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<StopWatchFunc> createState() => _StopWatchFuncState();
}

class _StopWatchFuncState extends State<StopWatchFunc> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) {},
    onChangeRawSecond: (value) {},
    onChangeRawMinute: (value) {},
    onStopped: () {},
    onEnded: () {},
  );

  final _scrollController = ScrollController();

  bool get isRunning => _stopWatchTimer.isRunning;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Header(item: widget.item),

              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              /// Display every minute.
              StreamBuilder<int>(
                stream: _stopWatchTimer.minuteTime,
                initialData: _stopWatchTimer.minuteTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  return Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  'minute',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),

              /// Display every second.
              StreamBuilder<int>(
                stream: _stopWatchTimer.secondTime,
                initialData: _stopWatchTimer.secondTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  return Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  'second',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),

              const VSpace(),

              /// Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!isRunning)
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: AppSize.inputHeight + (isMobile ? 0 : 10),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilledButton(
                          onPressed: () {
                            setState(() {});
                            _stopWatchTimer.onStartTimer();
                          },
                          child: Text(
                            'Start',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isRunning)
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: AppSize.inputHeight + (isMobile ? 0 : 10),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {});
                            _stopWatchTimer.onStopTimer();
                          },
                          child: Text(
                            'Stop',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!isRunning)
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: AppSize.inputHeight + (isMobile ? 0 : 10),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: _stopWatchTimer.onResetTimer,
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isRunning)
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: AppSize.inputHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: _stopWatchTimer.onAddLap,
                          child: const Text(
                            'Lap',
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const VSpace(),

              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: StreamBuilder<List<StopWatchRecord>>(
                    stream: _stopWatchTimer.records,
                    initialData: _stopWatchTimer.records.value,
                    builder: (context, snap) {
                      final value = snap.data!;
                      if (value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final data = value[index];
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${index + 1}: ${data.displayTime}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1,
                              )
                            ],
                          );
                        },
                        itemCount: value.length,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
