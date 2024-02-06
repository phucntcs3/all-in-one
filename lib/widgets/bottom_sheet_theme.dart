import 'package:aio_mobile/router/core_router.dart';
import 'package:flutter/material.dart';

class BottomSheetTheme extends StatelessWidget {
  const BottomSheetTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Theme',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            minLeadingWidth: 20,
            title: const Text('Red'),
            onTap: () {
              CoreRouter.pop();
            },
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            minLeadingWidth: 20,
            title: const Text('Blue'),
            onTap: () {
              CoreRouter.pop();
            },
          ),
        ],
      ),
    );
  }
}
