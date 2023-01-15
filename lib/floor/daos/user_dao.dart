import 'package:me_empresta_ai/models/book.dart';
import 'package:floor/floor.dart';
import 'package:me_empresta_ai/models/user.dart';

@dao
abstract class UserDao {
  @Query("SELECT * FROM User where email = ?")
  Future<User?> getUserByEmail(String email);

  @Query("SELECT * FROM User where userName = ?")
  Future<User?> getUserByUserName(String username);

  @insert
  Future<void> insertUser(User user);

  @delete
  Future<void> deleteUser(User user);
}
