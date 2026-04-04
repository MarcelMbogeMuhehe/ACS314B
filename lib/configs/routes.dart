import 'package:firstapp/views/homescreen.dart';
import 'package:firstapp/views/homescreen2.dart';
import 'package:firstapp/views/sign_in_screen.dart';
import 'package:firstapp/views/sign_up_screen.dart';
import 'package:firstapp/views/therapist_list_screen.dart';
import 'package:firstapp/views/therapist_login.dart';
import 'package:firstapp/views/therapist_signup.dart';
import 'package:firstapp/views/user_profle.dart';
import 'package:firstapp/views/welcome_back_screen.dart';
import 'package:get/get.dart';


var routes = [
GetPage(name:"/" , page:()=> WelcomeBackScreen()),
GetPage(name:"/signup",  page:()=>SignUpScreen()),
GetPage(name:"/homescreen",  page:()=>Homescreen()),
GetPage(name: "/signinscreen", page:()=>SignInScreen()),
GetPage(name: "/userprofile", page:()=>UserProfle()),
GetPage(name: "/therapistlogin", page: () => TherapistLogin()),
GetPage(name: "/therapistsignup", page: () => TherapistSignup()),
GetPage(name: "/homescreen2", page: () => Homescreen2()),
GetPage(name: "/therapistlist", page: () => TherapistListScreen()),

];
