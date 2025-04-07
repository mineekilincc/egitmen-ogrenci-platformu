import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentManagementPage extends StatelessWidget {
  const StudentManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek öğrenci verileri (Gerçek veri Firestore'dan çekilebilir)
    final List<Map<String, String>> purchasedCourses = [
      {
        "courseName": "Flutter ile Mobil Geliştirme",
        "instructor": "Ahmet Yılmaz",
        "date": "25 Mart 2025",
      },
      {
        "courseName": "Yapay Zeka Temelleri",
        "instructor": "Elif Demir",
        "date": "20 Mart 2025",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Öğrenci Yönetim",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: purchasedCourses.length,
        itemBuilder: (context, index) {
          final course = purchasedCourses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course["courseName"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Eğitmen: ${course["instructor"]}",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    "Tarih: ${course["date"]}",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Ders sayfasına gitme işlemi
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Derse Git",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Eğitmenle iletişim açma işlemi
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          "Eğitmenle İletişim",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
