import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessDialog extends StatefulWidget {
  @override
  _BrightnessDialogState createState() => _BrightnessDialogState();
}

class _BrightnessDialogState extends State<BrightnessDialog> {
  double _brightness = 0.0;

  @override
  void initState() {
    super.initState();
    _getBrightness();
  }

  Future<void> _getBrightness() async {
    double brightness = await ScreenBrightness().current;
    setState(() {
      _brightness = brightness;
    });
  }

  Future<void> _setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      print(e);
      // 可以在这里添加错误处理，比如显示一个 SnackBar
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('调整屏幕亮度'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('当前亮度: ${(_brightness * 100).toStringAsFixed(0)}%'),
          SizedBox(height: 20),
          Slider(
            value: _brightness,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            label: '${(_brightness * 100).round()}%',
            onChanged: (double value) {
              setState(() {
                _brightness = value;
              });
              _setBrightness(value);
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('关闭'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}