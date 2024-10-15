import 'package:flutter/material.dart';
import 'package:test2/main.dart';
import 'qr_imp.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color.fromRGBO(54, 65, 86, 1),
        foregroundColor: Color.fromRGBO(251, 242, 192, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Transaction successful!',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(54, 65, 86, 1), // Text color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreviewPage()),
                );
              },
              child: Text(
                'Get my URL',
                style: TextStyle(
                  fontSize: 20,
                  color:
                      Color.fromRGBO(0, 0, 0, 1), // Text color for the button
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(251, 242, 192, 1), // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Round button shape
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
