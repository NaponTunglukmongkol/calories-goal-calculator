import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/ui/FoodUI.dart';
import 'package:health_app/ui/Home.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:health_app/ui/detailFood.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../Boloc/counterBloc.dart';

class ListFood extends StatefulWidget {
  const ListFood(this.databaseName);
  final String databaseName;
  @override
  State<StatefulWidget> createState() {
    return ListFoodState(databaseName);
  }
}

class ListFoodState extends State<ListFood> {
  final CounterBloc _counterBloc = CounterBloc();
  ListFoodState(this.databaseName) {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }
  // ListFoodState(this.databaseName);
  final String databaseName;
  List<Map<String, String>> _listFood = [];
  List<Map<String, String>> _searchResult = [];
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;
  String filter;

  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "Menu List",
    style: new TextStyle(color: Colors.white),
  );
  String _searchText = "";

  @override
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(databaseName).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
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
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _buildBody(context);
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    if (_listFood.length < snapshot.length) {
      for (int i = 0; i < snapshot.length; i++) {
        _listFood.add({
          "name": snapshot[i].data["name"].toString(),
          "unit": snapshot[i].data["unit"].toString(),
          "cal": snapshot[i].data["cal"].toString()
        });
      }
    }

    return Scaffold(
        appBar: buildAppBar(context),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Flexible(
                  child: _searchResult.length != 0 ||
                          _controller.text.isNotEmpty
                      ? new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResult.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new ListTile(
                              title: new Text(_searchResult[index]['name']),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider<CounterBloc>(
                                              bloc: _counterBloc,
                                              child:
                                                  CounterPage(_listFood[index]),
                                            )));
                              },
                            );
                          },
                        )
                      : new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _listFood.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new ListTile(
                              title: new Text(_listFood[index]['name']),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider<CounterBloc>(
                                              bloc: _counterBloc,
                                              child:
                                                  CounterPage(_listFood[index]),
                                            )));
                              },
                            );
                          },
                        ))
            ],
          ),
        ));
  }

  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Menu List",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchResult.clear();
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    _searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _listFood.length; i++) {
        if (_listFood[i]['name']
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          _searchResult.add({
            "name": _listFood[i]["name"],
            "unit": _listFood[i]["unit"],
            "cal": _listFood[i]["cal"]
          });
        }
      }
    }
  }
}
