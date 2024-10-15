import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'qr_code.dart';
import 'tain.dart';
import 'TransactionScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MySQL Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isRegistering = false;
  String _name = '';
  String _email = '';
  String _password = '';
  final String apiUrl = 'http://10.0.2.2:7000/users';
  List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // Fetch users from MySQL via the API
  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        _users = json.decode(response.body);
        print('Fetched users: $_users');
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Add a user to MySQL via the API
  Future<void> addUser(String name, String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email,"age":30}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("User added");
      fetchUsers(); // Refresh the list after adding
    } else {
      throw Exception('Failed to add user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isRegistering ? 'User Registration' : 'Sign Up',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
           image: DecorationImage(
            image: AssetImage("assets/images/logotop.png"),
            fit: BoxFit.cover,
           ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:AlignmentDirectional.bottomCenter,
            colors: [Colors.deepPurple, Colors.purple.shade200],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child:SingleChildScrollView(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email input field
              SizedBox(height: 300),  
              TextFormField(
                
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelText: 'User ID:',
                labelStyle: TextStyle(color: Colors.green,
                fontWeight: FontWeight.bold,),
                hintText: 'Your User ID',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.phone, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(05),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(1.0)
                        
                        
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } 
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              
              ),

              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(labelText: 'Phone No:',
                floatingLabelAlignment: FloatingLabelAlignment.center,
                labelStyle: TextStyle(color: Colors.green,
                fontWeight: FontWeight.bold,),
                hintText: 'Your Phone No.',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.phone, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(05),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(1.0)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone no';
                  } else if (!RegExp(r'\d{10}').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 20),

               TextFormField(
              controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password:',
                floatingLabelAlignment: FloatingLabelAlignment.center,
                labelStyle: TextStyle(color: Colors.green,
                fontWeight: FontWeight.bold,),
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.phone, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(05),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(1.0)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the desired password';
                  } 
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),

              SizedBox(height: 20),

              TextFormField(
                    controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password:',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'Confirm your password',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  
                  const SizedBox(height: 30),

            ElevatedButton(
              child: Text('Sign Up',style: TextStyle(),),
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  _formKey.currentState?.save();
                  addUser(_name, _email);
                  _navigateToNextScreen(context);

                }

              },
            ),
            SizedBox(height: 30),
          ],
          ))
      ),
    ),
    ),
    
    );
  }
  void _navigateToNextScreen(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SideScreen()));
  }
  
  void dispose() {
    
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

  class NewScreen extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: const Text('New Screen')),
        body: const Center(
          child: Text(
            'This is a new screen',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      );
    }
    }
  class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/help.html');
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: WebViewWidget(controller: _controller,),
    );

  }
}
