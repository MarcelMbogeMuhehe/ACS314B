import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TherapistListScreen extends StatefulWidget {
  const TherapistListScreen({super.key});

  @override
  State<TherapistListScreen> createState() => _TherapistListScreenState();
}

class _TherapistListScreenState extends State<TherapistListScreen> {
  List therapists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTherapists();
  }

  Future<void> fetchTherapists() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/therapist2/therapist_read.php"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            therapists = data['data'];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print(e.toString());
      setState(() => isLoading = false);
    }
  }

  Future<void> bookTherapist(dynamic therapist) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id') ?? '';

      // ✅ Debug prints
      print("User ID from prefs: $userId");
      print("All prefs keys: ${prefs.getKeys()}");

      if (userId.isEmpty) {
        Get.snackbar(
          "Error",
          "Please login first",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final response = await http.get(
        Uri.parse(
          "http://localhost/therapist2/booking_create.php?user_id=$userId&therapist_id=${therapist['id']}&therapist_name=Dr. ${therapist['firstname']} ${therapist['lastname']}&therapist_email=${therapist['email']}&therapist_mobile=${therapist['mobilenumber']}&specialization=${therapist['specialization']}",
        ),
      );

      final serverData = jsonDecode(response.body);

      if (serverData['status'] == 'success') {
        Get.snackbar(
          "Success",
          "Therapist booked successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          serverData['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Booking error: ${e.toString()}");
      Get.snackbar(
        "Error",
        "Could not connect to server",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Our Therapists"),
        backgroundColor: const Color(0xFF7B9E87),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : therapists.isEmpty
          ? const Center(child: Text("No therapists found"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: therapists.length,
              itemBuilder: (context, index) {
                var therapist = therapists[index];
                return _buildTherapistCard(therapist);
              },
            ),
    );
  }

  Widget _buildTherapistCard(dynamic therapist) {
    return Card(
      color: const Color(0xFF7B9E87),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color.fromARGB(255, 3, 52, 5),
                  child: Text(
                    therapist['firstname'][0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${therapist['firstname']} ${therapist['lastname']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        therapist['specialization'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 13,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            therapist['mobilenumber'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 13,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            therapist['email'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => bookTherapist(therapist),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 52, 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Book",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
