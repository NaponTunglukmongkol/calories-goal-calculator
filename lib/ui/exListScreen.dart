import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:health_app/ui/list_food.dart';
// import './image_pick.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
];
List<Widget> _tiles = const <Widget>[
  const TileFood(
      Text("Running"), AssetImage('images/running.png'), 'beef & veal_data'),
  const TileFood(Text("Rope Jumping"), AssetImage('images/jumping-rope.png'),
      'cakes&pies_data'),
  const TileFood(
      Text("Basketball"), AssetImage('images/basketball.png'), 'dishes_data'),
  const TileFood(
      Text("Bowling"), AssetImage('images/bowling.png'), 'fast_food_data'),
  const TileFood(
      Text("Cycling"), AssetImage('images/cycling.png'), 'fish&seafood_data'),
  const TileFood(
      Text("Football"), AssetImage('images/football.png'), 'fruits_data'),
  const TileFood(Text("Golf"), AssetImage('images/golf.png'), 'juices_data'),
  const TileFood(
      Text("Table Tennis"), AssetImage('images/ping-pong.png'), 'meat_data'),
  const TileFood(
      Text("Swimming"), AssetImage('images/swimming-pool.png'), 'soup_data'),
  const TileFood(Text("Volleyball"), AssetImage('images/volleyball.png'),
      'vegetables_data'),
  const TileFood(
      Text("Boxing"), AssetImage('images/boxing.png'), 'vegetables_data'),
  const TileFood(
      Text("Climbling"), AssetImage('images/climbing.png'), 'vegetables_data'),
  const TileFood(
      Text("Martial Arts"), AssetImage('images/karate.png'), 'vegetables_data'),
  const TileFood(
      Text("Tennis"), AssetImage('images/tennis.png'), 'vegetables_data'),
  const TileFood(
      Text("Walk"), AssetImage('images/walking.png'), 'vegetables_data'),
  const TileFood(
      Text("Yoga"), AssetImage('images/meditation.png'), 'vegetables_data'),
];

class ExcerciseBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise you might interest'),
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ListFood(databaseName)));
            },
            child: Center(
              child: new Container(
                height: 96,
                child: new Column(
                  children: <Widget>[Image(image: icon, width: 80.0), text],
                ),
              ),
            )));
  }
}
