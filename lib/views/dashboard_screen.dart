import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        
        backgroundColor: Color(0xFF7B9E87),
        title: Text("Therapist Profiles"),
        



      ),
      body:
       
      Padding(
        
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                color: Color(0xFF7B9E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                  ),
                  title: const Text("Dr. Michael Roberts"),
                  subtitle: const Text("CBT & Stress Management"),
                ),
              ),
              Card(
                color: Color(0xFF7B9E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                  ),
                  title: const Text("Dr. Michael Roberts"),
                  subtitle: const Text("CBT & Stress Management"),
                ),
              ),
              Card(
                color: Color(0xFF7B9E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                  ),
                  title: const Text("Dr. Michael Roberts"),
                  subtitle: const Text("CBT & Stress Management"),
                ),
              ),
              Card(
                color: Color(0xFF7B9E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                  ),
                  title: const Text("Dr. Michael Roberts"),
                  subtitle: const Text("CBT & Stress Management"),
                ),
              ),
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
                Card(
                color: Color(0xFF7B9E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                  ),
                  title: const Text("Dr. Michael Roberts"),
                  subtitle: const Text("CBT & Stress Management"),
                ),
              ),
          
            ],
          
          
          
          
          
          ),
        ),
      ),

     
      
    );
  }
}
