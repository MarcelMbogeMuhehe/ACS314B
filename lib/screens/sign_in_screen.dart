

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  

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
                        // SizedBox(height: 10.0,),
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
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                          
                                            hintText: "Use Email or Username",
                                            prefixIcon: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                          
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          obscureText: true,
                                          obscuringCharacter: '*',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "please enter password";
                                            }
                                            return null;
                                          },
                          
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter password",
                                            prefixIcon: Icon(
                                              Icons.password_outlined,
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
                                  
                                  
                                  Text(
                                    "Forgot password?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 50.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 3, 52, 5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "login",
                                  style: TextStyle(fontSize: 16.0,
                                  color: Colors.grey),
                                  
                                ),
                                
                              ),
                              SizedBox(height: 20,),
                              TextField(),
                              Text("Sign up with",
                              
                              style: TextStyle(
                                color: Colors.grey
                              ),),
                              SizedBox(height: 40,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Logo(Logos.facebook_f),
                                  Logo(Logos.twitter),
                                  Logo(Logos.google),
                                  Logo(Logos.apple)
                          
                                ],
                              )
                          
                              
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
