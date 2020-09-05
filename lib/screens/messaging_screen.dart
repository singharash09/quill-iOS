import 'package:flutter/material.dart';
import 'package:quill/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quill/utilities/name.dart';

 final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser signedInUser;
 

class MessagingScreen extends StatefulWidget {
  static String id = "messaging_screen";
  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if(user!=null) {
        signedInUser = user;
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': signedInUser.email,
                        'ts': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
     }


class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('ts').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                  final messages = snapshot.data.documents;
                  List<MessageBubble> messageWidgets = [];
                  for (var message in messages) {
                    final messageText = message.data['text'];
                    final messageSender = message.data['sender'];

                    final currentUser = signedInUser.email;

                    if(currentUser ==  messageSender) {
                      //message is from signed in user
                    }

                    final messageWidget = MessageBubble(sender: messageSender, text: messageText, isMe: currentUser == messageSender);
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                      child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      children: messageWidgets,
                      
                    ),
                  );
                
              },
            );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});
  final String sender;
  final String text;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender, style: TextStyle(fontSize: 12.0, color: Colors.black54)),
             Material(
          borderRadius: isMe ? BorderRadius.only(
            topLeft: Radius.circular(30), 
            bottomLeft: Radius.circular(30), 
            bottomRight: Radius.circular(30)) : 
            BorderRadius.only(
            bottomLeft: Radius.circular(30), 
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30)
            ),
          elevation: 10.0,
          color: isMe ? Color(0xfffca903) : Colors.grey[50],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
            text,
            style: TextStyle(
                color: isMe? Colors.white : Colors.black,
                fontSize: 15.0,
            )
            ),
              ),
        )
        ]
      ),
    );
  }
}
  
