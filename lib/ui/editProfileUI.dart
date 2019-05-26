import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _formkey = GlobalKey<FormState>();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController name = TextEditingController();
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

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');
  }

  _getCurrentUser() async {
    mCurrentUser = await _auth.currentUser();
    print(mCurrentUser.uid);
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Image Upload'),
          centerTitle: true,
        ),
        body: Column(
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
            StreamBuilder<Object>(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  String prename = '';
                  DocumentReference documentReference = Firestore.instance
                      .collection("users")
                      .document(mCurrentUser.uid);
                  documentReference.get().then((datasnapshot) {
                    if (datasnapshot.exists) {
                      print(datasnapshot.data['username'].toString());
                      prename = datasnapshot.data['weight'].toString();
                    } else {
                      print("No such user");
                    }
                  });
                  print(prename);
                  return Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.green,
                            height: 100,
                            width: 100,
                            // child: ClipOval(
                            //   child: Image.network(
                            //     datasnapshot.data['weight'].toString(),
                            //     width: 100,
                            //     height: 100,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                labelText: "Username",
                                hintText:
                                    "Insert new username left void to not change",
                                icon: Icon(Icons.person)),
                            validator: (value) {},
                          ),
                          TextFormField(
                            controller: weight,
                            decoration: InputDecoration(
                                labelText: "Weight",
                                hintText:
                                    "Insert new weight left void to not change",
                                icon: Icon(Icons.pregnant_woman)),
                            validator: (value) {},
                          ),
                          TextFormField(
                            controller: height,
                            decoration: InputDecoration(
                                labelText: "Height",
                                hintText:
                                    "Insert new height left void to not change",
                                icon: Icon(Icons.accessibility)),
                            validator: (value) {},
                          ),
                          RaisedButton(
                            child: Text("Save"),
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                if (name.text != '') {
                                  Firestore.instance
                                      .collection('users')
                                      .document(mCurrentUser.uid)
                                      .updateData({'username': name.text});
                                }
                                if (weight.text != '') {
                                  Firestore.instance
                                      .collection('users')
                                      .document(mCurrentUser.uid)
                                      .updateData({'weight': weight.text});
                                }
                                if (height.text != '') {
                                  Firestore.instance
                                      .collection('users')
                                      .document(mCurrentUser.uid)
                                      .updateData({'height': height.text});
                                }
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                })
          ],
        )
        // floatingActionButton: new FloatingActionButton(
        //   onPressed: getImage,
        //   tooltip: 'Add Image',
        //   child: new Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(user)
          .collection('all_food_add')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        return _buildList(context, snapshot.data.documents);
      },
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
