import 'package:flutter/material.dart';

import '../constants/app_size.dart';

class Result extends StatelessWidget {
  const Result({super.key, this.title = '', this.value = ''});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.inputHeight + (isMobile ? 0 : 30),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
              child: Text(
            value,
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
            ),
          )),
        ],
      ),
    );
  }
}
