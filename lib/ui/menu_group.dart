import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:health_app/ui/list_food.dart';
import './image_pick.dart';

List<String> _databaseName = [
  'beef & veal_data',
  'cakes&pies_data',
  'dishes_data',
  'fast_food_data',
  'fish&seafood_data',
  'fruits_data',
  'juices_data',
  'meat_data',
  'soup_data',
  'vegetables_data'
];

List<String> _title = [
  'Beef & Veal',
  'Cakes & Pies',
  'Dishes',
  'Fastfood',
  'Fish & Seafood',
  'Fruits',
  'Juices',
  'Meat',
  'Soup',
  'Vegetables'
];

List<String> _pathLogo = [
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
  'assets/images/icon/2.png',
];

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
];
List<Widget> _tiles = const <Widget>[
  const TileFood(Text("Beef & Veal"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Fish & Seafood"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
  const TileFood(Text("Lunch"), AssetImage('assets/images/icon/2.png'),
      'beef & veal_data'),
];

class MenuBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              print(Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraScreen()))
                  .runtimeType);
            },
          )
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: StaggeredGridView.count(
              crossAxisCount: 6,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              padding: const EdgeInsets.all(5.0),
            )),
      ),
    );
  }
}

class TileFood extends StatelessWidget {
  const TileFood(this.text, this.icon, this.databaseName);

  final Text text;
  final AssetImage icon;
  final String databaseName;

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: Colors.white,
        child: new InkWell(
            onTap: () {
              print(Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListFood()))
                  .runtimeType);
            },
            child: new Center(
              child: new Column(
                children: <Widget>[Image(image: icon, width: 80.0), text],
              ),
            )));
  }
}
