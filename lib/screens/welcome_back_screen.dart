import 'package:firstapp/widget/custom_scaffold.dart';

import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(

        children: [
          Flexible(
            flex: 8,
            child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 0.0
              
            ),
            child: Center(child: RichText(textAlign: TextAlign.center,
            text: const TextSpan(
              children: [

                TextSpan(
                  text: "Welcome back,\n",
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,

                  )


                ),
                TextSpan(
                  text: "Enter your employee details",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white24
                  ),
                  
                ),



              ]
            ),
            )
            ),


          ),
          
          ),
          Flexible(
            flex: 1,
            child: Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Row(
              
            
              children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );


                      },
                      child: const Text("Sign up"),
                    ),
                  ), 
                 

                  const SizedBox(width: 15),

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text("Sign up"),
                    ),
                  ), 


            
              
              ],
            ),
          ),
          
          )




        ],
      ),
      


    );
  }
}
