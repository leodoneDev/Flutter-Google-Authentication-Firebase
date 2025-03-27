// created by leodone

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Authentication',
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  ///
  const SignInPage({super.key});

  @override
  State createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        print("User is already authenticated123");
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print("Sign in error: $error");
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();

  Widget buildBody() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        children: [
          SizedBox(height: 90),
          GoogleUserCircleAvatar(identity: user),
          SizedBox(height: 20),
          Center(
            child: Text(
              user.displayName ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              user.email,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(height: 60),
          Center(
            child: Text(
              'Welcome to homepage',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: handleSignOut, child: Text('Sign Out')),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 90),
          Center(
            child: Image.asset(
              "assets/google_larger.png",
              height: 200,
              width: 200,
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Welcome to Google Authentication',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Container(
              width: 250,
              child: ElevatedButton(
                onPressed: handleSignIn,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Image.asset("assets/google.png", height: 20, width: 20),
                      SizedBox(width: 20),
                      Text('Google Sign In'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(child: buildBody()),
    );
  }
}
