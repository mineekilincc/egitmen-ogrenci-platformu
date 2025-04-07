import 'package:flutter/material.dart';
import 'add_course_page.dart';

class ManageCourses extends StatefulWidget {
  const ManageCourses({super.key});

  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}

class _ManageCoursesState extends State<ManageCourses> {
  List<Map<String, dynamic>> courses = [];

  // Ders ekleme fonksiyonu
  void _addCourse(Map<String, dynamic> course) {
    setState(() {
      courses.add(course);
    });
  }

  // Ders silme fonksiyonu
  void _deleteCourse(int index) {
    setState(() {
      courses.removeAt(index);
    });
  }

  // Ders düzenleme fonksiyonu
  void _editCourse(int index, Map<String, dynamic> updatedCourse) {
    setState(() {
      courses[index] = updatedCourse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dersleri Yönet"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return ListTile(
            title: Text(course['name']),
            subtitle: Text('${course['description']} - ${course['time']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ders düzenleme butonu
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Ders düzenleme sayfasına yönlendir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AddCoursePage(
                              onCourseAdded: (updatedCourse) {
                                _editCourse(index, updatedCourse);
                                Navigator.pop(context);
                              },
                              course:
                                  course, // Mevcut dersi düzenlemek için gönderiyoruz
                            ),
                      ),
                    );
                  },
                ),
                // Ders silme butonu
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Ders silme işlemi
                    _deleteCourse(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni ders ekleme sayfasına yönlendir
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCoursePage(onCourseAdded: _addCourse),
            ),
          );
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
      ),
    );
  }
}
