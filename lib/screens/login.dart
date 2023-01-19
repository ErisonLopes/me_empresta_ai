import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:me_empresta_ai/models/LoginData.dart';
import 'package:me_empresta_ai/models/user.dart';
import 'package:me_empresta_ai/repositories/userRepository.dart';
import 'package:me_empresta_ai/screens/userAdd.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

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

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    this.restorationId,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  final String? restorationId;
  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> with RestorationMixin {
  final RestorableBool _obscureText = RestorableBool(true);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_obscureText, 'obscure_text');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      restorationId: 'password_text_field',
      obscureText: _obscureText.value,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
          filled: true,
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText),
    );
  }
}

class LoginFields extends StatefulWidget {
  const LoginFields({Key? key}) : super(key: key);

  @override
  LoginFieldsState createState() => LoginFieldsState();
}

class LoginFieldsState extends State<LoginFields> with RestorationMixin {
  LoginData person = LoginData();
  late FocusNode _email, _password, _retypePassword, _lifeStory;

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

  final RestorableInt _autoValidateModeIndex =
      RestorableInt(AutovalidateMode.disabled.index);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
      child: Scrollbar(
        child: SingleChildScrollView(
          restorationId: 'text_field_demo_scroll_view',
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sizedBoxSpace,
              TextFormField(
                restorationId: 'email_field',
                textInputAction: TextInputAction.next,
                focusNode: _email,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Seu endereço de e-mail",
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  person.email = value;
                  _lifeStory.requestFocus();
                },
              ),
              sizedBoxSpace,
              PasswordField(
                restorationId: 'password_field',
                textInputAction: TextInputAction.next,
                focusNode: _password,
                fieldKey: _passwordFieldKey,
                labelText: "Senha",
                onFieldSubmitted: (value) {
                  setState(() {
                    person.password = value;
                    _retypePassword.requestFocus();
                  });
                },
              ),
              sizedBoxSpace,
              Center(
                child: ElevatedButton(
                  onPressed: _handleSubmitted,
                  child: Text("Logar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted() {
    final form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidateModeIndex.value = AutovalidateMode.always.index;
    } else {
      form.save();
    }
  }
}
