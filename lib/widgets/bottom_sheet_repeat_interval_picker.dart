import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../router/core_router.dart';

class BottomSheetRepeatIntervalPicker extends StatelessWidget {
  const BottomSheetRepeatIntervalPicker({
    super.key,
    this.title = '',
    this.onDone,
    this.initValue = 0,
    this.data = const [],
  });

  final String title;
  final Function(int)? onDone;
  final int initValue;
  final List<int> data;

  @override
  Widget build(BuildContext context) {
    int selectedItem = initValue;

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
                    onDone?.call(selectedItem);
                    CoreRouter.pop();
                  },
                  child: const Text('DONE'),
                ),
              ],
            ),
            SizedBox(
              height: 280,
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(
                  initialItem: initValue,
                ),
                onSelectedItemChanged: (value) {
                  selectedItem = data[value];
                },
                children: data
                    .map(
                      (item) => Center(
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
