import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quill/constants.dart';
import 'package:quill/screens/messaging_screen.dart';
import 'package:quill/utilities/database.dart';
import 'package:quill/utilities/name.dart';
import 'package:quill/utilities/helper.dart';


class Search extends StatefulWidget {
  static String id = 'search_screen';

  @override
  _SearchState createState() => _SearchState();
}



class _SearchState extends State<Search> {
  Helper helper = new Helper();
  final _auth = FirebaseAuth.instance;
  String searchedItem;

  Database database = new Database();
  QuerySnapshot searchSnapshot;

  // method for starting search
  void startSearch(String item) async {
  await database.getUsername(item).then((val) {
    setState(() {
        searchSnapshot = val;
    });
  });
  }

// method for showing search results
Widget resultList() {
  return (searchSnapshot != null) ? 
  ListView.builder(
    
    itemCount: searchSnapshot.documents.length,
     shrinkWrap: true, // for scrollability (listview is inside a column)
    itemBuilder: (context, index) {
    return SearchResultBar(
        resultName: searchSnapshot.documents[index].data["name"],
        resultEmail: searchSnapshot.documents[index].data["email"]);
  }): Container();
}


//method that creates a messaging room when the user clicks on the search result
 createMessageRoom({String name}) {

  String roomID = getMessageRoomID(Name.myName, name);

  List<String> users = [Name.myName, name];
  print("good here");
  Map<String, dynamic> messageRoomMap = {
    "users": users,
    "roomID": roomID
  };
  print("I got till here");
  database.createMessagingRoom(roomID, messageRoomMap);
  print("and here...");
  Navigator.pushNamed(context, MessagingScreen.id);

 }
 

Widget SearchResultBar ({String resultName, String resultEmail}) {
  
  return GestureDetector(
        onTap: () {
          createMessageRoom(name: resultName);
        },
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: 
        Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resultName, style: TextStyle(color: Colors.black)),
              Text(resultEmail, style: TextStyle(color: Colors.grey)),
            ],
          )
        ]),
      ),
    );
}

//creating a unique ID every single time
getMessageRoomID(String a, String b) {
  print("its working");
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextField(
                    onChanged: (value) {
                      searchedItem = value;
                      startSearch(searchedItem);
                    },
                    decoration: kSearchBar),
              ),
            ),
            GestureDetector(
              onTap: () {
                startSearch(searchedItem);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.search)),
            )
          ]),
          SizedBox(height: 5),
          resultList()
        ],
      ),
    )));
  }
}





// Widget searchResultCard(data) {
//   return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Row(children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(data['name'], style: TextStyle(color: Colors.black)),
//             Text(data['email'], style: TextStyle(color: Colors.grey)),
//           ],
//         )
//       ]),
//     );
// }