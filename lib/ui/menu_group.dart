import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:health_app/ui/list_food.dart';
import './image_pick.dart';

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
  const TileFood(Text("Beef & Veal"), AssetImage('assets/images/icon/chop.png'),
      'beef & veal_data'),
  const TileFood(Text("Cakes & Pies"),
      AssetImage('assets/images/icon/piece-of-cake.png'), 'cakes&pies_data'),
  const TileFood(Text("Dishes"),
      AssetImage('assets/images/icon/fried-rice.png'), 'dishes_data'),
  const TileFood(Text("Fastfood"), AssetImage('assets/images/icon/fries.png'),
      'fast_food_data'),
  const TileFood(Text("Fish & Seafood"),
      AssetImage('assets/images/icon/sea.png'), 'fish&seafood_data'),
  const TileFood(Text("Fruits"), AssetImage('assets/images/icon/apple.png'),
      'fruits_data'),
  const TileFood(Text("Juices"),
      AssetImage('assets/images/icon/orange-juice.png'), 'juices_data'),
  const TileFood(
      Text("Meat"), AssetImage('assets/images/icon/steak.png'), 'meat_data'),
  const TileFood(
      Text("Soup"), AssetImage('assets/images/icon/soup.png'), 'soup_data'),
  const TileFood(Text("Vegetables"), AssetImage('assets/images/icon/salad.png'),
      'vegetables_data'),
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
              // print(Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => CameraScreen()))
              //     .runtimeType);
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListFood(databaseName)));
            },
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  new Container(
                      height: 76, child: Image(image: icon, width: 60.0)),
                  text,
                ]))));
  }
}
