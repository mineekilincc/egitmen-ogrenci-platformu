import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'manage_courses.dart';
import 'students_page.dart';
import 'instructor_settings.dart';

class InstructorPanel extends StatelessWidget {
  const InstructorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final name = "Eğitmen"; // İstersen shared_preferences ile alabilirsin

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
        centerTitle: true,
        title: Text(
          "Eğitmen Paneli",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Merhaba $name, Eğitmen Paneline Hoş Geldiniz 🎓",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Aşağıdaki seçenekleri kullanarak işlemlerinizi gerçekleştirebilirsiniz:",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildCard(
                    context,
                    title: "📚 Ders Ekle ",
                    subtitle: "Ders oluşturun.",
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageCourses(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: "📚 Ders Düzenle ",
                    subtitle: "Mevcut derslerinizi düzenleyin veya silin.",
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentsPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    title: "📅 Takvim",
                    subtitle: "Ders saatlerinizi düzenleyin.",
                    color: Colors.deepPurple,
                    onTap: () {
                      // Takvim sayfası eklenecekse buraya ekle
                    },
                  ),
                  _buildCard(
                    context,
                    title: "⚙️ Ayarlar",
                    subtitle: "Profil bilgilerinizi güncelleyin.",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InstructorSettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
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
                subtitle,
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
