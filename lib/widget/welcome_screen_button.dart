import 'package:flutter/material.dart';

class WelcomeScreenButton extends StatelessWidget {
  const WelcomeScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0)

        ),


      ),
      child: const Text("Press me",
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}