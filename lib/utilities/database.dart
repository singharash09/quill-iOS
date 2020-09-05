import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {

  getUsername(String name) async {
    return await Firestore.instance.collection('users').where("capitalizedName", isEqualTo: name.toUpperCase()).getDocuments();
  }

  getEmail(String email) async {
    return await Firestore.instance.collection('users').where("email", isEqualTo: email).getDocuments();
  }


  getBySearchKey(String searchField) async {
    return await Firestore.instance.
    collection('users').where("firstLetter", isEqualTo: searchField.substring(0,1).toUpperCase()).getDocuments();
  }


  getUserInfo(userInfoMap) {
    Firestore.instance.collection('users').add(userInfoMap);
  }


  createMessagingRoom(String id, roomMap) {
    Firestore.instance.collection("MessagingRooms").document(id).setData(roomMap).
    catchError((e) {
      print(e.toString());
    });
  }
}