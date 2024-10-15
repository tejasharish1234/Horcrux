import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CodeViewerPage extends StatefulWidget {

  const CodeViewerPage({Key? key, this.title=""}) : super(key: key);

  final String title;

  @override
  State<CodeViewerPage> createState() => _CodeViewerPageState();
}

class _CodeViewerPageState extends State<CodeViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "This is your qr code",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Container(
              child: _buildQrCode(""),
              width: 400,
              height: 400,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCode(String message) {
    // TODO
    return Container();
  }

  void _downloadPdf() {
    // TODO
  }
}