import 'package:aio_mobile/widgets/bottom_sheet_language.dart';
import 'package:aio_mobile/widgets/bottom_sheet_theme.dart';
import 'package:flutter/material.dart';

import '../router/core_router.dart';

class BottomSheetSettings extends StatelessWidget {
  const BottomSheetSettings({super.key});

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
              'Settings',
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
                'assets/images/languages.png',
              ),
            ),
            minLeadingWidth: 20,
            title: const Text('Language'),
            subtitle: const Text('English'),
            onTap: () {
              CoreRouter.pop();
              CoreRouter.showBottomSheet(
                builder: (context) {
                  return const BottomSheetLanguage();
                },
              );
            },
          ),
          ListTile(
            leading: SizedBox.square(
              dimension: 30,
              child: Image.asset(
                'assets/images/paint.png',
              ),
            ),
            minLeadingWidth: 20,
            title: const Text('Theme'),
            subtitle: const Text('Default'),
            onTap: () {
              CoreRouter.pop();
              CoreRouter.showBottomSheet(
                builder: (context) {
                  return const BottomSheetTheme();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
