import 'package:shared_preferences/shared_preferences.dart';

class Helper {

  static String userSignedInKey = "ISSIGNEDIN";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //saving data 
   Future<bool> saveUserSignIn(bool isUserSignedIn) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setBool(userSignedInKey, isUserSignedIn);
  }

   Future<bool> saveUserName(String name) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setString(userNameKey, name);
  }

   Future<bool> saveUserEmail(String email) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setString(userNameKey, email);
  }

  //retrieving data
   Future<bool> getUserSignIn() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(userSignedInKey);
  }

  Future<String> getUserName() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(userEmailKey);
  }

   Future<String> getUserEmail() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(userNameKey);
  }

}