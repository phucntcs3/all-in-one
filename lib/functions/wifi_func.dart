import 'package:aio_mobile/models/function_model.dart';
import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import '../widgets/header.dart';

class WifiFunc extends StatefulWidget {
  const WifiFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<WifiFunc> createState() => WifiFuncState();
}

class WifiFuncState extends State<WifiFunc> {
  @override
  void initState() {
    super.initState();
    init();
  }

  final speedTest = FlutterInternetSpeedTest();

  String _downloadProgress = '0';
  double _downloadRate = 0;
  int _downloadCompletionTime = 0;
  String _uploadProgress = '0';
  double _uploadRate = 0;
  int _uploadCompletionTime = 0;

  String _unitText = 'Mbps';

  bool _testInProgress = false;

  void init() async {
    speedTest.startTesting(
      useFastApi: true,
      onStarted: () {
        setState(() {
          _testInProgress = true;
        });
      },
      onCompleted: (TestResult download, TestResult upload) {
        setState(() {
          _downloadRate = download.transferRate;
          _downloadProgress = '100';
          _unitText = download.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
          _uploadProgress = '100';
          _uploadRate = upload.transferRate;
          _unitText = upload.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
          _downloadCompletionTime = download.durationInMillis;
          _uploadCompletionTime = upload.durationInMillis;
          _testInProgress = false;
        });
      },
      onProgress: (double percent, TestResult data) {
        setState(() {
          if (data.type == TestType.download) {
            _downloadProgress = percent.toStringAsFixed(2);
            _downloadRate = data.transferRate;
          } else {
            _uploadProgress = percent.toStringAsFixed(2);
            _uploadRate = data.transferRate;
          }
        });
      },
      onError: (String errorMessage, String speedTestError) {
        // TODO
      },
      onDefaultServerSelectionInProgress: () {},
      onDefaultServerSelectionDone: (Client? client) {},
      onDownloadComplete: (TestResult data) {
        // TODO
        setState(() {
          _downloadRate = data.transferRate;
          _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
          _downloadCompletionTime = data.durationInMillis;
        });
      },
      onUploadComplete: (TestResult data) {
        // TODO
        setState(() {
          _uploadRate = data.transferRate;
          _unitText = data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
          _uploadCompletionTime = data.durationInMillis;
        });
      },
      onCancel: () {
        // TODO Request cancelled callback
      },
    );
  }

  void reset() {
    setState(() {
      {
        _testInProgress = false;
        _downloadRate = 0;
        _uploadRate = 0;
        _downloadProgress = '0';
        _uploadProgress = '0';
        _unitText = 'Mbps';
        _downloadCompletionTime = 0;
        _uploadCompletionTime = 0;
      }
    });
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
                  if (_testInProgress) ...{
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Testing...',
                      textAlign: TextAlign.center,
                    ),
                  },
                  if (!_testInProgress)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Download Speed',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Progress: $_downloadProgress%'),
                        Text('Download Rate: $_downloadRate $_unitText'),
                        if (_downloadCompletionTime > 0)
                          if (_downloadCompletionTime > 0)
                            Text(
                                'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                        const Text(
                          'Upload Speed',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Progress: $_uploadProgress%'),
                        Text('Upload Rate: $_uploadRate $_unitText'),
                        if (_uploadCompletionTime > 0)
                          Text(
                              'Time taken: ${(_uploadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              reset();
                              init();
                            },
                            child: const Text(
                              'RESET',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const colors = [
  Color.fromARGB(255, 0, 128, 255),
  Color.fromARGB(255, 255, 171, 37),
  Color.fromARGB(255, 255, 60, 0),
  Color.fromARGB(255, 28, 215, 15),
  Color.fromARGB(255, 240, 37, 247),
  Color.fromARGB(255, 131, 131, 131),
];
