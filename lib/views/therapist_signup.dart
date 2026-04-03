import 'dart:convert';

import 'package:firstapp/controllers/signupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart' as http;

TextEditingController firstname = TextEditingController();
TextEditingController lastname = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController mobilenumber = TextEditingController();
TextEditingController specialization = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController confirmpassword = TextEditingController();

class TherapistSignup extends StatefulWidget {
  const TherapistSignup({super.key});

  @override
  State<TherapistSignup> createState() => _TherapistSignupState();
}

class _TherapistSignupState extends State<TherapistSignup> {
  // ✅ Only added this
  final Signupcontroller signupController = Get.put(Signupcontroller());

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
                          "Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 40.0),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Weclome!",
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
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
                                        child: TextFormField(
                                          controller: firstname,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "First Name",
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: lastname,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Last Name",
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Email",
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: mobilenumber,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Moblie number",
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: specialization,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Specialization",
                                            prefixIcon: Icon(Icons.book),
                                          ),
                                        ),
                                      ),
                                      // ✅ Only changed password field to use controller
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: Obx(
                                          () => TextFormField(
                                            controller: password,
                                            obscureText: !signupController
                                                .isPasswordVisible
                                                .value,
                                            obscuringCharacter: '*',
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              prefixIcon: Icon(Icons.lock),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  signupController
                                                          .isPasswordVisible
                                                          .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                                onPressed: () =>
                                                    signupController
                                                        .togglePassword(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ✅ Only changed confirm password field to use controller
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        child: Obx(
                                          () => TextFormField(
                                            controller: confirmpassword,
                                            obscureText: !signupController
                                                .isConfirmPasswordVisible
                                                .value,
                                            obscuringCharacter: '*',
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Confirm password",
                                              prefixIcon: Icon(Icons.lock),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  signupController
                                                          .isConfirmPasswordVisible
                                                          .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                                onPressed: () => signupController
                                                    .toggleConfirmPassword(),
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
                             
                              SizedBox(height: 30),
                              GestureDetector(
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 3, 52, 5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  if (firstname.text.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Please enter firstname",
                                    );
                                  } else if (lastname.text.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Please enter last name",
                                    );
                                  } else if (mobilenumber.text.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Please enter mobile number",
                                    );
                                  } else if (password.text.isEmpty ||
                                      confirmpassword.text.isEmpty ||
                                      password.text.toString().compareTo(
                                            confirmpassword.text.toString(),
                                          ) !=
                                          0) {
                                    Get.snackbar(
                                      "Error",
                                      "Password and Paswword Confirm should be none empty and matching ",
                                    );
                                  } else {
                                    final response = await http.get(
                                      Uri.parse(
                                        "http://localhost/therapist2/therapist_create.php?firstname=${firstname.text}&lastname=${lastname.text}&mobilenumber=${mobilenumber.text}&email=${email.text}&password=${password.text}&specialization=${specialization.text}&created_at&id",
                                      ),
                                    );

                                    if (response.statusCode == 200) {
                                      final serverData = jsonDecode(
                                        response.body,
                                      );
                                      if (serverData['status'] == 'success') {
                                        Get.snackbar(
                                          "Success",
                                          "You are registered!",
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                        );
                                        Get.offAndToNamed("/therapistlogin");
                                      }
                                    } else {
                                      Get.snackbar(
                                        "Registration",
                                        "Registration Failed",
                                      );
                                    }
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              TextField(),
                              Text(
                                "Sign up with",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 40),
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
