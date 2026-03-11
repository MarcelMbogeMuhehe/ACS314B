import 'package:firstapp/views/homescreen.dart';
import 'package:firstapp/views/sign_in_screen.dart';
import 'package:firstapp/views/sign_up_screen.dart';
import 'package:firstapp/views/welcome_back_screen.dart';
import 'package:get/get.dart';


var routes = [
GetPage(name:"/" , page:()=> WelcomeBackScreen()),
GetPage(name:"/signup",  page:()=>SignUpScreen()),
GetPage(name:"/homescreen",  page:()=>Homescreen()),
GetPage(name: '/signinscreen', page:()=>SignInScreen())

];
