import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFFF7F3EE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7B9E87),
        elevation: 0,
        title: const Text(
          'Hey Nadia 🌿',
          style: TextStyle(
            color: Color(0xFF2C2C2C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color.fromARGB(238, 246, 249, 247).withOpacity(0.2),
            child: const Text(
              'NK',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 225, 228, 226),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF7B9E87),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How are you feeling?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('😔', style: TextStyle(fontSize: 28)),
                      Text('😕', style: TextStyle(fontSize: 28)),
                      Text('😐', style: TextStyle(fontSize: 28)),
                      Text('🙂', style: TextStyle(fontSize: 28)),
                      Text('😄', style: TextStyle(fontSize: 28)),
                    ],


                  )
                ],
              ),

            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Your therapist",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black
                ),),
              ],

            
            ),
            SizedBox(height: 20,),
            Card(
              color: Color(0xFF7B9E87),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
        ),
        title: const Text("Dr. Michael Roberts"),
        subtitle: const Text("CBT & Stress Management"),
       
      ),
    ),
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Self help Articles",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        
        ),
        ),
      ],
      
    ),
    SizedBox(height: 20,),



            
              
              
           

          ],





        ),
        
      ),

      


    );
  }
}