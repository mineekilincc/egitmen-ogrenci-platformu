// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Diğer sayfaları import et
import 'all_courses_page.dart';
import 'purchased_courses_page.dart';
//import 'meeting_request_page.dart';
import 'student_settings.dart';

class StudentPanel extends StatefulWidget {
  const StudentPanel({super.key});

  @override
  _StudentPanelState createState() => _StudentPanelState();
}

class _StudentPanelState extends State<StudentPanel> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "Ders"; // Başlangıçta filtreleme "Ders" olarak ayarlandı
  List<String> _searchResults = []; // Arama sonuçları burada tutulacak
  final List<String> _courses = [
    'Math',
    'Physics',
    'Chemistry',
    'Biology',
  ]; // Örnek kurs listesi
  final List<String> _trainers = [
    'John',
    'Alice',
    'Bob',
  ]; // Örnek eğitmen listesi

  void _search() {
    String query = _searchController.text.toLowerCase();
    List<String> results = [];

    if (_filter == "Ders") {
      results =
          _courses
              .where((course) => course.toLowerCase().contains(query))
              .toList();
    } else {
      results =
          _trainers
              .where((trainer) => trainer.toLowerCase().contains(query))
              .toList();
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Öğrenci Paneli",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ÖĞRENCİ PANELİ",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(139, 69, 19, 0.7),
              ),
            ),
            const SizedBox(height: 20),

            // Panel Kartları
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Tüm Dersler Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Tüm Dersler sayfasına yönlendir
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AllCoursesPage(
                                  searchController: _searchController,
                                  searchResults: _searchResults,
                                  filter: _filter,
                                  search: _search,
                                  setFilter: (String newFilter) {
                                    setState(() {
                                      _filter = newFilter;
                                      _search();
                                    });
                                  },
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Tüm Dersler",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Satın Alınan Dersler Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Satın Alınan Dersler sayfasına yönlendir
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PurchasedCoursesPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Satın Alınan Dersler",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Görüşme Talepleri Butonu
                  /*SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Görüşme Talepleri sayfasına yönlendir
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeetingRequestPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Görüşme Talepleri",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),*/

                  // Profil Ayarları Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Profil Ayarları sayfasına yönlendir
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentSettings(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Profil Ayarları",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
}
