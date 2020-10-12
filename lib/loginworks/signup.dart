import 'package:flutter/material.dart';
import 'package:validated/validated.dart' as validate;
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "$_email email is allready in use",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              fontFamily: "Schyler",
              color: Colors.black,
            ),
          ),

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
  String _email,_password,_username;
  Future LetSignUp() async{
    FirebaseAuth _auth =await FirebaseAuth.instance;
  if(formKey.currentState.validate()){
    formKey.currentState.save();
    print("$_username -- $_email -- $_password");
    print("${formKey.currentState.validate()} User entered CORRECT inputs in signup page");
    print("$_username -- $_email -- $_password");
    print("User entered CORRECT inputs in signup page");
    await _auth.createUserWithEmailAndPassword(email: _email, password: _password).then((result)async{
      print(result.user.email);
      print(result.user.email);
      print(result.user.email);
      print(result.user.email);
      print(result.user.email);
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      FirebaseAuth.instance.currentUser().then((val) {
        UserUpdateInfo updateUser = UserUpdateInfo();
        updateUser.displayName = _username;
        val.updateProfile(updateUser);
      });
      FirebaseUser user =await _auth.currentUser();
      await user.reload();
       user = await _auth.currentUser();
      print( "${user.uid},${user.email},${user.displayName} , $_password this user has been created-----");
      await Navigator.pushReplacementNamed(context, "/home");



    }).catchError((onError){
      print(onError);
      print(onError);
      print(onError);
      print(onError);
      _showDialog();
    });



  }else{
    print("${formKey.currentState.validate()} User entered FALSE inputs in signup page");
    print("User entered FALSE inputs in signup page ERROR");
    print("ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR");
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
          title: Text("Sign Up",style: TextStyle(fontFamily: "Schyler",fontWeight: FontWeight.w900),),
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
                            fontSize:18.0 ,
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
                            labelText: "Enter username",
                            labelStyle: TextStyle(
                              fontFamily: "Schyler",
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty || !(val.indexOf(" ")==-1)) {
                              return "*";
                            }
                            else if (val.length < 4) {
                              return "Too short username";
                            } else if (val.length > 50) {
                              return "Too long username";
                            }
                          },
                          autovalidate: true,
                          onSaved: (val){
                            setState(() {
                              _username=val.toString().trim();
                            });
                          },
                        ),

                        TextFormField(
                          style: TextStyle(
                            fontSize:18.0 ,
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
                          onSaved: (val){
                            setState(() {
                              _email=val.toString().trim();
                            });
                          },
                        ),

                        TextFormField(
                          style: TextStyle(
                            fontSize:18.0 ,
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
                          onSaved: (val){
                            setState(() {
                              _password=val.toString().trim();
                            });
                          },
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: RaisedButton(
                            splashColor: Colors.white,
                            onPressed: (){
                              LetSignUp();
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
                                  Text("Sign Up",style: TextStyle(fontSize:18.0,color: Colors.white,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
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
                              Navigator.pushReplacementNamed(context,'/login');

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
                                  Text("Login",style: TextStyle(fontSize:18.0,color: Colors.redAccent,fontFamily: "Schyler",fontWeight: FontWeight.w900),),
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
                          padding: const EdgeInsets.symmetric(horizontal:25.0),
                          child: RaisedButton(
                            splashColor: Colors.redAccent,
                            onPressed: (){
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
