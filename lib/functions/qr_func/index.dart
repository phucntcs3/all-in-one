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
              ListTile(
                tileColor: Colors.grey.shade200,
                title: const Text('Scan QR'),
                onTap: () {
                  CoreRouter.push(ScanQr(item: widget.item));
                },
              ),
              const VSpace(),
              ListTile(
                tileColor: Colors.grey.shade200,
                title: const Text('Generate QR'),
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
