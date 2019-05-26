import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  String user;
  CameraScreen(this.user);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CameraScreenState(user);
  }
}

// class CameraScreenState extends State {
//   File _image;

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = image;
//     });
//   }

//   Future getImageFromPhone() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Image picker",
//         ),
//       ),
//       body: Form(
//         child: ListView(
//           children: <Widget>[
//             _image == null ? Text("No image selected") : Image.file(_image),
//             RaisedButton(child: Icon(Icons.camera),
//               onPressed: () {
//                 getImage();
//               },
//             ),
//             RaisedButton(child: Icon(Icons.add),
//               onPressed: () {
//                 getImageFromPhone();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class CameraScreenState extends State {
  String user;
  CameraScreenState(this.user);
  File sampleImage;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  Future getCamera() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Image Upload'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.add),
              onPressed: () {
                getImage();
              },
            ),
            RaisedButton(
              child: Icon(Icons.camera),
              onPressed: () {
                getCamera();
              },
            ),
            new Center(
              child: sampleImage == null
                  ? Text('Select an image')
                  : enableUpload(),
            ),
          ],
        )
        // floatingActionButton: new FloatingActionButton(
        //   onPressed: getImage,
        //   tooltip: 'Add Image',
        //   child: new Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 300.0),
          Text(sampleImage.toString()),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () async {
              final StorageReference firebaseStorageRef = FirebaseStorage
                  .instance
                  .ref()
                  .child('$user')
                  .child('profile');
              final StorageUploadTask task =
                  firebaseStorageRef.putFile(sampleImage);

              // final ref = FirebaseStorage.instance
              //     .ref()
              //     .child('$user')
              //     .child('profile');
              var url = await firebaseStorageRef.getDownloadURL();
              print(url);
              Firestore.instance
                  .runTransaction((Transaction transaction) async {
                DocumentReference reference =
                    Firestore.instance.collection('users').document('$user');
                await reference.updateData({
                  "urlProfilea": url,
                });
              });
            },
          )
        ],
      ),
    );
  }
}
