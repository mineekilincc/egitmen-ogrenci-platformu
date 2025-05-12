import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_course_page.dart';

class ManageCourses extends StatelessWidget {
  const ManageCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dersleri Yönet"),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
      ),
      body:
          userId == null
              ? const Center(child: Text("Giriş yapmadınız."))
              : StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('courses')
                        .where('instructorId', isEqualTo: userId)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('❌ Veri alınırken hata oluştu.'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final courses = snapshot.data!.docs;

                  if (courses.isEmpty) {
                    return const Center(child: Text("Henüz ders eklemediniz."));
                  }

                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      final data = course.data() as Map<String, dynamic>;

                      return ListTile(
                        title: Text(data['title'] ?? 'İsimsiz Ders'),
                        subtitle: Text(
                          '${data['description']} - ${data['date']} ${data['time']}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => AddCoursePage(
                                          course: data,
                                          onCourseAdded: (updatedCourse) async {
                                            await FirebaseFirestore.instance
                                                .collection('courses')
                                                .doc(course.id)
                                                .update(updatedCourse);
                                          },
                                        ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('courses')
                                    .doc(course.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCoursePage()),
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
