import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'music.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMOTION',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title : 'emotion'),
    );
  }

}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _image;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        //centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(

        child: IconButton(
          onPressed: getImage,
          tooltip: 'Increment',

          icon: Icon(Icons.camera),
          color: Colors.cyanAccent,
          iconSize: 100.0,

        ),
      ),

      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApps()
            ),);
        },

        icon: Icon(Icons.add_circle),
        color: Colors.pink,
        iconSize: 70.0,
      ),
    );
  }
}
