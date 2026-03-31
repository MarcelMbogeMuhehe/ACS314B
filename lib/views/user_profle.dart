import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserProfle extends StatefulWidget {
  const UserProfle({super.key});

  @override
  State<UserProfle> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7B9E87),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Container(color: Colors.black.withOpacity(0.4)),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/"),
                            radius: 50,
                            backgroundColor: Colors.white24,
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber.withOpacity(0.5),
                              ),
                              child: Icon(Icons.person_2_sharp),
                            ),
                            title: Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber.withOpacity(0.5),
                              ),
                              child: Icon(Icons.email),
                            ),
                            title: Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber.withOpacity(0.5),
                              ),
                              child: Icon(Icons.phone_iphone_sharp),
                            ),
                            title: Text(
                              "Mobile Number",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber.withOpacity(0.5),
                              ),
                              child: Icon(Icons.phone_iphone_sharp),
                            ),
                            title: Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 3, 52, 5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "log out",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.offNamed("/signinscreen");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
