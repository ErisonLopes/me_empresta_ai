import 'package:floor/floor.dart';

@entity
class User {
  @primaryKey
  int? id;
  final String username;
  final String name;
  final String email;
  final String password;

  User(this.username, this.name, this.email, this.password, {this.id});
}
