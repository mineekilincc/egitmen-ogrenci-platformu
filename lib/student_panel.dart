import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'all_courses_page.dart';
import 'purchased_courses_page.dart';
import 'student_settings.dart';

class StudentPanel extends StatelessWidget {
  const StudentPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = "Öğrenci"; // İstersen SharedPreferences ile alabilirsin

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Öğrenci Paneli",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📚 Merhaba $userName, Öğrenci Paneline Hoş Geldin",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Aşağıdan işlemlerini seçebilirsin:",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildPanelCard(
                    context,
                    title: "Tüm Dersler",
                    description: "Tüm mevcut dersleri görüntüle.",
                    color: Colors.blueAccent,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AllCoursesPage(
                                  searchController: TextEditingController(),
                                  searchResults: [],
                                  filter: "Ders",
                                  search: () {},
                                  setFilter: (v) {},
                                ),
                          ),
                        ),
                  ),
                  _buildPanelCard(
                    context,
                    title: "Satın Alınan Dersler",
                    description: "Satın aldığın dersleri görüntüle.",
                    color: Colors.green,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PurchasedCoursesPage(),
                          ),
                        ),
                  ),
                  _buildPanelCard(
                    context,
                    title: "Profil Ayarları",
                    description: "Profil bilgilerini düzenle.",
                    color: Colors.deepPurple,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentSettings(),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanelCard(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
