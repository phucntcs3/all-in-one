import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/header.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrFunc extends StatefulWidget {
  const QrFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<QrFunc> createState() => _QrFuncState();
}

class _QrFuncState extends State<QrFunc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Header(item: widget.item),
              Flexible(
                fit: FlexFit.tight,
                // child: Container(),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await controller?.flipCamera();
                    },
                    icon: const Icon(Icons.flip_camera_ios_outlined),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    onPressed: () {
                      if (paused) {
                        controller?.resumeCamera();
                      } else {
                        controller?.pauseCamera();
                      }

                      setState(() {
                        paused = !paused;
                      });
                    },
                    icon: Icon(paused ? Icons.stop : Icons.pause),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool paused = false;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      print('%%scanData ${scanData.code}');

      if (scanData.code?.isNotEmpty == true) {
        controller.stopCamera();

        setState(() {
          result = scanData.code;
        });

        Uri? uri = Uri.tryParse(scanData.code ?? '');

        bool canLaunch = uri == null ? false : await canLaunchUrl(uri);

        await CoreRouter.showBottomSheet(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Column(
                children: [
                  const Text('Result:'),
                  const VSpace(),
                  GestureDetector(
                    onTap: canLaunch == true
                        ? () {
                            try {
                              launchUrl(
                                uri!,
                                mode: LaunchMode.externalApplication,
                              );
                            } catch (e) {
                              print('%% ${e}');
                            }
                          }
                        : null,
                    child: Text(
                      scanData.code ?? '?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: canLaunch ? Colors.blueAccent : Colors.black,
                      ),
                    ),
                  ),
                  const VSpace(),
                  // TextButton(
                  //   onPressed: () {
                  //     CoreRouter.pop();
                  //   },
                  //   child: const Text('Scan again'),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      CoreRouter.pop();
                    },
                    child: const Text('Scan again'),
                  ),
                ],
              ),
            );
          },
        );

        controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
