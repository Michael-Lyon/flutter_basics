import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ARScreen extends StatelessWidget {
  static const platform = MethodChannel('pygod');
  final String modelUrl;

  const ARScreen({super.key, required this.modelUrl});

  Future<void> _launchAR(String modelUrl) async {
    try {
      await platform.invokeMethod('launchAR', {'modelUrl': modelUrl});
    } on PlatformException catch (e) {
      print("Failed to launch AR: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AR Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _launchAR(modelUrl);
          },
          child: const Text('Launch AR View'),
        ),
      ),
    );
  }
}
