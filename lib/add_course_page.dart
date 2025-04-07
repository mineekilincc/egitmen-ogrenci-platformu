import 'package:flutter/material.dart';

class AddCoursePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onCourseAdded;
  final Map<String, dynamic>? course;

  const AddCoursePage({super.key, required this.onCourseAdded, this.course});

  @override
  AddCoursePageState createState() => AddCoursePageState();
}

class AddCoursePageState extends State<AddCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _nameController.text = widget.course!['name'];
      _descriptionController.text = widget.course!['description'];
      _timeController.text = widget.course!['time'];
      _dateController.text = widget.course!['date'];
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format: yyyy-mm-dd
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context); // Format: HH:mm
      });
    }
  }

  void _saveCourse() {
    if (_formKey.currentState!.validate()) {
      final course = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'time': _timeController.text,
        'date': _dateController.text,
      };

      widget.onCourseAdded(course);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? "Yeni Ders Ekle" : "Ders Düzenle"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Ders Adı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ders adı boş olamaz!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Ders Açıklaması"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Açıklama boş olamaz!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: "Ders Tarihi"),
                readOnly: true, // Disable manual editing
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tarih boş olamaz!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: "Ders Saati"),
                readOnly: true, // Disable manual editing
                onTap: () => _selectTime(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Saat boş olamaz!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCourse,
                child: Text(
                  widget.course == null ? "Ders Ekle" : "Dersi Güncelle",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
