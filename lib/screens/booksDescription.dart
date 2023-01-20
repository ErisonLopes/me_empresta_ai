import 'package:flutter/material.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:me_empresta_ai/screens/bookAdd.dart';
import 'package:me_empresta_ai/screens/homeScreen.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

import '../repositories/bookRepository.dart';

class BooksDescriptionWidget extends StatefulWidget {
  final Book book;
  final int userId;

  const BooksDescriptionWidget(
      {Key? key, required this.book, required this.userId})
      : super(key: key);

  @override
  _BooksDescriptionWidgetState createState() => _BooksDescriptionWidgetState();
}

class _BooksDescriptionWidgetState extends State<BooksDescriptionWidget> {
  late BookRepository? _repository = BookRepository();
  Book bookUp = Book("", "", "", 0, 0, 0);

  _getBooksById(int id) async {
    final result = await _repository!.getBooksById(widget.book.id!);

    setState(() {
      bookUp = result;
    });
  }

  _loanBook(Book book) async {
    if (book != null) {
      await _repository!.loanBook(book, 1);
      await _getBooksById(book.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.name)),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 10),
                    Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.black,
                      ),
                    ),
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 10),
                    Text(
                      widget.book.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.blue[800],
                      ),
                    ),
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 10),
                    Text(
                      "Autor",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.black,
                      ),
                    ),
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 10),
                    Text(
                      widget.book.author,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.blue[800],
                      ),
                    ),
                  ])),
          if (widget.userId != widget.book.userId) loanButton(widget.book)
        ]),
      ),
    );
  }

  String loan(int loan) {
    if (loan == 1) {
      return "emprestado";
    }
    return "disponivel";
  }

  loanButton(Book book) {
    if (book.loan == 0) {
      return Center(
          child: SizedBox(
              height: 50, //height of button
              width: 400, //width of button
              child: ElevatedButton(
                  onPressed: () {
                    _loanBook(book);
                  },
                  child: loanText)));
    } else {
      return Center(
          child: SizedBox(
              height: 50, //height of button
              width: 400, //width of button
              child: ElevatedButton(onPressed: null, child: unavailableText)));
    }
  }
}
