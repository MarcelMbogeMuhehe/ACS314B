import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firstapp/views/booked_therapist_screen.dart';
import 'package:firstapp/controllers/navigation_controller.dart';
import 'package:firstapp/views/profile_screen.dart';
import 'package:firstapp/views/therapist_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Register controller here
    final NavigationController navController = Get.put(NavigationController());

    final List<Widget> views = [
      ProfileScreen(),
      TherapistListScreen(),
      BookedTherapistsScreen(),
    ];

    return Scaffold(
      extendBody: true,
      // ✅ Obx rebuilds when page changes
      body: Obx(() => views[navController.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          index: navController.currentIndex.value,
          backgroundColor: Color.fromARGB(255, 5, 57, 7),
          color: const Color(0xFF7B9E87),
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.person, size: 30),
            Icon(Icons.bookmark, size: 30),
          ],
          onTap: (index) {
            navController.changePage(index);
          },
        ),
      ),
    );
  }
}
