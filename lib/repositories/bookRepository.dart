import 'package:me_empresta_ai/database/db.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:sqflite/sqflite.dart';

class BookRepository {
  late Database db;
  List<Book> books = [];

  BookRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await DB.instance.database;
  }

  getAllBooks() async {
    db = await DB.instance.database;

    List<Map<String, dynamic>> bookMap = await db.query('book', limit: 1);

    books = List.generate(bookMap.length, (index) {
      return Book(
          bookMap[index]['name'],
          bookMap[index]['description'],
          bookMap[index]['author'],
          bookMap[index]['loan'],
          bookMap[index]['userId'],
          bookMap[index]['userLoanId'],
          id: bookMap[index]['id']);
    });

    return books;
  }

  getBooksByUserId(int id) async {
    db = await DB.instance.database;

    List<Map<String, dynamic>> bookMap =
        await db.rawQuery('SELECT * FROM book WHERE userId == $id');

    books = List.generate(bookMap.length, (index) {
      return Book(
          bookMap[index]['name'],
          bookMap[index]['description'],
          bookMap[index]['author'],
          bookMap[index]['loan'],
          bookMap[index]['userId'],
          bookMap[index]['userLoanId'],
          id: bookMap[index]['id']);
    });

    return books;
  }

  setBook(Book book) async {
    db = await DB.instance.database;

    db.insert('book', {
      'name': book.name,
      'description': book.description,
      'author': book.author,
      'loan': book.loan,
      'userId': book.userId,
      'userLoanId': book.userLoanId
    });
  }
}
