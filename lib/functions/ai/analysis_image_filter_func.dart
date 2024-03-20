import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/router/core_router.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

class AnalysisImageFilterFunc extends StatefulWidget {
  const AnalysisImageFilterFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<AnalysisImageFilterFunc> createState() =>
      _AnalysisImageFilterFuncState();
}

class _AnalysisImageFilterFuncState extends State<AnalysisImageFilterFunc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        topActionsBuilder: (state) {
          return Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  CoreRouter.pop();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.chevron_left),
                ),
              ),
            ],
          );
        },
        saveConfig: SaveConfig.photo(),
        onMediaTap: (mediaCapture) {
          OpenFile.open(mediaCapture.captureRequest.path);
        },
      ),
    );
  }
}
