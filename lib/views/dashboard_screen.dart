import 'package:firstapp/models/user_model.dart';
import 'package:flutter/material.dart';

var userdetails = [
  User(
    firstname: "Marcel",
    lastname: "Muhehe",
    email: "marcel@gmail.com",
    mobilenumber: "0792469504",
    image: "user1/pic.jpg",
  ),
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userdetails.length,
      itemBuilder: (context, index) {
        final user = userdetails[index]; // <-- grab current user
        return Row(
          children: [
            Image.asset(user.image), // <-- use user data
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.firstname), // <-- use user data
                Text(user.lastname),
                Text(user.mobilenumber),
                
              ],
            ),
          ],
        );
      },
    );
  }
}
