import 'package:hibescanner/setting_screen.dart';
import 'package:hibescanner/sfg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'Sfc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import 'help_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController renameController = new TextEditingController();
  String directory;
  List file = new List();
  MethodChannel channel = MethodChannel('opencv');
  File _file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
  }
  static GlobalKey<AnimatedListState> animatedListKey =
  GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {

    return Stack( // <-- STACK AS THE SCAFFOLD PARENT
        children: [
    Container(
    decoration: BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/bck.png'), // <-- BACKGROUND IMAGE
    fit: BoxFit.cover,
    ),
    ),
    ),

     Scaffold(

      appBar: AppBar(
        title: Text("HibeScanner"),

      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[

                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.history),
                      title: new Text("Home "),


                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));

                      }),
                  new ListTile(
                      leading: Icon(Icons.history),
                      title: new Text("Camera"),


                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Sfc ()));

                      }),
                  new ListTile(
                      leading: Icon(Icons.history),
                      title: new Text("Gallery"),


                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Sfg ()));

                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.settings),
                      title: new Text("About"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.help),
                      title: new Text("Help"),
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));

                      }),
                ],
              ),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Text('Camera'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Sfc()),
                  );
                },
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                width: 2,
                height: 15,
              ),
              FlatButton(
                child: Text('Import from gallery'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Sfg ()),
                  );
                },
              )
            ],
          )),
      body: FutureBuilder(
          builder: (context, snapshot){

            return Container(

              child: ListView.builder(
                  itemCount: file.length,
                  itemBuilder: (BuildContext context, int index) {
                    _listofFiles();
                    return Card(
                      color: Colors.grey[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.picture_as_pdf,
                              color: Colors.white,),
                            title: Text(file[index].toString().substring(file[index].toString().lastIndexOf("/")+1).replaceAll("'",""),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton.icon(
                                color: Colors.grey[800],
                                icon: Icon(Icons.folder_open,
                                  color: Colors.white,),
                                label: Text(
                                  "Open",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){OpenFile.open(file[index].path);},
                              ),

                                  FlatButton.icon(
                                     color: Colors.grey[800],
                                icon: Icon(Icons.share,
                                  color: Colors.white,),
                                label: Text(
                                  "Share",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){
                                  Share.shareFiles([file[index].path], text: 'Share PDF');
                                },
                              ),


                              FlatButton.icon(
                                color: Colors.grey[800],
                                icon: Icon(Icons.edit,
                                  color: Colors.white,),
                                label: Text(
                                  "Rename",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0)), //this right here
                                          child: Container(
                                            height: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Rename File",
                                                  ),
                                                  TextField(
                                                    controller: renameController,
                                                    decoration: InputDecoration(
                                                        hintText: 'What do you want to name the file?'),
                                                  ),
                                                  SizedBox(
                                                    width: 320.0,
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        String name = file[index].path;
                                                        String newname = name.substring(0,name.lastIndexOf("/")+1)+renameController.text+".pdf";
                                                        file[index].rename(newname);
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      color: Colors.grey[800],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                              FlatButton.icon(
                                color: Colors.grey[800],
                                icon: Icon(Icons.delete,
                                  color: Colors.white,),
                                label: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){
                                  file[index].delete();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
      ),

    );

  }
  void _listofFiles() async {
    directory = (await getExternalStorageDirectory()).parent.parent.parent.parent.path;
    setState(() {
      file = io.Directory("$directory/HibeScanner/").listSync();  //use your folder name insted of resume.
    });
  }
}
