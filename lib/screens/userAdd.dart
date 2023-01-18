import 'package:me_empresta_ai/models/user.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';
import 'package:me_empresta_ai/widgets/input_form.dart';
import 'package:flutter/material.dart';

class UserFormWidget extends StatelessWidget {
  UserFormWidget({Key? key}) : super(key: key);

  final title = const Text("Cadastro");
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                      validationMsg: "Insira seu nome"),
                  DefaultInputFormWidget(
                      placeholder: "Informe o username",
                      label: "Username",
                      controller: _usernameController,
                      validationMsg: "Insira seu username"),
                  DefaultInputFormWidget(
                      placeholder: "Informe o email",
                      label: "Email",
                      controller: _emailController,
                      validationMsg: "Insira seu email"),
                  DefaultInputFormWidget(
                      placeholder: "Informe sua senha",
                      label: "senha",
                      controller: _passwordController,
                      validationMsg: "Insira sua senha"),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final book = User(
                                _nameController.text,
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text);
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
