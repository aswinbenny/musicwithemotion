import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'happy.dart';
import 'angry.dart';
import 'neutral.dart';
import 'sad.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
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

    //Future<String> sendFileToAPI({File file})async{
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.8:5000/predict'),
    );
    Map<String, String>headers = {
      "Content-type": "multipart/form-data",
      "accept": "application/json"
    };
    request.files.add(
      http.MultipartFile
        ('file',
        _image.readAsBytes().asStream(),
        _image.lengthSync(),
        filename: basename(_image.path),
        contentType: MediaType('image', basename(_image.path)
            .split(".")
            .last),
      ),
    );
    request.headers.addAll(headers);
    try {
      var res = await request.send();
      var result= await res.stream.bytesToString();
      final de= json.decode(result);
      //int a=(result);
      //print (a);
      String a="0";
      String b="1";
      String c="2";
      String d="3";
      if(de==a)
        {
          print("hap");
          Navigator.push(
            this.context,
            MaterialPageRoute(
                builder: (context) => MyApph()
            ),);
        }
      if(de==b)
      { print("sad");
        Navigator.push(
          this.context,
          MaterialPageRoute(
              builder: (context) => MyApps()
          ),);
      }
      if(de==c)
      {print("neu");
        Navigator.push(
          this.context,
          MaterialPageRoute(
              builder: (context) => MyAppn()
          ),);
      }
      if(de==d)
      {print("ang");
        Navigator.push(
          this.context,
          MaterialPageRoute(
              builder: (context) => MyAppa()
          ),);
      }
    } catch (err) {
      print("ERROR: $err");
      return "error";
    }
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

    );
  }
}
