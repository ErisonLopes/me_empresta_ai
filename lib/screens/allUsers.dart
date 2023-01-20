import 'package:flutter/material.dart';
import 'package:me_empresta_ai/floor/daos/book_dao.dart';
import 'package:me_empresta_ai/models/book.dart';
import 'package:me_empresta_ai/models/user.dart';
import 'package:me_empresta_ai/repositories/userRepository.dart';
import 'package:me_empresta_ai/screens/bookAdd.dart';
import 'package:me_empresta_ai/screens/booksDescription.dart';
import 'package:me_empresta_ai/screens/homeScreen.dart';
import 'package:me_empresta_ai/screens/myFriendListBook.dart';
import 'package:me_empresta_ai/utils/custom_styles.dart';
import 'package:me_empresta_ai/utils/custom_widgets.dart';

import '../repositories/bookRepository.dart';

class AllUsersWidget extends StatefulWidget {
  final int userId;
  const AllUsersWidget({Key? key, required this.userId}) : super(key: key);

  @override
  State<AllUsersWidget> createState() => _AllUsersWidgetState();
}

class _AllUsersWidgetState extends State<AllUsersWidget> {
  late int userId;

  final title = const Text("Usuários");

  BookDao? bookDao;

  final UserRepository? _repository = UserRepository();
  List<User> users = <User>[];

  @override
  void initState() {
    super.initState();
    _getBooksById(widget.userId);
  }

  _getBooksById(int id) async {
    final result = await _repository!.getUsers(id);

    setState(() {
      users = result;
    });
  }

  mostrarDetalhes(int userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MyFriendBooksWidget(userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => dividerList(),
          itemCount: users.length),
    );
  }

  _buildItem(int index) {
    final user = users[index];
    return Padding(
        padding: cardPadding,
        child: Container(
          decoration: cardBoxDecoration,
          child: ListTile(
              leading: Text(user.id!.toString()),
              title: Text(user.name),
              subtitle: Text(user.email),
              onTap: () {
                mostrarDetalhes(user.id!);
              }),
        ));
  }
}
