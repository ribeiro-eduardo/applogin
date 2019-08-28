import 'dart:io';
import '../model/user.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;
  final String tableUser = "user";
  final String columnName = "name";
  final String columnUserName = "username";
  final String columnPassword = "password";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT, flaglogado TEXT)");
    print("Table is created");
  }

  // insert
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    print(user.name);
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print("Imprindo a tabela");
    print(list);
    return res;
  }

  // delete
  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete("User", where: "id = ?", whereArgs: [id]);
  }

  Future<User> selectUser(User user) async {
    print("Select User");
    print(user.username);
    print(user.password);

    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
      columns: [columnName, columnUserName, columnPassword],
      where: "$columnUserName = ? and $columnPassword = ?",
      whereArgs: [user.username, user.password]);
      print(maps);
    if (maps.length > 0) {
      return user;
    } 
    else {
      return null; 
    } 
  }

  Future<List> selectAll() async {
    print("New screen");
    var dbClient = await db;
    // List<Map> list = await dbClient.rawQuery("SELECT * FROM User");
    // List<User> usuarios = new List();
    // for (int i = 0; i < list.length; i++) {
    //   var user = new User (list[i]['name'], list[i]['username'], list[i]['password'], list[i]['flaglogado']);
    //   user.setUserId(list[i]['id']);
    //   usuarios.add(user);
    // }
    // print(usuarios.length);
    // return usuarios;
    var result = await dbClient.query('User', columns: ["id", "name", "username"]);
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    print("query all rows ******************");
    var dbClient = await db;
    return await dbClient.query("User");
  }
}