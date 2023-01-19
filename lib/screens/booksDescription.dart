import 'package:flutter/material.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:me_empresta_ai/screens/bookAdd.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

import '../repositories/bookRepository.dart';

class BooksDescriptionWidget extends StatefulWidget {
  final Book book;

  const BooksDescriptionWidget({Key? key, required this.book})
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

  _loanBook() async {
    if (widget.book != null) {
      await _repository!.loanBook(widget.book, 1);
      await _getBooksById(widget.book.id!);
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
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 10),
                  Text(
                    widget.book.description,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    widget.book.author,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                  loanButton()
                ],
              ),
            ),
          ]),
        ));
  }

  String loan(int loan) {
    if (loan == 1) {
      return "emprestado";
    }
    return "disponivel";
  }

  loanButton() {
    print(widget.book.name);
    if (widget.book.loan == 0)
      return ElevatedButton(
          onPressed: () {
            _loanBook();
          },
          child: loanText);

          return ElevatedButton( onPressed(), child: "Não Disponivel")
  }
}
