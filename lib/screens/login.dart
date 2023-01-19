import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_empresta_ai/models/LoginData.dart';
import 'package:me_empresta_ai/models/user.dart';
import 'package:me_empresta_ai/repositories/userRepository.dart';
import 'package:me_empresta_ai/screens/userAdd.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

import 'myListBook.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final title = const Text("Login");
  final addUser = UserFormWidget();
  final UserRepository? _repository = UserRepository();

  _insertUser(User user) async {
    if (user != null) {
      await _repository!.insertUser(user);
      await _repository!.getUserByEmail(user.username);
    }
  }

  @override
  Widget build(BuildContext context) {
    final addUser = UserFormWidget();

    return Scaffold(
        appBar: AppBar(
          title: title,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => addUser))
                      .then((book) => _insertUser(book));
                },
                icon: addIcon)
          ],
        ),
        body: const LoginFields());
  }
}

class LoginFields extends StatefulWidget {
  const LoginFields({Key? key}) : super(key: key);

  @override
  LoginFieldsState createState() => LoginFieldsState();
}

class LoginFieldsState extends State<LoginFields> with RestorationMixin {
  final UserRepository? _repository = UserRepository();
  late FocusNode _email, _password, _retypePassword, _lifeStory;
  final addUser = UserFormWidget();

  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();

  @override
  String get restorationId => 'login';

  @override
  void initState() {
    super.initState();

    _email = FocusNode();
    _password = FocusNode();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_autoValidateModeIndex, 'autovalidate_mode');
  }

    _insertUser(User user) async {
    if (user != null) {
      await _repository!.insertUser(user);
      await _repository!.getUserByEmail(user.username);
    }
  }

  final RestorableInt _autoValidateModeIndex =
      RestorableInt(AutovalidateMode.disabled.index);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    const sizedBoxSpaceCadastro = SizedBox(height: 44);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
      child: Scrollbar(
        child: SingleChildScrollView(
          restorationId: 'loginRestorationId',
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sizedBoxSpace,
              TextFormField(
                controller: _tEmail,
                restorationId: 'email_field',
                textInputAction: TextInputAction.next,
                focusNode: _email,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Seu endereço de e-mail",
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              sizedBoxSpace,
              TextFormField(
                controller: _tPassword,
                restorationId: 'password_field',
                textInputAction: TextInputAction.next,
                focusNode: _password,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Digite sua senha",
                  labelText: "Senha",
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              sizedBoxSpace,
              Center(
                  child: SizedBox(
                      height: 50, //height of button
                      width: 400, //width of button
                      child: ElevatedButton(
                          onPressed: _handleSubmitted,
                          child: Text("Entrar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15))))),
              sizedBoxSpaceCadastro,
              Center(
                child: Text("Ou",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              sizedBoxSpace,
              Center(
                  child: SizedBox(
                      height: 50, //height of button
                      width: 400, //width of button
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => addUser))
                                .then((book) => _insertUser(book));
                          },
                          child: Text("Cadastre-se",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)))))
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted() {
    final email = _tEmail.text;
    final password = _tPassword.text;
    if (email.isEmpty || password.isEmpty) {
      _showDialogError("Login e/ou Senha inválido(s)");
    } else {
      _verifyUserCredentials(email, password);
    }
  }

  void _showDialogError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Erro"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]);
      },
    );
  }

  void _verifyUserCredentials(String email, String password) async {
    User? user = await _repository!.getUserByEmail(email);

    if (user == null) {
      _showDialogError("Usuário não encontrado. Verifique o e-mail e tente novamente.");    
      return;  
    }

    if (password != user.password) {
      return _showDialogError("Senha incorreta. Verifique e tente novamente."); 
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => MyBooksWidget(userId: user.id!,)));
  }
}
