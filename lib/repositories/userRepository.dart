import 'package:me_empresta_ai/database/db.dart';
import 'package:me_empresta_ai/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  late Database db;
  List<User> users = [];

  UserRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  getUserByEmail(String userEmailOrUserName) async {
    db = await DB.instance.database;

    List<Map<String, dynamic>> userMap = await db.query('user',
        where: "email =? or username = ?",
        whereArgs: [userEmailOrUserName, userEmailOrUserName],
        limit: 1);

    users = List.generate(userMap.length, (index) {
      return User(userMap[index]["username"], userMap[index]["name"],
          userMap[index]["email"], userMap[index]["password"],
          id: userMap[index]["id"]);
    });

    if (users.isEmpty) {
      return null;
    }

    return users.first;
  }

  getUserById(int id) async {
    db = await DB.instance.database;

    List<Map<String, dynamic>> userMap =
        await db.query('user', where: "id = ?", whereArgs: [id], limit: 1);

    users = List.generate(userMap.length, (index) {
      return User(userMap[index]["username"], userMap[index]["name"],
          userMap[index]["email"], userMap[index]["password"],
          id: userMap[index]["id"]);
    });
    return users.first;
  }

  getUsers() async {
    db = await DB.instance.database;

    List<Map<String, dynamic>> userMap = await db.query('user');

    users = List.generate(userMap.length, (index) {
      return User(userMap[index]["username"], userMap[index]["name"],
          userMap[index]["email"], userMap[index]["password"],
          id: userMap[index]["id"]);
    });
    return users;
  }

  insertUser(User user) async {
    db = await DB.instance.database;

    db.insert('user', {
      'username': user.username,
      'name': user.name,
      'email': user.email,
      'password': user.password
    });
  }

  updateUser(User user) async {
    db = await DB.instance.database;

    db.update('user', {
      'username': user.username,
      'name': user.name,
      'email': user.email,
      'password': user.password
    });
  }

  deleteUser(User user) async {
    db = await DB.instance.database;
    db.delete('user', where: "id = ?", whereArgs: [user.id]);
  }
}
