import 'package:flutter/material.dart';
import 'works.dart';
import 'homeofhome.dart';
import 'profile.dart';
import 'settings.dart';

import 'dart:io';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int crrntPNm = 0;
  String headerName = "";
  var willLoad;
  void itempressed(int index) {
    setState(() {
      crrntPNm = index;
      switch (crrntPNm) {
        case 0:
          headerName = "Work";
          willLoad = Works();
          break;
        case 1:
          headerName = "Home";
          willLoad = HomeOfHome();
          break;
        case 2:
          headerName = "Profile";
          willLoad = Profile();
          break;
        case 3:
          headerName = "Settings";
          willLoad = Settings();
          break;
      }
    });
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

  @override
  void initState() {
    super.initState();
    itempressed(0);

  }

  @override

  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
       _onBackPressed();
      },
      child: Scaffold(
        body: willLoad,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 750.0),
          child: Container(
            height: 85,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.navigate_before,
                      size: 40,
                      color: Colors.transparent,
                    ),
                    Text(
                      headerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35.0,
                        fontFamily: "Schyler",
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.navigate_before,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.storage),
                title: Text(
                  "Work",
                  style: TextStyle(
                      fontFamily: "Schyler",
                      fontWeight: FontWeight.w900,
                      fontSize: 19.0),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: TextStyle(
                      fontFamily: "Schyler",
                      fontWeight: FontWeight.w900,
                      fontSize: 19.0),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  "Profile",
                  style: TextStyle(
                      fontFamily: "Schyler",
                      fontWeight: FontWeight.w900,
                      fontSize: 19.0),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: "Schyler",
                      fontWeight: FontWeight.w900,
                      fontSize: 19.0),
                )),
          ],
          currentIndex: crrntPNm,
          onTap: itempressed,
        ),
      ),
    );
    ;
  }
}
