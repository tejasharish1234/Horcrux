import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'UrlPage.dart';
import 'TransactionScreen.dart';

class SideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SideScreen(),
    );
  }
}

class SideScreen extends StatefulWidget {
  @override
  _SideScreenState createState() => _SideScreenState();
}

class _SideScreenState extends State<SideScreen> {  
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(54, 65, 86, 1), // Background color
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor:
            Color.fromRGBO(54, 65, 86, 1), // Navbar background color
        selectedItemColor:
            Color.fromRGBO(251, 242, 192, 1), // Selected icon color
        unselectedItemColor: Colors.white, // Unselected icon color
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isFirstVisit = true;
  AnimationController? _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 2),
      child: _isFirstVisit
          ? FadeTransition(
              opacity:
                  _animationController!.drive(CurveTween(curve: Curves.easeIn)),
              child: Center(
                child: Text(
                  'myBMTC',
                  style: GoogleFonts.pacifico(
                    fontSize: 32,
                    color: Color.fromRGBO(251, 242, 192, 1),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              //padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Upcoming rides: None',
                    style: TextStyle(
                        fontSize: 24, color: Color.fromRGBO(251, 242, 192, 1)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Current rides: None',
                    style: TextStyle(
                        fontSize: 24, color: Color.fromRGBO(251, 242, 192, 1)),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward().then((_) {
        setState(() {
          _isFirstVisit = false;
        });
      });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _selectedLocation1;
  String? _selectedLocation2;
  List<String> _locations = [];
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    final String csvData = await rootBundle.loadString('assets/bmtc-stops.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

    // Assuming the first column of the CSV contains the locations
    setState(() {
      _locations = csvTable.map((row) => row[1].toString()).toList();
    });
  }   

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedLocation1,
              hint: Text(
                'Select Initial Bus Stop',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(251, 242, 192, 1),
                ),
              ),
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation1 = newValue;
                });
              },
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              value: _selectedLocation2,
              hint: Text(
                'Select Destination',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(251, 242, 192, 1),
                ),
              ),
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation2 = newValue;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isSubmitted = true;
                });
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(251, 242, 192, 1), // Button color
                foregroundColor: Color.fromRGBO(0, 0, 0, 1), // Text color
              ),
            ),
            SizedBox(height: 30),
            if (_isSubmitted) ...[
              Text(
                'The fare for your trip is 30rs',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(251, 242, 192, 1),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionScreen()),
                  );
                },
                child: Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(251, 242, 192, 1), // Button color
                  foregroundColor: Color.fromRGBO(0, 0, 0, 1), // Text color
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// class TransactionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//         backgroundColor: Color.fromRGBO(54, 65, 86, 1),
//         foregroundColor: Color.fromRGBO(251, 242, 192, 1),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Transaction successful!',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Color.fromRGBO(251, 242, 192, 1), // Text color
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UrlPage()),
//                 );
//               },
//               child: Text(
//                 'Get my URL',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color:
//                       Color.fromRGBO(0, 0, 0, 1), // Text color for the button
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     Color.fromRGBO(251, 242, 192, 1), // Button background color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30), // Round button shape
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UrlPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your URL'),
//         backgroundColor: Color.fromRGBO(54, 65, 86, 1),
//         foregroundColor: Color.fromRGBO(251, 242, 192, 1),
//       ),
//       body: Center(
//         child: Text(
//           'Here is your URL: www.example.com',
//           style: TextStyle(
//             fontSize: 24,
//             color: Color.fromRGBO(56, 65, 86, 1), // Text color for the URL
//           ),
//         ),
//       ),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(54, 65, 86, 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'User ID: 12345',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(251, 242, 192, 1),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Phone Number: +1234567890',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(251, 242, 192, 1),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Gender: Male',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(251, 242, 192, 1),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TravelHistoryScreen()),
                );
              },
              child: Text('Travel History'),
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

class TravelHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel History'),
        backgroundColor: Color.fromRGBO(54, 65, 86, 1),
        foregroundColor: Color.fromRGBO(251, 242, 192, 1),
      ),
      body: Center(
        child: Text(
          'Travel History is empty!',
          style: TextStyle(fontSize: 24, color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
    );
  }
}
