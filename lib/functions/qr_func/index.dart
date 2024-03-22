import 'package:aio_mobile/constants/app_size.dart';
import 'package:aio_mobile/functions/qr_func/generate_qr.dart';
import 'package:aio_mobile/functions/qr_func/scan_qr.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:aio_mobile/widgets/header.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';

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
              VSpace(space: isMobile ? 0 : 15),
              ListTile(
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Scan QR',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  CoreRouter.push(ScanQr(item: widget.item));
                },
              ),
              VSpace(space: isMobile ? 10 : 15),
              ListTile(
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Generate QR',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  CoreRouter.push(GenerateQr(item: widget.item));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
