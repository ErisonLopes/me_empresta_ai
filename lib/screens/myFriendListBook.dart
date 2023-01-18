import 'package:flutter/material.dart';
import 'package:me_empresta_ai/floor/daos/book_dao.dart';
import 'package:me_empresta_ai/floor/database/app_database.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:me_empresta_ai/models/user.dart';
import 'package:me_empresta_ai/repositories/userRepository.dart';
import 'package:me_empresta_ai/screens/bookAdd.dart';
import 'package:me_empresta_ai/utils/custom_styles.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

import '../repositories/bookRepository.dart';

class MyFriendBooksWidget extends StatefulWidget {
  const MyFriendBooksWidget({Key? key}) : super(key: key);

  @override
  State<MyFriendBooksWidget> createState() => _MyFriendBooksWidgetState();
}

class _MyFriendBooksWidgetState extends State<MyFriendBooksWidget> {
  final title = const Text("Livros de");
  final addPage = BookFormWidget();
  BookDao? bookDao;

  final BookRepository? _repository = BookRepository();
  final UserRepository? _userRepository = UserRepository();
  List<Book> books = <Book>[];
  User user = User("", "", "", "");

  @override
  void initState() {
    super.initState();
    _getBooksById(1);
    _getUser(1);
  }

  _getBooksById(int id) async {
    final result = await _repository!.getBooksByUserId(id);

    setState(() {
      books = result;
    });
  }

  _insertBook(Book book) async {
    if (book != null) {
      await _repository!.setBook(book);
      await _getBooksById(book.userId);
    }
  }

  _getUser(int id) async {
    final result = await _userRepository!.getUserById(id);
    setState(() {
      user = result;
    });
  }

  _deleteBook(Book book) async {
    if (bookDao != null) {
      await bookDao!.deleteBook(book);
      await _getBooksById(book.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livros de " + user.name.split(' ').first)),
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => dividerList(),
          itemCount: books.length),
    );
  }

  String loan(int loan) {
    if (loan == 1) {
      return "emprestado";
    }
    return "disponivel";
  }

  Text subTitle(Book book) {
    return Text("Descrição: " +
        book.description +
        "  Autor: " +
        book.author +
        "  " +
        loan(book.loan));
  }

  _buildItem(int index) {
    final book = books[index];
    return Padding(
        padding: cardPadding,
        child: Container(
          decoration: cardBoxDecoration,
          child: ListTile(
              title: Text(book.name),
              subtitle: subTitle(book),
              onLongPress: () {
                _deleteBook(book);
              }),
        ));
  }
}
