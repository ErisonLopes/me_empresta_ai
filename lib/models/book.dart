import 'package:floor/floor.dart';

@entity
class Book {
  @primaryKey
  int? id;
  final String name;
  final String description;
  final int loan;
  final int userId;
  int? userLoanId;

  Book(this.name, this.description, this.loan, this.userId, this.userLoanId,
      {this.id});
}
