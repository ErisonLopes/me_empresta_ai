import 'package:floor/floor.dart';

@entity
class Book {
  @primaryKey
  int? id;
  final String name;
  final String description;
  final String author;
  final int loan;
  final int userId;
  int? userLoanId;

  Book(this.name, this.description, this.author, this.loan, this.userId,
      this.userLoanId,
      {this.id});
}
