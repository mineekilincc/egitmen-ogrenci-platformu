import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PurchasedCoursesPage extends StatelessWidget {
  const PurchasedCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text("Giriş yapılmamış."));
    }

    final purchasedCoursesRef = FirebaseFirestore.instance
        .collection("purchased_courses")
        .where("userId", isEqualTo: user.uid);

    return Scaffold(
      appBar: AppBar(title: const Text("Satın Alınan Dersler")),
      body: StreamBuilder<QuerySnapshot>(
        stream: purchasedCoursesRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Hata oluştu."));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final purchasedDocs = snapshot.data!.docs;

          if (purchasedDocs.isEmpty) {
            return const Center(
              child: Text("Henüz satın aldığınız bir ders yok."),
            );
          }

          return ListView.builder(
            itemCount: purchasedDocs.length,
            itemBuilder: (context, index) {
              final courseData =
                  purchasedDocs[index].data() as Map<String, dynamic>;
              final courseTitle = courseData["courseTitle"] ?? "Bilinmeyen";

              return ListTile(title: Text(courseTitle));
            },
          );
        },
      ),
    );
  }
}
