import 'package:aio_mobile/constants/app_size.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/debug.dart';

class BottomSheetOAuth extends StatelessWidget {
  const BottomSheetOAuth({super.key});

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
              'Select sign in method',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VSpace(space: 20),
          SocialButton(
            title: 'Sign in with Google',
            onPressed: () async {
              try {
                GoogleSignIn googleSignIn = GoogleSignIn(
                  scopes: ['email'],
                );

                final res = await googleSignIn.signIn();

                DebugUtils.printDebug('%% ${res?.id}');
                DebugUtils.printDebug('%% ${res?.email}');
              } catch (e) {
                DebugUtils.printDebug('%%loi tan nat: ${e}');
              }
            },
          ),
        ],
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    this.isApple = false,
    this.title = '',
    this.onPressed,
  });

  final bool isApple;
  final String title;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          onPressed?.call();
          CoreRouter.pop();
        },
        child: Container(
          height: AppSize.inputHeight,
          padding: const EdgeInsets.only(left: 20, right: 30),
          decoration: BoxDecoration(
            color: isApple ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 0.08,
              )
            ],
          ),
          child: Row(
            children: [
              if (isApple)
                const Icon(
                  Icons.apple,
                  color: Colors.white,
                ),
              if (!isApple)
                SizedBox.square(
                  dimension: 30,
                  child: Image.asset(
                    'assets/images/google.png',
                  ),
                ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  title,
                  style: TextStyle(
                    color: isApple ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
