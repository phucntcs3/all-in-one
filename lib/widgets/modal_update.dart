import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'v_space.dart';

class ModalUpdate extends StatelessWidget {
  const ModalUpdate({
    super.key,
    this.iosLink = '',
  });

  final String iosLink;

  @override
  Widget build(BuildContext context) {
    void update() {
      try {
        launchUrl(Uri.parse(iosLink));
      } catch (e) {
        //
      }
    }

    return Positioned.fill(
      child: Material(
        color: Colors.white.withOpacity(0),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const VSpace(),
                    SizedBox(
                      width: 90,
                      child: Image.asset(
                        'assets/images/rocket.png',
                      ),
                    ),
                    const VSpace(),
                    const Text(
                      'Update required',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const VSpace(),
                    const Text(
                      'To use this app, download the latest version',
                    ),
                    const VSpace(space: 20),
                    GestureDetector(
                      onTap: update,
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 330,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 0, 215, 143),
                                Color.fromARGB(255, 0, 176, 117),
                                Color(0xff008a5c),
                              ],
                            )),
                        child: const Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VSpace(),
                  ],
                ),
              ),

              // child: AnimatedNumber(
              //   prize,
              //   duration: const Duration(milliseconds: 450),
              //   style: GoogleFonts.roboto(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20,
              //     color: const Color.fromARGB(255, 33, 51, 243),
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
