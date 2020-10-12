
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
class HomeOfHome extends StatefulWidget {
  @override
  _HomeOfHomeState createState() => _HomeOfHomeState();
}

class _HomeOfHomeState extends State<HomeOfHome> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;




  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  new Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Column(
                      children: <Widget>[
                        new RaisedButton(
                          onPressed: () => _openFileExplorer(),
                          child: new Text("Open file picker"),
                        ),

                      ],
                    ),
                  ),
                  new Builder(
                    builder: (BuildContext context) => _loadingPath
                        ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const CircularProgressIndicator())
                        : _path != null || _paths != null
                        ? new Container(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: new Scrollbar(
                          child: new ListView.separated(
                            itemCount: _paths != null && _paths.isNotEmpty
                                ? _paths.length
                                : 1,
                            itemBuilder: (BuildContext context, int index) {
                              final bool isMultiPath =
                                  _paths != null && _paths.isNotEmpty;
                              final String name = 'File $index: ' +
                                  (isMultiPath
                                      ? _paths.keys.toList()[index]
                                      : _fileName ?? '...');
                              final path = isMultiPath
                                  ? _paths.values.toList()[index].toString()
                                  : _path;

                              return new ListTile(
                                title: new Text(
                                  name,
                                ),
                                subtitle: new Text(path),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                            new Divider(),
                          )),
                    )
                        : new Container(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
