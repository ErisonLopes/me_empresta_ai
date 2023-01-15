import 'dart:async';

import 'package:me_empresta_ai/floor/daos/book_dao.dart';
import 'package:me_empresta_ai/floor/daos/user_dao.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:floor/floor.dart';
import 'package:me_empresta_ai/models/user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Book, User])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
  UserDao get userDao;
}
