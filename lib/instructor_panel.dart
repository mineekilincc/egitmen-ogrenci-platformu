import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Sayfaları import et
import 'manage_courses.dart';
import 'students_page.dart';
//import 'meeting_request_page.dart';
import 'instructor_settings.dart';
//import 'calendar_page.dart';

class InstructorPanel extends StatelessWidget {
  const InstructorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Eğitmen Paneli",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "EĞİTMEN PANELİ",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(139, 69, 19, 0.8),
              ),
            ),
            const SizedBox(height: 30),

            // Panel Butonları
            _buildPanelButton(
              context,
              label: "📚 Dersleri Yönet",
              color: Colors.blueAccent,
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageCourses()),
                  ),
            ),
            _buildPanelButton(
              context,
              label: "👨‍🎓 Öğrencileri Görüntüle",
              color: Colors.green,
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentsPage()),
                  ),
            ),
            /*_buildPanelButton(
              context,
              label: "📅 Takvim / Ders Saatleri",
              color: Colors.deepPurple,
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  ),
            ),*/
            /*_buildPanelButton(
              context,
              label: "📥 Görüşme Talepleri",
              color: Colors.redAccent,
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MeetingRequestPage(),
                    ),
                  ),
            ),*/
            _buildPanelButton(
              context,
              label: "⚙️ Profil Ayarları",
              color: Colors.orange,
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InstructorSettingsPage(),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanelButton(
    BuildContext context, {
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
