import 'package:flutter/material.dart';
import 'purchased_course.dart'; // purchased_course.dart dosyasını import ettik
import 'purchased_course_details_page.dart'; // Detay sayfasını import ettik

class PurchasedCoursesPage extends StatelessWidget {
  const PurchasedCoursesPage({super.key});

  // Satın alınan derslerin örnek verileri burada tutuyoruz
  final List<PurchasedCourse> purchasedCourses = const [
    PurchasedCourse(
      title: 'Flutter ile Mobil Uygulama Geliştirme',
      instructor: 'Ahmet Yılmaz',
      date: '05 Nisan 2025',
    ),
    PurchasedCourse(
      title: 'Yapay Zekâ Temelleri',
      instructor: 'Elif Demir',
      date: '28 Mart 2025',
    ),
    PurchasedCourse(
      title: 'Veri Yapıları ve Algoritmalar',
      instructor: 'Mehmet Kaya',
      date: '22 Mart 2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satın Alınan Dersler"),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
      ),
      body:
          purchasedCourses.isEmpty
              ? const Center(
                child: Text("Henüz satın aldığınız bir ders bulunmamaktadır."),
              )
              : ListView.builder(
                itemCount: purchasedCourses.length,
                itemBuilder: (context, index) {
                  final course = purchasedCourses[index];
                  return ListTile(
                    title: Text(course.title),
                    subtitle: Text("Eğitmen: ${course.instructor}"),
                    onTap: () {
                      // Kullanıcı bir derse tıkladığında, o dersin detaylarına yönlendiriyoruz
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  PurchasedCourseDetailsPage(course: course),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
