import 'package:flutter/material.dart';
import 'package:me_empresta_ai/floor/daos/book_dao.dart';
import 'package:me_empresta_ai/floor/database/app_database.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:me_empresta_ai/screens/add.dart';
import 'package:me_empresta_ai/utils/custom_styles.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

import '../repositories/bookRepository.dart';

class MyBooksWidget extends StatefulWidget {
  const MyBooksWidget({Key? key}) : super(key: key);

  @override
  State<MyBooksWidget> createState() => _MyBooksWidgetState();
}

class _MyBooksWidgetState extends State<MyBooksWidget> {
  final title = const Text("Meus Livros");
  final addPage = BookFormWidget();
  BookDao? bookDao;

  final BookRepository? _repository = BookRepository();
  List<Book> books = <Book>[];

  @override
  void initState() {
    super.initState();
    _getBooksById(1);
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

  _deleteBook(Book book) async {
    if (bookDao != null) {
      await bookDao!.deleteBook(book);
      await _getBooksById(book.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => addPage))
                    .then((book) => _insertBook(book));
              },
              icon: addIcon)
        ],
      ),
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

  _buildItem(int index) {
    final book = books[index];
    return Padding(
        padding: cardPadding,
        child: Container(
            decoration: cardBoxDecoration,
            child: ListTile(
              title: Text(book.name),
              subtitle: ListTile(
                  title: Text(book.description),
                  subtitle: Text(
                    loan(book.loan),
                  ),
                  onLongPress: () {
                    _deleteBook(book);
                  }),
            )));
  }
}
