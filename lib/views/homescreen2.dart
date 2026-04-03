import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firstapp/views/dashboard_screen.dart';
import 'package:firstapp/views/profile_screen.dart';
import 'package:flutter/material.dart';

class Homescreen2 extends StatefulWidget {
  const Homescreen2({super.key});

  @override
  State<Homescreen2> createState() => _Homescreen2State();
}

class _Homescreen2State extends State<Homescreen2> {
  int _page = 0;

  final List<Widget> _views = [ProfileScreen(), DashboardScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: _views[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 5, 57, 7),

        color: const Color(0xFF7B9E87),

        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
          //Handle button tap
        },
      ),
    );
  }
}
