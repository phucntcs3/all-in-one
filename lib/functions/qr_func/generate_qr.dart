import 'dart:io';

import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/utils/display.dart';
import 'package:aio_mobile/widgets/header.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<GenerateQr> createState() => GenerateQrState();
}

class GenerateQrState extends State<GenerateQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Header(item: widget.item),
              TextField(
                controller: controller,
                onChanged: (value) {
                  generateQr(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your content',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              if (content.isNotEmpty)
                SizedBox.square(
                  dimension: 200,
                  child: _buildQr(),
                ),
              const VSpace(space: 30),
              if (content.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: downloadQr,
                      child: const Text('Save'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: shareQr,
                      child: const Text('Share'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // await Permission.manageExternalStorage.request();
    // await Permission.storage.request();
    // await Permission.mediaLibrary.request();
    // await Permission.photos.request();
  }

  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController controller = TextEditingController(text: 'demo');

  String content = 'demo';

  void generateQr(String content) {
    EasyDebounce.debounce(
      'generate-qr',
      const Duration(milliseconds: 500),
      () {
        setState(() {
          this.content = content;
        });
      },
    );
  }

  void downloadQr() async {
    try {
      DisplayUtils.showLoading();

      final uint8List = await screenshotController.captureFromWidget(
        Container(
          height: 400,
          width: 400,
          color: Colors.white,
          child: _buildQr(),
        ),
      );

      await ImageGallerySaver.saveImage(
        uint8List,
        quality: 100,
        name: 'qr-code',
      );

      DisplayUtils.hideLoading();

      // print('%% ${result['filePath'] + '/qr-code.jpg'}');

      DisplayUtils.showSnackbar(message: 'Saved');
    } catch (e) {
      print('%% ${e}');
    }
  }

  void shareQr() async {
    try {
      DisplayUtils.showLoading();

      final uint8List = await screenshotController.captureFromWidget(
        Container(
          height: 400,
          width: 400,
          color: Colors.white,
          child: _buildQr(),
        ),
      );

      DisplayUtils.hideLoading();

      final result2 = await Share.shareXFiles(
        [
          XFile.fromData(
            uint8List,
            name: 'qr-code',
            mimeType: 'image/png',
          ),
        ],
      );

      if (result2.status == ShareResultStatus.success) {
        print('Thank you for sharing the picture!');
      }
    } catch (e) {
      print('%% ${e}');
    }
  }

  Widget _buildQr() {
    return PrettyQrView.data(
      data: content,
      decoration: const PrettyQrDecoration(
        image: PrettyQrDecorationImage(
          image: AssetImage('assets/images/flutter.png'),
        ),
      ),
    );
  }
}
