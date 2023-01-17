import 'package:me_empresta_ai/models/book.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookDao {
  @Query("SELECT * FROM book where userId = ?")
  Future<List<Book>> getBookByUser(int userId);

  @Query("SELECT * FROM Book")
  Future<List<Book>> getBookAll();

  @insert
  Future<void> insertBook(Book book);

  @delete
  Future<void> deleteBook(Book book);
}
