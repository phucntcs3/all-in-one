import 'package:aio_mobile/widgets/bottom_sheet_oauth.dart';
import 'package:flutter/material.dart';

import '../router/core_router.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const currentUser = null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     'Settings',
          //     style: TextStyle(
          //       fontSize: 25,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          if (currentUser == null)
            ListTile(
              leading: SizedBox.square(
                dimension: 30,
                child: Image.asset(
                  'assets/images/authentication.png',
                ),
              ),
              minLeadingWidth: 20,
              title: const Text('Sign in'),
              subtitle: const Text('Keep your data secure in the cloud'),
              onTap: () {
                CoreRouter.pop();
                CoreRouter.showBottomSheet(
                  builder: (context) {
                    return const BottomSheetOAuth();
                  },
                );
              },
            ),

          if (currentUser != null)
            ListTile(
              leading: SizedBox.square(
                dimension: 30,
                child: Image.asset(
                  'assets/images/authentication.png',
                ),
              ),
              minLeadingWidth: 20,
              title: const Text('Sign out'),
              // subtitle: const Text('Keep your data secure in the cloud'),
              onTap: () async {
                CoreRouter.pop();
              },
            ),
        ],
      ),
    );
  }
}
