import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validated/validated.dart' as validate;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn=  GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences preferences;
  void checkUser() async {
    FirebaseUser user =await _auth.currentUser();
    print(user.displayName);
    print(user.displayName);
    print(user.displayName);
    print(user.displayName);print(user.displayName);
    print(user.displayName);

  }
  @override
  void initState() {
    super.initState();
    getLocalData();
    checkUser();
  }
  void writeLocal(String _uEmail,String _uPassword) async{
    await preferences.setString("email", _uEmail);
    await  preferences.setString("password", _uPassword);
  }
  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "There is no such account",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              fontFamily: "Schyler",
              color: Colors.black,
            ),
          ),
          content: new Text("Please make sure you entered correct information." ,style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            fontFamily: "Schyler",
            color: Colors.black,
          ),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Okey",style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
                fontFamily: "Schyler",
                color: Colors.red,
              ),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

          ],
        );
      },
    );
  }
  final formKey = new GlobalKey<FormState>();
  String _email,_password;
  Future LetSignIn() async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      final FirebaseAuth _auth = FirebaseAuth.instance;

      await _auth.signInWithEmailAndPassword(email: _email, password: _password).then(( result) async{
        print("${result.user.uid} --------- User signed in succsesfluy in login.dart");
        print("${formKey.currentState.validate()} User entered CORRECT inputs in Login page");
        print("$_email -- $_password");
        print("User entered CORRECT inputs in Login page");
        writeLocal(_email,_password);
        await Navigator.pushReplacementNamed(context, "/home");


      }).catchError((onError){
        _showDialog();
        print("${formKey.currentState.validate()} User entered CORRECT inputs in Login page");
        print("$_email -- $_password");
        print("User entered CORRECT inputs in Login page");
        print("${onError} --------- User Sign in is failed in login.dart");
      });

    }else{
      print("${formKey.currentState.validate()} User entered FALSE inputs in Login page");
    }
  }


  Future<bool> _onBackPressed(){
    return showDialog(context: context,
      builder: (context)=>AlertDialog(
        title: Text("De sənöl çıxmağ istiyirsən prqramnan?",style: TextStyle(
          fontSize:20.0 ,
          color: Colors.black,
          fontFamily: "Schyler",
          fontWeight: FontWeight.w900,
        ),),
        actions: <Widget>[
          FlatButton(
            child: Text("SənÖl",style: TextStyle(
              fontSize:20.0 ,
              color: Colors.red,
              fontFamily: "Schyler",
              fontWeight: FontWeight.w900,
            ),),
            onPressed: (){
              exit(0);
            },
          ),
          FlatButton(
            child: Text("SənÖl vurmuram mən!!!",style: TextStyle(
              fontSize:20.0 ,
              color: Colors.black,
              fontFamily: "Schyler",
              fontWeight: FontWeight.w900,
            ),),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


  Future<void>signIngoogle() async {
    final GoogleSignIn googleSignIn=  GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    print("User Name:");
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    AuthResult result = await _auth.signInWithCredential(credential);
    var _user=result.user;
    print("${_user.displayName}${_user.displayName}${_user.displayName}${_user.displayName}{_user.displayName}");
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          centerTitle: true,
          title: Text("Log In",style: TextStyle(fontFamily: "Schyler",fontWeight: FontWeight.w900),),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/a/ab/Android_O_Preview_Logo.png",
                      height: 100.0,
                    ),
                  ),

                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(
                            fontSize:20.0 ,
                            color: Colors.red,
                            fontFamily: "Schyler",
                            fontWeight: FontWeight.w900,
                          ),
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(

                              fontFamily: "Schyler",
                              fontWeight: FontWeight.w900,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)
                            ),
                            labelText: "Enter E-mail",
                            labelStyle: TextStyle(
                              fontFamily: "Schyler",
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          validator: (val) {
                            if ((val.isEmpty) || !(val.indexOf(" ")==-1)) {
                              print(val.indexOf(" ")==-1);
                              return "*";
                            }
                            else if (!validate.isEmail(val)) {
                              return "Invalid E-mail";
                            }
                          },
                          autovalidate: true,
                          onSaved: (input){
                            setState(() {
                              _email=input.toString().trim();
                            });

                          },
                        ),

                        TextFormField(
                          onSaved: (input){
                            setState(() {
                              _password=input.toString().trim();
                            });
                          },
                          style: TextStyle(
                            fontSize:20.0 ,
                            color: Colors.red,
                            fontFamily: "Schyler",
                            fontWeight: FontWeight.w900,
                          ),
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontFamily: "Schyler",
                              fontWeight: FontWeight.w900,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)
                            ),
                            labelText: "Enter Password",
                            labelStyle: TextStyle(
                              fontFamily: "Schyler",
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty || !(val.indexOf(" ")==-1)) {
                              return "*";
                            } else if (val.length < 4) {
                              return "Too short password";
                            } else if (val.length > 50) {
                              return "Too long password";
                            }
                          },
                          obscureText: true,
                          autovalidate: true,
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Forgot Password?",style: TextStyle(fontSize:18.0,color: Colors.red,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: RaisedButton(
                            splashColor: Colors.white,
                            onPressed: (){
                              LetSignIn();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)
                            ),
                            color: Colors.red,
                            disabledColor:Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  Text("Log In",style: TextStyle(fontSize:18.0,color: Colors.white,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
                                  Icon(Icons.send,color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:25.0),
                          child: RaisedButton(
                            splashColor: Colors.redAccent,
                            onPressed: (){
                              Navigator.pushReplacementNamed(context,'/signup');

                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.redAccent,width: 2.0)
                            ),
                            color: Colors.white,
                            disabledColor:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  Text("Sign Up",style: TextStyle(fontSize:18.0,color: Colors.redAccent,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
                                  Icon(Icons.keyboard_backspace,color: Colors.redAccent),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Or",style: TextStyle(fontSize:18.0,color: Colors.redAccent,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: RaisedButton(
                            splashColor: Colors.redAccent,
                            onPressed: () {
                              signIngoogle();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.redAccent,width: 2.0)
                            ),
                            color: Colors.white,
                            disabledColor:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                children: <Widget>[
                                  Text("Continue with Google",style: TextStyle(fontSize:14.0,color: Colors.redAccent,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
                                  Image.network("https://storage.googleapis.com/support-forums-api/avatar/profile-14557-8958892013374273126.jpg",height: 24.0,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
