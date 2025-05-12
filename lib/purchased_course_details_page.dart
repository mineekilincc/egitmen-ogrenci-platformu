import 'package:flutter/material.dart';
import 'purchased_course.dart'; // PurchasedCourse modelini import ediyoruz

class PurchasedCourseDetailsPage extends StatelessWidget {
  final PurchasedCourse course;

  // Constructor'ı const olarak işaretledik
  const PurchasedCourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ders Adı: ${course.title}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Eğitmen: ${course.instructor}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Satın Alma Tarihi: ${course.date}",
              style: const TextStyle(fontSize: 16),
            ),
            // Diğer detayları buraya ekleyebilirsiniz
          ],
        ),
      ),
    );
  }
}
