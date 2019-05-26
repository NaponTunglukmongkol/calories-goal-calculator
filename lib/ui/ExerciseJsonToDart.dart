import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExeciseJsonToDart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExeciseJsonToDartState();
  }
}

class ExeciseJsonToDartState extends State {
  String url =
      'https://raw.githubusercontent.com/benning55/exercise/master/db.json?fbclid=IwAR2ciBvMxgSOJ9_IPBNVEPfOZAEeYhhAncRaGmvzef92clHLzn6XRQxUB6Q';
  var data;
  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      data = json.decode(response.body).cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercise")),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, i) {
                return new Card(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              // child: Image.network(data[i]["thumbnailUrl"])
                              child: Text(data[i]["type"]))
                        ],
                      ),
                    )
                  ],
                ));
              },
            ),
    );
  }
}
