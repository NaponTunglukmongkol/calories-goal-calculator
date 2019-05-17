import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

final String tableTodo = "log";
final String columnId = "_id";
final String username = 'username';
final String email = 'email';
final String gender = 'gender';
final String dob = 'dob';
final String age = 'age';
final String height = 'height';
final String weight = 'weight';
// final String columnSubject = "subject";
// final String columnDone = "done";

class Todo {
  FirebaseUser user;

  int _id;
  String username;
  String email;
  String gender;
  String dob;
  String age;
  String height;
  String weight;
  // bool done;

  Map<String, dynamic> toMap() {
    // Firestore.instance.collection('users').document('${user.uid}').snapshots();
    Map<String, dynamic> map = {
      username: username,
      email: email,
      gender: gender,
      dob: dob,
      age: age,
      height: height,
      weight: weight,
      // columnSubject: subject,
      // columnDone: done,
    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  Todo();

  Todo.formMap(Map<String, dynamic> map) {
    this._id = map[columnId];
    this.username = map[username];
    this.email = map[email];
    this.gender = map[gender];
    this.dob = map[dob];
    this.age = map[age];
    this.height = map[height];
    this.weight = map[weight];
  }
}

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableTodo (
        $columnId integer primary key autoincrement,
        $username text not null,
        $email text not null,
        $gender text not null,
        $dob text not null,
        $age text not null,
        $height text not null,
        $weight text not null,
      )
      ''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    todo._id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, username, email],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Todo.formMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo._id]);
  }

  Future<List<Todo>> getAllTodos() async {
    var todo = await db.query(tableTodo, where: '$columnId != 0');
    return todo.map((f) => Todo.formMap(f)).toList();
  }

  // Future<List<Todo>> getAllDoneTodos() async {
  //   var todo = await db.query(tableTodo, where: '$columnDone = 1');
  //   return todo.map((f) => Todo.formMap(f)).toList();
  // }

  // Future<void> deleteAllDoneTodo() async {
  //   await db.delete(tableTodo, where: '$columnDone = 1');
  // }

  Future close() async => db.close();
}
