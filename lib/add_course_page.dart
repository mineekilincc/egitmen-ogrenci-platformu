import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

class AddCoursePage extends StatefulWidget {
  final Function(Map<String, dynamic>)? onCourseAdded;
  final Map<String, dynamic>? course;

  const AddCoursePage({super.key, this.onCourseAdded, this.course});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _zoomLink = TextEditingController();

  String _type = 'free';
  String _message = '';

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _title.text = widget.course!['title'] ?? '';
      _description.text = widget.course!['description'] ?? '';
      _date.text = widget.course!['date'] ?? '';
      _time.text = widget.course!['time'] ?? '';
      _type = widget.course!['type'] ?? 'free';
      _price.text = widget.course!['price'] ?? '';
      _zoomLink.text = widget.course!['zoomLink'] ?? '';
    }
  }

  void _saveCourse() {
    final course = {
      'title': _title.text,
      'description': _description.text,
      'date': _date.text,
      'time': _time.text,
      'type': _type,
      'price': _type == 'free' ? '0' : _price.text,
      'zoomLink': _zoomLink.text,
    };

    if (widget.onCourseAdded != null) {
      widget.onCourseAdded!(course);
      Navigator.pop(context);
    } else {
      _saveToFirestore(course);
    }
  }

  Future<void> _saveToFirestore(Map<String, dynamic> course) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      course['instructorId'] = user?.uid ?? 'anonymous';
      course['instructorName'] = user?.displayName ?? 'Eğitmen';
      course['createdAt'] = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance.collection('courses').add(course);
      setState(() => _message = '✅ Ders başarıyla eklendi!');
    } catch (e) {
      setState(() => _message = '❌ Hata oluştu: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? "Yeni Ders Ekle" : "Dersi Düzenle"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInput(_title, "Ders Başlığı", TextInputType.text),
                const SizedBox(height: 15),
                _buildInput(
                  _description,
                  "Ders Açıklaması",
                  TextInputType.text,
                  maxLines: 4,
                ),
                const SizedBox(height: 15),
                _buildInput(
                  _date,
                  "Tarih (YYYY-AA-GG)",
                  TextInputType.datetime,
                ),
                const SizedBox(height: 15),
                _buildInput(_time, "Saat (örn. 14:00)", TextInputType.datetime),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: _type,
                  items: const [
                    DropdownMenuItem(value: "free", child: Text("Gönüllü")),
                    DropdownMenuItem(value: "paid", child: Text("Ücretli")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Ders Tipi",
                    border: OutlineInputBorder(),
                  ),
                ),

                if (_type == 'paid') ...[
                  const SizedBox(height: 15),
                  _buildInput(_price, "Ücret (₺)", TextInputType.number),
                ],

                const SizedBox(height: 15),
                _buildInput(
                  _zoomLink,
                  "Zoom Linki (isteğe bağlı)",
                  TextInputType.url,
                ),

                const SizedBox(height: 25),
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
                    widget.course == null ? "Dersi Kaydet" : "Dersi Güncelle",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(
                      color:
                          _message.startsWith('✅') ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label,
    TextInputType type, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      validator:
          (value) =>
              (value == null || value.isEmpty)
                  ? "Bu alan boş bırakılamaz."
                  : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
