import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:aio_mobile/widgets/header.dart';
import 'package:aio_mobile/widgets/result.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:system_info_plus/system_info_plus.dart';

class InfoFunc extends StatefulWidget {
  const InfoFunc({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FunctionModel item;

  @override
  State<InfoFunc> createState() => _InfoFuncState();
}

class _InfoFuncState extends State<InfoFunc> {
  String deviceName = '';
  String softwareVersion = '';
  String modelName = '';
  String capacity = '';

  @override
  void initState() {
    super.initState();
    getDeviceInformation();
    getStorageInformation();
  }

  Future<void> getDeviceInformation() async {
    if (Platform.isAndroid) {
      await getAndroidDeviceInfo();
    } else if (Platform.isIOS) {
      await getIOSDeviceInfo();
    }
  }

  Future<void> getAndroidDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    setState(() {
      deviceName = androidInfo.device;
      softwareVersion = androidInfo.version.release;
      modelName = androidInfo.model;
    });
  }

  Future<void> getIOSDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    setState(() {
      deviceName = iosInfo.name;
      softwareVersion = iosInfo.systemVersion;
      modelName = iosInfo.model;
    });
  }

  Future<void> getStorageInformation() async {
    try {
      int? deviceMemory = await SystemInfoPlus.physicalMemory;

      capacity = '${deviceMemory?.toString() ?? ''} MB';
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Header(item: widget.item),
              Body(
                children: [
                  Result(title: 'Device name', value: deviceName),
                  const VSpace(),
                  Result(
                    title: 'Software version',
                    value: softwareVersion,
                  ),
                  const VSpace(),
                  Result(title: 'Model name', value: modelName),
                  const VSpace(),
                  Result(title: 'Capacity', value: capacity),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
