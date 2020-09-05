import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
       body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
            padding: EdgeInsets.only(top: 250, left: 70.0, right: 70.0),  
            child: Row(
              children: <Widget>[
                Hero(
                    tag: 'quil_logo',
                    child: Container(
                    child: Image.asset('images/quill.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Quill'],
                  speed: Duration(seconds: 1),
                  textStyle: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              child: Material(
                elevation: 5.0,
                color: Color(0xffee4f54),
                borderRadius: BorderRadius.circular(10.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SigninScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white)
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Material(
                color: Color(0xff0336ff),
                borderRadius: BorderRadius.circular(0.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  minWidth: 500,
                  height: 100.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            )
          ],
        ),
      );
  }
}
