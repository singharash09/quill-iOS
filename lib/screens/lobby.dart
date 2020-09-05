import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'search_screen.dart';

class Lobby extends StatefulWidget {
  static String id = "lobby";
  @override
  _LobbyState createState() => _LobbyState();
}



class _LobbyState extends State<Lobby> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.white),
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Quill'),
        backgroundColor: Colors.yellow[700],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          onPressed: () {Navigator.pushNamed(context, Search.id);}, 
          backgroundColor: Colors.yellow[700],
          label: Text("Search"),
          icon: Icon(Icons.search),
          ),
      ),
    );
  }
}