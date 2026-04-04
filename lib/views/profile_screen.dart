import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firstapp/views/therapist_list_screen.dart';

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

  // ✅ Added these
  String firstname = '';
  Map? bookedTherapist;
  bool isLoadingBooking = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
    fetchBookedTherapist();
  }

  // ✅ Load user firstname from SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstname = prefs.getString('firstname') ?? 'User';
    });
  }

  // ✅ Fetch first booked therapist from DB
  Future<void> fetchBookedTherapist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id') ?? '';

      final response = await http.get(
        Uri.parse(
          "http://localhost/therapist2/booking_read.php?user_id=$userId",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'].isNotEmpty) {
          setState(() {
            bookedTherapist = data['data'][0]; // ✅ Get first booked therapist
            isLoadingBooking = false;
          });
        } else {
          setState(() => isLoadingBooking = false);
        }
      }
    } catch (e) {
      print(e.toString());
      setState(() => isLoadingBooking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7B9E87),
        elevation: 0,
        title: Text(
          // ✅ Shows actual user firstname
          'Hey $firstname',
          style: const TextStyle(
            color: Color(0xFF2C2C2C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color.fromARGB(
                238,
                246,
                249,
                247,
              ).withOpacity(0.2),
              child: Text(
                // ✅ Shows first letter of firstname
                firstname.isNotEmpty ? firstname[0].toUpperCase() : 'U',
                style: const TextStyle(
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
                          onTap: () => setState(() => sadCount++),
                          child: Text('😔', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => confusedCount++),
                          child: Text('😕', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => neutralCount++),
                          child: Text('😐', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => happyCount++),
                          child: Text('🙂', style: TextStyle(fontSize: 28)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => veryHappyCount++),
                          child: Text('😄', style: TextStyle(fontSize: 28)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Your therapist",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ✅ Dynamic booked therapist card
              isLoadingBooking
                  ? const Center(child: CircularProgressIndicator())
                  : bookedTherapist == null
                  ? Card(
                      color: const Color(0xFF7B9E87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color.fromARGB(255, 3, 52, 5),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: const Text("No therapist booked yet"),
                        subtitle: const Text("Go to therapists to book one"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.to(() => TherapistListScreen()),
                      ),
                    )
                  : Card(
                      color: const Color(0xFF7B9E87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color.fromARGB(255, 3, 52, 5),
                          child: Text(
                            bookedTherapist!['therapist_name'].isNotEmpty
                                ? bookedTherapist!['therapist_name'][0]
                                      .toUpperCase()
                                : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(bookedTherapist!['therapist_name']),
                        subtitle: Text(bookedTherapist!['specialization']),
                      ),
                    ),

              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Self help Articles",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 17),
              const Text(
                "Mood Tracker",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Card(
                color: const Color(0xFF7B9E87),
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
