import 'package:flutter/material.dart';
import 'package:hibescanner/setting_screen.dart';
import 'package:hibescanner/sfg.dart';

import 'Home.dart';
import 'Sfc.dart';
import 'help_screen.dart';

class DocDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
