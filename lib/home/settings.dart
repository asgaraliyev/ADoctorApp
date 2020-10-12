import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asgaraliyev/main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences preferences;
  void getLocalData() async {
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
            "Signing Out From Account",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              fontFamily: "Schyler",
              color: Colors.black,
            ),
          ),
          content: new Text(
            "Are you sure?",
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
              child: new Text(
                "Yes",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  fontFamily: "Schyler",
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                removeuserinLocal();
              },
            ),
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  fontFamily: "Schyler",
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removeuserinLocal() async {
    await FirebaseAuth.instance.signOut();
    await preferences.clear();
    await Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  void initState() {
    super.initState();
    getLocalData();
  }
  String dropdownValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  
                  child: Icon(
                      Icons.language
                  ),
                  margin: EdgeInsets.fromLTRB(40.0,0.0,0.0,0.0),
                ),
                Container(

                  child: Text(
                    "Language",
                    style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    fontFamily: "Schyler",
                    color: Colors.black,
                  ),
                  ),
                  margin: EdgeInsets.fromLTRB(20.0,0.0,0.0,0.0),
                ),
                Container(

                  child: DropdownButton<String>(
                    value: dropdownValue,

                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['English', 'Russian', 'Turkish', 'Azerbaijan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17.0,
                          fontFamily: "Schyler",
                          color: Colors.black,
                        ),),

                      );
                    }).toList(),
                  ),
                  margin: EdgeInsets.all(20.0),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(20.0),
            color: Colors.white,
            child: ListTile(
              onTap: () {
                _showDialog();
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 40.0,
              ),
              title: Text(
                "Sign Out ",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  fontFamily: "Schyler",
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            margin: EdgeInsets.all(20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Text(
                  "About us ",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    fontFamily: "Schyler",
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Lorem Ipsum is   dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  style: TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.w900,
                    fontSize: 17.0,
                    fontFamily: "Schyler",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

//          Card(
//            margin: EdgeInsets.all(20.0),
//            color: Colors.white,
//            child: ListTile(
//              onTap: (){
//              },
//              leading: Icon(Icons.exit_to_app,size: 40.0,),
//              title: Text(
//                "asdas ",
//                style: TextStyle(
//                  fontWeight: FontWeight.w900,
//                  fontSize: 20.0,
//                  fontFamily: "Schyler",
//                  color: Colors.black,
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
