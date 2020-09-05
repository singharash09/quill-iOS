import 'package:flutter/material.dart';
import 'package:quill/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quill/screens/messaging_screen.dart';
import 'messaging_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:quill/utilities/database.dart';
import 'package:quill/utilities/helper.dart';
import 'package:quill/screens/lobby.dart';

class SignupScreen extends StatefulWidget {
  static String id = "signup_screen";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  Helper helper = new Helper();
  bool spinner = false;
  String username;
  String email;
  String password;

  Database database = new Database();

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
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldRegister.copyWith(hintText: 'Enter your name..') 
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldRegister.copyWith(hintText: 'Enter your email...') 
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldRegister.copyWith(hintText: 'Enter your password...') 
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Color(0xff0336ff),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async{
                      setState(() {
                        spinner = true;
                      });
                      try {
                     final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    
                    //This is how I identify a user
                     Map<String, String> userInfo = {
                       "name" : username,
                       "email": email,
                       "capitalizedName" : username.toUpperCase(),
                       "searchKey" : username.substring(0,1).toUpperCase()
                     };
                      
                      helper.saveUserName(username);
                      helper.saveUserEmail(email);
          
                     //Adding user to the database after they are done
                     database.getUserInfo(userInfo);
                     helper.saveUserSignIn(true);

                     if(newUser !=null) {
                       Navigator.pushNamed(context, MessagingScreen.id);
                     }
                      } catch(e) {
                        print(e);
                      }

                      setState(() {
                        spinner = false;
                      });
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
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
