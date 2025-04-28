import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  AddCoursePageState createState() => AddCoursePageState();
}

class AddCoursePageState extends State<AddCoursePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  Future<void> _addCourse() async {
    await FirebaseFirestore.instance.collection('courses').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'time': _timeController.text,
      'createdAt': Timestamp.now(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Ders eklendi!')));

    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _timeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ders Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Ders Başlığı'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Tarih (örn. 2025-05-01)',
              ),
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Saat (örn. 14:00)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCourse,
              child: const Text('Ders Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
