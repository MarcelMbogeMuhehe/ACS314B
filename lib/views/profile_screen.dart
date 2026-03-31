import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int sadCount = 0;
  int confusedCount = 0;
  int neutralCount = 0;
  int happyCount = 0;
  int veryHappyCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFFF7F3EE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7B9E87),
        elevation: 0,
        title: const Text(
          'Hey Nadia ',
          style: TextStyle(
            color: Color(0xFF2C2C2C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            child: CircleAvatar(
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
            onTap: () {
               Get.toNamed("/userprofile");
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                      'How are you feeling Today?',
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
                         GestureDetector(
                          onTap: () {
                            setState(() {
                              sadCount++;
                            });
                          },
                          child: Text('😔', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              confusedCount++;
                            });
                          },
                          child: Text('😕', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              neutralCount++;
                            });
                          },
                          child: Text('😐', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              happyCount++;
                            });
                          },
                          child: Text('🙂', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              veryHappyCount++;
                            });
                          },
                          child: Text('😄', style: TextStyle(fontSize: 28)),
                        ),
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
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://www.who.int/news-room/fact-sheets/detail/depression',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B9E87),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.self_improvement_rounded,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Manage Depression',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tools, tips & expert guidance',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://www.who.int/news-room/fact-sheets/detail/anxiety-disorders',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B9E87),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.self_improvement_rounded,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Manage Anxiety',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tools, tips & expert guidance',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 17,),
              Text("Mood Tracker",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,

              ),),

               Card(
                color: Color(0xFF7B9E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    moodColumn('😔', sadCount),
                    moodColumn('😕', confusedCount),
                    moodColumn('😐', neutralCount),
                    moodColumn('🙂', happyCount),
                    moodColumn('😄', veryHappyCount),
                  ],
                               ),
               ),
              
                
              
          
          
          
          
              
                
                
             
          
            ],
          
          
          
          
          
          ),
        ),
        
      ),

      


    );
    
  }
  Widget moodColumn(String emoji, int count) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}