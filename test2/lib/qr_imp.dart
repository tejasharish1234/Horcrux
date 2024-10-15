import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr_code.dart';

class PreviewPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Preview'),
      ),
      body: const Center(
        // Add this QRCode widget in place of the Container
        child: QRCode(
          qrSize: 320,
          qrData: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        ),
      ),
    );
  }


}
