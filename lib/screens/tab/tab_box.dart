import 'package:flutter/material.dart';

import 'get/get_screen.dart';
import 'post/post_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {

  List<Widget> screens = [
    const GetScreen(),
    const PostScreen(),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        ],
      ),
    );
  }
}
