import 'package:me_empresta_ai/models/book.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';
import 'package:me_empresta_ai/widgets/input_form.dart';
import 'package:flutter/material.dart';

class BookFormWidget extends StatefulWidget {
  final int userId;

  const BookFormWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _BookFormWidgetState createState() => _BookFormWidgetState();
}

class _BookFormWidgetState extends State<BookFormWidget> {
  final title = const Text("Novo Livro");
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultInputFormWidget(
                      placeholder: "Informe o nome",
                      label: "Nome",
                      controller: _nameController,
                      validationMsg: "Insira o nome do livro"),
                  DefaultInputFormWidget(
                      placeholder: "Informe a descrição",
                      label: "Descrição",
                      controller: _descriptionController,
                      validationMsg: "Insira o descrição do livro"),
                  DefaultInputFormWidget(
                      placeholder: "Informe o autor",
                      label: "Autor",
                      controller: _authorController,
                      validationMsg: "Insira o nome do author"),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final book = Book(
                                _nameController.text,
                                _descriptionController.text,
                                _authorController.text,
                                0,
                                widget.userId,
                                1);
                            Navigator.pop(context, book);
                          }
                        },
                        child: salvarText),
                  )
                ],
              ))),
    );
  }
}
