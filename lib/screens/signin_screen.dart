import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quill/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quill/utilities/database.dart';
import 'messaging_screen.dart';
import 'lobby.dart';
import 'package:quill/utilities/helper.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SigninScreen extends StatefulWidget {
  static String id = "signin_screen";
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  //private friebase auth object
  final _auth = FirebaseAuth.instance;
  Helper helper = new Helper();
  Database database = new Database();
  QuerySnapshot userInfoSnapshot;
  String email;
  String password;
  bool spinner = false;

  signIn() {
    setState(() {


      helper.saveUserSignIn(true);
      Navigator.pushNamed(context, MessagingScreen.id);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: ModalProgressHUD(
        inAsyncCall: spinner,
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
              child: Hero(
                  tag: 'quil_logo',
                  child: Container(
                  height: 200.0,
                  child: Image.asset('images/quill.png'),
                ),
              ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldSignIn.copyWith(hintText: 'Enter your email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldSignIn.copyWith(hintText: 'Enter your pasword'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Color(0xffee4f54),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        spinner = true;
                      });
                      try {

                       database.getEmail(email)
                       .then((val){
                         userInfoSnapshot = val;
                         helper.saveUserName(userInfoSnapshot.documents[0].data['name']);
                       });


                      // DO THIS WHEN SIGNING USER IN: 
                      // 1. Save user email 
                      helper.saveUserEmail(email);
                      // 2. Authenticate user (wait for this to finish before proceeding)
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password).then((val) {
                        if (val != null) {
                        
                        // 3. Mark user as signed in 
                        helper.saveUserSignIn(true);
                        // 4. Push user to the lobby screen
                        Navigator.pushNamed(context, MessagingScreen.id);
                        }
                      });
                      


                      setState(() {
                        spinner = false;
                      });
                      } catch(e) {
                        print(e);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
