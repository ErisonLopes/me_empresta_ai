import 'package:flutter/material.dart';
import 'package:me_empresta_ai/screens/allUsers.dart';
import 'package:me_empresta_ai/screens/myListBook.dart';

class HomePage extends StatefulWidget {
  final int userId;
  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int userId;
  int _selectedIndex = 0; //New
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: _selectedIndex);
  }

  onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          MyBooksWidget(userId: widget.userId),
          AllUsersWidget(userId: widget.userId)
        ],
        onPageChanged: onItemTapped,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Meus livros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuário',
          ),
        ],
        onTap: (selectedIndex) {
          pc.animateToPage(
            selectedIndex,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
