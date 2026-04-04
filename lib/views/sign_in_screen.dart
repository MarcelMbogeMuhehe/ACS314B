import 'dart:convert';

import 'package:firstapp/controllers/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Added

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            "assets/background4.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40.0),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Welcome back",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                          255,
                                          2,
                                          39,
                                          4,
                                        ),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "Enter Email",
                                            prefixIcon: Icon(Icons.email),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: Obx(
                                          () => TextFormField(
                                            controller: password,
                                            obscureText: !loginController
                                                .isPasswordVisible
                                                .value,
                                            obscuringCharacter: '*',
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "please enter password";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: "Enter password",
                                              prefixIcon: Icon(
                                                Icons.password_outlined,
                                              ),
                                              suffixIcon: GestureDetector(
                                                child: Icon(
                                                  loginController
                                                          .isPasswordVisible
                                                          .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                                onTap: () {
                                                  loginController
                                                      .togglePassword();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      "Dont have an account? Signup",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.toNamed("/signup");
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                onTap: () async {
                                  if (email.text.isEmpty) {
                                    Get.snackbar("Error", "Email is empty");
                                  } else if (password.text.isEmpty) {
                                    Get.snackbar("Error", "Password is empty");
                                  } else {
                                    try {
                                      final response = await http.get(
                                        Uri.parse(
                                          "http://localhost/therapist/login.php?email=${email.text}&password=${password.text}",
                                        ),
                                      );

                                      if (response.statusCode == 200) {
                                        final serverData = jsonDecode(
                                          response.body,
                                        );

                                        print(serverData);
                                        print(serverData['code']);
                                        print(serverData['code'].runtimeType);

                                        if (serverData['code'].toString() ==
                                            '1') {
                                          var user =
                                              serverData["userdetails"][0];

                                          // ✅ Save user details to SharedPreferences
                                          SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                          await prefs.setString(
                                            'id',
                                            user['id'].toString(),
                                          );
                                          await prefs.setString(
                                            'firstname',
                                            user['firstname'].toString(),
                                          );
                                          await prefs.setString(
                                            'lastname',
                                            user['lastname'].toString(),
                                          );
                                          await prefs.setString(
                                            'email',
                                            user['email'].toString(),
                                          );
                                          await prefs.setString(
                                            'mobilenumber',
                                            user['mobilenumber'].toString(),
                                          );
                                          await prefs.setBool(
                                            'isLoggedIn',
                                            true,
                                          );

                                          print(
                                            "Saved user id: ${user['id']}",
                                          ); // ✅ Debug

                                          Get.toNamed("/homescreen");
                                        } else {
                                          Get.snackbar(
                                            "Wrong Credentials",
                                            serverData["message"].toString(),
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                          );
                                        }
                                      } else {
                                        Get.snackbar(
                                          "Server Error",
                                          "Error occurred during Login",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      }
                                    } catch (e) {
                                      print("ERROR: " + e.toString());
                                      Get.snackbar(
                                        "Error",
                                        e.toString(),
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 10),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 3, 52, 5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // ✅ Removed stray empty TextField()
                              SizedBox(height: 40),
                              Text(
                                "Sign up with",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Logo(Logos.facebook_f),
                                  Logo(Logos.twitter),
                                  Logo(Logos.google),
                                  Logo(Logos.apple),
                                ],
                              ),
                            ],
                          ),
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
    );
  }
}
