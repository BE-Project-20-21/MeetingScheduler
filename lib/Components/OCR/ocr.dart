import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class OCR extends StatefulWidget {
  OCR({Key key}) : super(key: key);

  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  bool isInitialized = false;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitialized = true;
    });
    super.initState();
  }

  _startScan() async {
    List<OcrText> list = List();
    try {
      list =
          await FlutterMobileVision.read(waitTap: true, fps: 5, multiple: true);

      for (OcrText text in list) {
        print('value is ${text.value}');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: _startScan,
      ),
    );
  }
}
