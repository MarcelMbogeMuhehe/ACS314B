import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfle extends StatefulWidget {
  const UserProfle({super.key});

  @override
  State<UserProfle> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfle> {
  String firstname = '';
  String lastname = '';
  String email = '';
  String mobilenumber = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstname = prefs.getString('firstname') ?? '';
      lastname = prefs.getString('lastname') ?? '';
      email = prefs.getString('email') ?? '';
      mobilenumber = prefs.getString('mobilenumber') ?? '';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed("/signinscreen");
  }

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
                          // ✅ Avatar with first letter instead of broken asset
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color.fromARGB(
                              255,
                              3,
                              52,
                              5,
                            ),
                            child: Text(
                              // ✅ Null check fixed here
                              firstname.isNotEmpty
                                  ? firstname[0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // ✅ Shows actual full name
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
                              // ✅ Null check fixed here
                              (firstname.isNotEmpty || lastname.isNotEmpty)
                                  ? "$firstname $lastname"
                                  : 'Unknown',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // ✅ Shows actual email
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
                              // ✅ Null check fixed here
                              email.isNotEmpty ? email : 'Unknown',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // ✅ Shows actual mobile number
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
                              // ✅ Null check fixed here
                              mobilenumber.isNotEmpty
                                  ? mobilenumber
                                  : 'Unknown',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // ✅ Logout clears SharedPreferences
                          GestureDetector(
                            onTap: logout,
                            child: Container(
                              height: 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 3, 52, 5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
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
