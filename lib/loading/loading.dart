import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:asgaraliyev/home/home.dart';
import 'package:asgaraliyev/loginworks/login.dart';
import 'package:asgaraliyev/loginworks/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class displaySplash extends StatefulWidget {
  String page;
  displaySplash({Key key,this.page}) : super(key: key);
  @override
  _displaySplashState createState() => _displaySplashState();
}

class _displaySplashState extends State<displaySplash> {
  var afterload;
  var user;
  SharedPreferences preferences;
  String email;
  void getLocalData() async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    preferences = await SharedPreferences.getInstance();
    var email =await preferences.getString("email");
    var password =await preferences.getString("password");
    print("$email$password it is user information in loading screen");
    if (email!=null&&password!=null){
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=await _auth.currentUser();
      print("${user.uid}${user.email}it is user information in loading screen  await _auth.signInWithEmailAndPassword(email: email, password: password);");
     setState(() {
       afterload=Home();
     });
    }else{
      await _auth.currentUser().then((onValue){
        print(onValue.displayName);
        print(onValue.displayName);
        print(onValue.displayName);
        print(onValue.displayName);
        print(onValue.displayName);
        print(onValue.displayName);
        setState(() {
          afterload=Home();
        });

      }).catchError((onError){
        print(onError);print(onError);
        print(onError);
        print(onError);
        print(onError);
        print(onError);
      });

    }
  }
  @override
  void initState() {
    super.initState();

    if(widget.page=="home"){
      afterload=Home();
    }
    else if(widget.page=="signup"){
      afterload=SignUp();
    }
    else if(widget.page=="login"){
      afterload=Login();
    }else{
      afterload=SignUp();
    }
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(

      seconds: 5,
      navigateAfterSeconds: afterload,
      image:Image.asset("assets/logo.png"),
      photoSize: 150.0,
      gradientBackground: LinearGradient(colors: [Colors.white, Colors.redAccent], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.red,
      loaderColor: Colors.transparent,
    );
  }



}

