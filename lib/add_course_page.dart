import 'package:flutter/material.dart';

class AddCoursePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onCourseAdded;
  final Map<String, dynamic>? course;

  const AddCoursePage({super.key, required this.onCourseAdded, this.course});

  @override
  AddCoursePageState createState() => AddCoursePageState();
}

class AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _titleController.text = widget.course!['name'] ?? '';
      _descriptionController.text = widget.course!['description'] ?? '';
      _timeController.text = widget.course!['time'] ?? '';
      _dateController.text = widget.course!['date'] ?? '';
    }
  }

  void _saveCourse() {
    final course = {
      'name': _titleController.text,
      'description': _descriptionController.text,
      'time': _timeController.text,
      'date': _dateController.text,
    };

    widget.onCourseAdded(course);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? "Yeni Ders Ekle" : "Dersi Düzenle"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Ders Başlığı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Tarih (örn. 2025-05-01)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Saat (örn. 14:00)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveCourse,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  widget.course == null ? 'Ders Ekle' : 'Dersi Güncelle',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
