import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firstapp/views/dashboard_screen.dart';
import 'package:firstapp/views/profile_screen.dart';
import 'package:flutter/material.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
    int _page = 0;

  final List<Widget> _views = [
    DashboardScreen(),
    ProfileScreen(),


   
  ];




  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: _views[_page],
      bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: Colors.blueAccent,
    items: <Widget>[
      Icon(Icons.dashboard, size: 30),
      Icon(Icons.person, size: 30),
    
    ],
    onTap: (index) {
      setState(() {
            _page = index;
          });
      //Handle button tap
    },
  ),
      
    ) ;
  }
}