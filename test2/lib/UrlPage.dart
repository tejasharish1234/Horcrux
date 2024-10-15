import 'package:flutter/material.dart';

class UrlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URL Page'),
        backgroundColor: Color.fromRGBO(54, 65, 86, 1),
        foregroundColor: Color.fromRGBO(251, 242, 192, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Here is your URL:',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(251, 242, 192, 1),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'http://example.com/your-url',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(251, 242, 192, 1),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Action for the button if needed
              },
              child: Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(251, 242, 192, 1),
                foregroundColor: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
