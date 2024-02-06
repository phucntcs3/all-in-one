import 'package:aio_mobile/router/core_router.dart';
import 'package:flutter/material.dart';

class BottomSheetLanguage extends StatelessWidget {
  const BottomSheetLanguage({super.key});

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
              'Language',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: SizedBox.square(
              dimension: 30,
              child: Image.asset(
                'assets/images/us.png',
              ),
            ),
            minLeadingWidth: 20,
            title: const Text('English'),
            onTap: () {
              CoreRouter.pop();
            },
          ),
          ListTile(
            leading: SizedBox.square(
              dimension: 30,
              child: Image.asset(
                'assets/images/vietnam.png',
              ),
            ),
            minLeadingWidth: 20,
            title: const Text('Tiếng Việt'),
            onTap: () {
              CoreRouter.pop();
            },
          ),
        ],
      ),
    );
  }
}
