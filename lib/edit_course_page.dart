import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditCoursePage extends StatefulWidget {
  const EditCoursePage({super.key});

  @override
  EditCoursePageState createState() => EditCoursePageState(); // Public hale getirdik
}

class EditCoursePageState extends State<EditCoursePage> {
  // Public hale getirdik
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  DateTime? _selectedDate;

  // Date Picker için seçilen tarihi al
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ders Düzenle",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ders Adı
              TextFormField(
                controller: _courseNameController,
                decoration: InputDecoration(labelText: 'Ders Adı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ders adını girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Ders Açıklaması
              TextFormField(
                controller: _courseDescriptionController,
                decoration: InputDecoration(labelText: 'Ders Açıklaması'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ders açıklamasını girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Tarih Seçici
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Tarih seçilmedi'
                        : 'Seçilen Tarih: ${_selectedDate?.toLocal()}',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Güncelle Butonu
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Ders güncelleme işlemi yapılabilir
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ders güncellendi!')),
                    );
                    Navigator.pop(context); // Sayfayı kapat
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange, // Doğru kullanım
                  textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                child: Text('Ders Güncelle'), // 'child' en sona taşındı
              ),
            ],
          ),
        ),
      ),
    );
  }
}
