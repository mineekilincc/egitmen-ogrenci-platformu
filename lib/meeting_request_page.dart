import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingRequestPage extends StatelessWidget {
  const MeetingRequestPage({super.key});

  final List<Map<String, String>> requests = const [
    {
      'studentName': 'Zeynep Kılıç',
      'course': 'Python Programlama',
      'date': '7 Nisan 2025',
      'status': 'Beklemede',
    },
    {
      'studentName': 'Ali Can',
      'course': 'Matematik',
      'date': '5 Nisan 2025',
      'status': 'Onaylandı',
    },
    {
      'studentName': 'Elif Demir',
      'course': 'Fizik',
      'date': '2 Nisan 2025',
      'status': 'Reddedildi',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Onaylandı':
        return Colors.green;
      case 'Reddedildi':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Görüşme Talepleri",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: requests.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                request['studentName'] ?? '',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ders: ${request['course']}",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Tarih: ${request['date']}",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              trailing: Chip(
                label: Text(
                  request['status']!,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                backgroundColor: _statusColor(request['status']!),
              ),
              onTap: () {
                // Detay ekranına yönlendirme yapılabilir
              },
            ),
          );
        },
      ),
    );
  }
}
