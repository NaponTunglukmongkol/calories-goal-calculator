import 'dart:io';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CameraScreenState();
  }
}

class CameraScreenState extends State {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromPhone() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image picker",
        ),
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            _image == null ? Text("No image selected") : Image.file(_image),
            RaisedButton(child: Icon(Icons.camera),
              onPressed: () {
                getImage();
              },
            ),
            RaisedButton(child: Icon(Icons.add),
              onPressed: () {
                getImageFromPhone();
              },
            )
          ],
        ),
      ),
    );
  }
}
