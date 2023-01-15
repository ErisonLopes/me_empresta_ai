// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookDao? _bookDaoInstance;
  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(_user);
        await database.execute(_book);

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  String get _user => '''
CREATE TABLE IF NOT EXIST user(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_name TEXT NOT NULL, 
  name TEXT NOT NULL,
  email  TEXT NOT NULL);''';

  String get _book => '''
CREATE TABLE IF NOT EXISTS book (
  id INTEGER,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  loan INTEGER,
  user_id INTEGER NOT NULL,
  user_loan_id INTEGER, PRIMARY KEY (id),
  FOREIGN KEY(user_id) REFERENCES User(id), 
  FOREIGN KEY(user_loan_id) REFERENCES User(id));''';

  @override
  BookDao get bookDao {
    return _bookDaoInstance ??= _$BookDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$BookDao extends BookDao {
  _$BookDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookInsertionAdapter = InsertionAdapter(
            database,
            'Book',
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description
                }),
        _bookDeletionAdapter = DeletionAdapter(
            database,
            'Book',
            ['id'],
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Book> _bookInsertionAdapter;

  final DeletionAdapter<Book> _bookDeletionAdapter;

  @override
  Future<List<Book>> getBookByUser(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM book where userId = ?',
        mapper: (Map<String, Object?> row) => Book(
            row['name'] as String,
            row['description'] as String,
            row['loan'] as int,
            row['user_id'] as int,
            row['user_loan_id'] as int?,
            id: row['id'] as int?));
  }

  @override
  Future<List<Book>> getBookAll() async {
    return _queryAdapter.queryList('SELECT * FROM book',
        mapper: (Map<String, Object?> row) => Book(
            row['name'] as String,
            row['description'] as String,
            row['loan'] as int,
            row['user_id'] as int,
            row['user_loan_id'] as int?,
            id: row['id'] as int?));
  }

  @override
  Future<void> insertBook(Book book) async {
    await _bookInsertionAdapter.insert(book, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBook(Book book) async {
    await _bookDeletionAdapter.delete(book);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'username': item.username
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'username': item.username
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<User?> getUserByEmail(String email) async {
    return _queryAdapter.query('SELECT * FROM user where email = ?',
        mapper: (Map<String, Object?> row) => User(row['user_name'] as String,
            row['name'] as String, row['email'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<User?> getUserByUserName(String email) async {
    return _queryAdapter.query('SELECT * FROM user where userName = ?',
        mapper: (Map<String, Object?> row) => User(row['user_name'] as String,
            row['name'] as String, row['email'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(User user) async {
    await _userDeletionAdapter.delete(user);
  }
}
