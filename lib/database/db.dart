import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'meEmprestaAi.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_user);
    await db.execute(_book);
    await db.insert('user', {
      'id': 1,
      'username': 'erisonson',
      'name': 'Erison Lopes',
      'email': 'erison.lopes.souza@gmail.com.br',
      'password': 'empresta@1234'
    });
    await db.insert('user', {
      'id': 2,
      'username': 'guidorosario',
      'name': 'Guilherme Almeida',
      'email': 'gui.almeida@gmail.com.br',
      'password': 'empresta@1234'
    });
    await db.insert('book', {
      'name': 'É assim que acaba',
      'description': 'Lorem Ipsum',
      'author': 'não sei',
      'loan': 1,
      'userId': 1,
      'userLoanId': 2
    });
    await db.insert('book', {
      'name': 'É assim que acaba vol 2',
      'description': 'Lorem Ipsum',
      'author': 'não sei',
      'loan': 1,
      'userId': 2,
      'userLoanId': 1
    });
  }

  String get _user => '''
  CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    name TEXT,
    email TEXT,
    password TEXT
  );
''';

  String get _book => '''
  CREATE TABLE book (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    author TEXT,
    loan INTEGER,
    userId INTEGER,
    userLoanId INTEGER    
  );
''';
}
