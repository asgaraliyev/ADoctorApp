import 'package:asgaraliyev/firebaseworks/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:validated/validated.dart' as validate;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var username, email, photo;
  final usernameKey = new GlobalKey<FormState>();
  final emailKey = new GlobalKey<FormState>();
  String changeUsernameVal;
  String changeEmailVal;
  String passwordToChangeEmail;
  bool keyboard = false;
  getUser() async {
    await FirebaseAuth.instance.currentUser().then((onValue) {
      setState(() {
        username = onValue.displayName;
        email = onValue.email;
        photo = onValue.photoUrl;
        print(photo);
        print("sekil linki");
      });
    }).catchError((onError) {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          keyboard = true;
        });
      },
    );
  }

  File _image;

  Future uploadPhoto() async {
    print("joined uploadPhoto function");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print(_image);
      print("image selected");
    });
    String filName = basename(_image.path);
    StorageReference firebasStorage =
        FirebaseStorage.instance.ref().child(filName);
    StorageUploadTask uploadTask = firebasStorage.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var dowurl = await taskSnapshot.ref.getDownloadURL();
    var url = dowurl.toString();
    print(url);
    print(url);
    print(url);
    FirebaseAuth.instance.currentUser().then((val) {
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.photoUrl = url;

      val.updateProfile(updateUser);
    });
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await user.reload();
    user = await FirebaseAuth.instance.currentUser();
    setState(() {
      photo = dowurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    userAbsolutlyWanttoChangeUsername() async{
      usernameKey.currentState.save();
      print("usernameKey.currentState.validate():${usernameKey.currentState.validate()}");
      print("usernameKey.currentState.validate():${usernameKey.currentState.validate()}");
      print("changeUsernameVal:${changeUsernameVal}");
      if(changeUsernameVal==username){
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content:Text("Your username is already taken",style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
            fontFamily: "Schyler",
            color: Colors.white,
          ),),
        ));
      }else{

        FirebaseAuth.instance.currentUser().then((onValue) async{
          print("FirebaseAuth.instance.currentUser().then((onValue){:${onValue.displayName}")  ;
          print("FirebaseAuth.instance.currentUser().then((onValue){:${onValue.displayName}")  ;
          print("FirebaseAuth.instance.currentUser().then((onValue){:${onValue.displayName}")  ;
          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName = changeUsernameVal;
          onValue.updateProfile(updateUser);

          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content:Text("Username updated successfully.",style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25.0,
              fontFamily: "Schyler",
              color: Colors.white,
            ),),
          ));

        }).catchError((onError){
          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("$onError",),

          ));
          print("FirebaseAuth.instance.currentUser() }).catchError((onError){:$onError")  ;
          print("FirebaseAuth.instance.currentUser() }).catchError((onError){:$onError")  ;
          print("FirebaseAuth.instance.currentUser() }).catchError((onError){:$onError")  ;

        });
        FirebaseUser user =await FirebaseAuth.instance.currentUser();
        await user.reload();
        user = await FirebaseAuth.instance.currentUser();
        print( "${user.uid},${user.email},${user.displayName}  this user  changed username-----");
        setState(() {
          username=changeUsernameVal;
        });

      }
    }

    Future _showDialog(String message, var funk) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(
              message,
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
                child:(funk=="pp"|| funk=="changeU")? new Text(
                  "Yes",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    fontFamily: "Schyler",
                    color: Colors.red,
                  ),
                ): Text(
                  "Okey",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    fontFamily: "Schyler",
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  if (funk == "pp") {
                    uploadPhoto();
                  } else if (funk == "resetP") {
                    print("reset password");
                  }else if(funk=="changeU"){
                    print("userAbsolutlyWanttoChangeUsername();");
                    userAbsolutlyWanttoChangeUsername();
                  }else if(funk=="changeE"){
                    print("userAbsolutlyWanttoChangeEmail();");

                  }
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: (funk == "pp"||funk=="changeU"||funk=="changeE")
                    ? Text(
                  "No. Thanks",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    fontFamily: "Schyler",
                    color: Colors.black,
                  ),
                )
                    : new Text(
                        "",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                          fontFamily: "Schyler",
                          color: Colors.black,
                        ),
                      ),
                onPressed: () {
                  print("process canceled!!!!!!");
                  print("process canceled!!!!!!");
                  print("process canceled!!!!!!");
                  print("process canceled!!!!!!");
                  print("process canceled!!!!!!");

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    changeUsername() async{
      if(usernameKey.currentState.validate()){
        _showDialog("Are you sure to change username?", "changeU");

      }else{
        print("usernameKey.currentState.validate():${usernameKey.currentState.validate()}");
      }
    }


    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FlatButton(
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundImage: (photo == null)
                          ? AssetImage("assets/loading.gif")
                          : NetworkImage(photo),
                      radius: 75.0,
                    ),
                    color: Colors.transparent,
                    disabledColor: Colors.transparent,
                    onPressed: () {
                      _showDialog(
                          "Do you want to change profile picture?", "pp");
                    },
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.black38,
                    onPressed: () {
                      _showDialog(
                          "Do you want to change profile picture?", "pp");
                    },
                    padding: EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      "Change Profile Photo",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: "Schyler",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          0.0,
                          20.0,
                          0.0,
                          0.0,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      Form(
                        key: usernameKey,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                0.0,
                                20.0,
                                00.0,
                                0.0,
                              ),
                              width: 210.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "$username",
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontFamily: "Schyler",
                                  fontWeight: FontWeight.w900,
                                ),
                                onSaved: (val){
                                  setState(() {
                                    changeUsernameVal=val.toString().trim();
                                  });
                                },
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
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                20.0,
                                30.0,
                                0.0,
                                0.0,
                              ),
                              child: RaisedButton(
                                onPressed: () {
                                  changeUsername();
                                },
                                color: Colors.redAccent,
                                disabledColor: Colors.redAccent,
                                child: Text(
                                  "Change",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontFamily: "Schyler",
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(20.0),
                          child: RaisedButton(
                            onPressed: () {

                              FirebaseAuth.instance.currentUser().then((onValue) {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: onValue.email).then((val){
                                  _showDialog(
                                      "We have send you mail to change password.",
                                      "resetP");
                                }).catchError((onError){
                                  print(onError);
                                  _showDialog(
                                      "$onError",
                                      "resetP");
                                  print(onError);
                                  print(onError);
                                  print(onError);
                                  print(onError);
                                  print(onError);
                                });
                              });

                            },
                            color: Colors.redAccent,
                            disabledColor: Colors.redAccent,
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Schyler",
                                fontWeight: FontWeight.w900,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
