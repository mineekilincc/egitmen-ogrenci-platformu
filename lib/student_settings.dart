import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentSettings extends StatelessWidget {
  const StudentSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayarlar",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Profil Bilgilerini Güncelle",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Ad Soyad
            TextField(
              decoration: InputDecoration(
                labelText: 'Ad Soyad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // E-posta
            TextField(
              decoration: InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Şifre Değiştir
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Yeni Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Hakkımda Alanı
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Hakkımda',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                // Bilgileri kaydet (henüz Firestore'a bağlanmadık)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Bilgiler güncellendi (demo)")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                "Güncelle",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
