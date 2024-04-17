import 'package:flutter/material.dart';
import 'package:flutter_nt_ten/screens/tab/post/post_screen.dart';
import 'package:flutter_nt_ten/screens/tab/put/put_screen.dart';

import 'del/del_screen.dart';
import 'get/get_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {

  List<Widget> screens = [
    const GetScreen(),
    const PostScreen(),
    const PutScreen(),
    const DelScreen(),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(Icons.density_small),
            label: "Get",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(Icons.add),
            label: "Post",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(Icons.update),
            label: "Put",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(Icons.delete),
            label: "Del",
          )
        ],
      ),
    );
  }
}
