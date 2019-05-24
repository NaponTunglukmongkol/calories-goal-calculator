import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/ui/FoodUI.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:health_app/ui/editProfileUI.dart';
import 'package:health_app/ui/introscreen.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool loading = false;
String _showEmail = "can't load data";
String _showUsername = "can't load data";

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(4, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
];

class Home extends StatefulWidget {
  final String user;

  Home(this.user);
  @override
  HomeState createState() => HomeState(user);
}

class HomeState extends State<Home> {
  String user;
  HomeState(this.user);
  FirebaseAuth auth = FirebaseAuth.instance;

  String _showEmail = "";
  String _showUsername = "";

  Widget _showCircularProgress() {
    if (loading) {
      return Container(
          color: Color.fromARGB(200, 255, 255, 255),
          child: Center(
            child: JumpingDotsProgressIndicator(
              fontSize: 80.0,
              milliseconds: 100,
              color: Colors.blueAccent,
              numberOfDots: 4,
              dotSpacing: 2,
            ),
          ));
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          Firestore.instance.collection('users').document('$user').snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // Stream<DocumentSnapshot> snapshot555 = Firestore.instance
        //     .collection('users')
        //     .document('${user.uid}')
        //     .snapshots();
        if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _showCircularProgress();
          default:
            // return Container(
            //   child: Column(
            //     children: <Widget>[
            //       Text(snapshot.data['name']),
            //     ],
            //   ),
            // );
            return Scaffold(
              appBar: AppBar(
                title: Text("data"),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                    ),
                  ),
                ),
              ),
              body: Container(
                  color: Colors.blueGrey,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new StaggeredGridView.count(
                        crossAxisCount: 4,
                        staggeredTiles: _staggeredTiles,
                        children: <Widget>[
                          // const Tile1(String target),
                          const Tile1(Colors.white, Icons.wifi),
                          Tile2(user),
                          const Tile3(Colors.white, Icons.map),
                          const _Example01Tile(Colors.white, Icons.send),
                          const _Example01Tile(
                              Colors.white, Icons.airline_seat_flat),
                          const _Example01Tile(Colors.white, Icons.bluetooth),
                          const _Example01Tile(Colors.white, Icons.bluetooth),
                        ],
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        padding: const EdgeInsets.all(5.0),
                      ))),
              drawer: Drawer(
                child: new Column(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                        ),
                      ),
                      accountName: Text(snapshot.data['username']),
                      accountEmail: Text(snapshot.data['email']),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          "A",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("Goal"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Edit Profile"),
                      onTap: () async {
                        NavigatorState navigator = Navigator.of(context);
                        Navigator.of(context).pop(); // Added
                        Route route = ModalRoute.of(context);
                        while (navigator.canPop())
                          navigator.removeRouteBelow(route);
                        await navigator.push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => CameraScreen(),
                          ),
                        );
                        // Removed setState(), the page will be rebuilt automatically
                        // _instructions = '<- Click';
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CameraScreen()));
                      },
                    ),
                    ListTile(
                      title: Text("Setting"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Features"),
                      onTap: () async {
                        NavigatorState navigator = Navigator.of(context);
                        Navigator.of(context).pop(); // Added
                        Route route = ModalRoute.of(context);
                        while (navigator.canPop())
                          navigator.removeRouteBelow(route);
                        await navigator.push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Intro(),
                          ),
                        );
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Intro()));
                      },
                    ),
                    ListTile(
                      title: Text("SignOut"),
                      onTap: () {
                        _logOut();
                      },
                    )
                  ],
                ),
              ),
            );
        }
      },
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("data"),
    //     centerTitle: true,
    //     flexibleSpace: Container(
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //           begin: Alignment.centerLeft,
    //           end: Alignment.centerRight,
    //           colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: Container(
    //       color: Colors.blueGrey,
    //       child: Padding(
    //           padding: const EdgeInsets.only(top: 5.0),
    //           child: new StaggeredGridView.count(
    //             crossAxisCount: 4,
    //             staggeredTiles: _staggeredTiles,
    //             children: _tiles,
    //             mainAxisSpacing: 0.0,
    //             crossAxisSpacing: 0.0,
    //             padding: const EdgeInsets.all(5.0),
    //           ))),
    //   drawer: Drawer(
    //     child: new Column(
    //       children: <Widget>[
    //         new UserAccountsDrawerHeader(
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.centerLeft,
    //               end: Alignment.centerRight,
    //               colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
    //             ),
    //           ),
    //           accountName: Text(this._showUsername),
    //           accountEmail: Text(this._showEmail),
    //           currentAccountPicture: CircleAvatar(
    //             backgroundColor: Colors.white,
    //             child: Text(
    //               "A",
    //               style: TextStyle(fontSize: 40.0),
    //             ),
    //           ),
    //         ),
    //         FlatButton(
    //           child: Text("SignOut"),
    //           onPressed: () {
    //             _logOut();
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    await auth.signOut().then((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(1.0),
            child: new Icon(
              iconData,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class Tile1 extends StatelessWidget {
  const Tile1(this.backgroundColor, this.iconData);
  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      child: new InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(20.0),
            color: const Color(0xFF00FF00),
            constraints: BoxConstraints(minWidth: 100.0, minHeight: 150.0),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[Text("cal")],
                ),
                Container(
                    color: Colors.blueAccent,
                    alignment: Alignment.center,
                    constraints:
                        BoxConstraints(minWidth: 100.0, minHeight: 100.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.brown,
                          child: Text("1000",
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          color: Colors.indigo,
                          child: Text("/1000 cal",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class Tile2 extends StatelessWidget {
  String user;
  Tile2(this.user);
  // final Color backgroundColor;
  // final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      child: new InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "routeName"),
                    builder: (context) => FoodPage(user)));
          },
          child: Container(
            margin: const EdgeInsets.all(20.0),
            color: const Color(0xFF00FF00),
            constraints: BoxConstraints(minWidth: 100.0, minHeight: 150.0),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[Text("Food")],
                ),
                Container(
                    color: Colors.blueAccent,
                    alignment: Alignment.center,
                    constraints:
                        BoxConstraints(minWidth: 100.0, minHeight: 100.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text("1000",
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          child: Text("/1000 cal",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class Tile3 extends StatelessWidget {
  const Tile3(this.backgroundColor, this.iconData);
  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      child: new InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(20.0),
            color: const Color(0xFF00FF00),
            constraints: BoxConstraints(minWidth: 100.0, minHeight: 150.0),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[Text("Step")],
                ),
                Container(
                    color: Colors.blueAccent,
                    alignment: Alignment.center,
                    constraints:
                        BoxConstraints(minWidth: 100.0, minHeight: 100.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text("1000",
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          child: Text("/1000 cal",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
