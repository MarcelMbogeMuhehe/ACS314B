import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TherapistHomescreen extends StatefulWidget {
  const TherapistHomescreen({super.key});

  @override
  State<TherapistHomescreen> createState() => _TherapistHomescreenState();
}

class _TherapistHomescreenState extends State<TherapistHomescreen> {
  List bookings = [];
  bool isLoading = true;
  String therapistName = '';
  String specialization = '';
  String therapistId = '';

  int get totalBookings => bookings.length;
  int get pendingBookings =>
      bookings.where((b) => b['status'] == 'pending').length;
  int get confirmedBookings =>
      bookings.where((b) => b['status'] == 'confirmed').length;
  int get rejectedBookings =>
      bookings.where((b) => b['status'] == 'rejected').length;

  @override
  void initState() {
    super.initState();
    loadTherapistData();
  }

  Future<void> loadTherapistData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      therapistName =
          "${prefs.getString('therapist_firstname') ?? ''} ${prefs.getString('therapist_lastname') ?? ''}";
      specialization = prefs.getString('therapist_specialization') ?? '';
      therapistId = prefs.getString('therapist_id') ?? '';
    });
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://localhost/therapist2/booking_read_therapist.php?therapist_id=$therapistId",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            bookings = data['data'];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print(e.toString());
      setState(() => isLoading = false);
    }
  }

  // ✅ Update booking status
  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://localhost/therapist2/booking_update.php?booking_id=$bookingId&status=$status",
        ),
      );

      final serverData = jsonDecode(response.body);

      if (serverData['status'] == 'success') {
        Get.snackbar(
          status == 'confirmed' ? "✅ Accepted" : "❌ Rejected",
          "Booking has been $status",
          backgroundColor: status == 'confirmed' ? Colors.green : Colors.red,
          colorText: Colors.white,
        );
        // ✅ Refresh bookings list
        fetchBookings();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not update booking",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed("/therapistlogin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7B9E87),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dr. $therapistName",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              specialization,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: logout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchBookings,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Stats row
                    Row(
                      children: [
                        _buildStatCard("Total", totalBookings, Colors.blue),
                        const SizedBox(width: 8),
                        _buildStatCard(
                          "Pending",
                          pendingBookings,
                          Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        _buildStatCard(
                          "Confirmed",
                          confirmedBookings,
                          Colors.green,
                        ),
                        const SizedBox(width: 8),
                        _buildStatCard(
                          "Rejected",
                          rejectedBookings,
                          Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Booking Requests",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // ✅ Bookings list
                    bookings.isEmpty
                        ? const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 40),
                                Icon(Icons.inbox, size: 60, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  "No bookings yet",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              var booking = bookings[index];
                              return _buildBookingCard(booking);
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  // ✅ Stats card widget
  Widget _buildStatCard(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }

  // ✅ Booking card widget
  Widget _buildBookingCard(dynamic booking) {
    Color statusColor;
    IconData statusIcon;

    switch (booking['status']) {
      case 'confirmed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
    }

    return Card(
      color: const Color(0xFF7B9E87),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // ✅ Patient avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color.fromARGB(255, 3, 52, 5),
                  child: Text(
                    booking['firstname'] != null &&
                            booking['firstname'].isNotEmpty
                        ? booking['firstname'][0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${booking['firstname'] ?? ''} ${booking['lastname'] ?? ''}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 12,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            booking['email'] ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 12,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            booking['mobilenumber'] ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ✅ Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusColor),
                  ),
                  child: Row(
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        booking['status'] ?? 'pending',
                        style: TextStyle(fontSize: 11, color: statusColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // ✅ Accept/Reject buttons — only show if pending
            if (booking['status'] == 'pending')
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => updateBookingStatus(
                        booking['id'].toString(),
                        'confirmed',
                      ),
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: const Text(
                        "Accept",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => updateBookingStatus(
                        booking['id'].toString(),
                        'rejected',
                      ),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: const Text(
                        "Reject",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
