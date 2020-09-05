import 'package:flutter/material.dart';
import 'package:quill/screens/welcome_screen.dart';
import 'package:quill/screens/signin_screen.dart';
import 'package:quill/screens/signup_screen.dart';
import 'package:quill/screens/messaging_screen.dart';
import 'package:quill/screens/lobby.dart';
import 'package:quill/screens/search_screen.dart';
import 'package:quill/utilities/helper.dart';

void main() => runApp(Quill());

class Quill extends StatefulWidget {
  @override
  _QuillState createState() => _QuillState();
}

class _QuillState extends State<Quill> {

//THE COMMENTED LINES SAVE THE USER INPUT 
  // bool isUserLoggedIn = false;

  // @override
  // void initState() {
  //   getLoggedInState();
  //   super.initState();
  // }

  // getLoggedInState() async {
  //   Helper helper = new Helper();
  //   helper.getUserSignIn().then((value) {
  //     setState(() {
  //       isUserLoggedIn = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: isUserLoggedIn? Lobby() : WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SigninScreen.id: (context) => SigninScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        MessagingScreen.id:  (context) => MessagingScreen(),
        Lobby.id: (context) => Lobby(),
        Search.id: (context) => Search(),
      },
    );
  }
}


