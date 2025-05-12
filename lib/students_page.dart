import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Map<String, dynamic>> students = [
    {
      'name': 'Ali Yılmaz',
      'email': 'ali@gmail.com',
      'courses': ['Matematik', 'Fizik'],
      'progress': {'Matematik': 85, 'Fizik': 90},
      'evaluation': '',
    },
    {
      'name': 'Ayşe Kaya',
      'email': 'ayse@gmail.com',
      'courses': ['Kimya', 'Biyoloji'],
      'progress': {'Kimya': 80, 'Biyoloji': 95},
      'evaluation': '',
    },
    // Daha fazla öğrenci ekleyebilirsiniz
  ];

  void _updateEvaluation(int index, String evaluation) {
    setState(() {
      students[index]['evaluation'] = evaluation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenciler'),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            child: Padding(
              // ListTile yerine Padding ekledik
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Dersler: ${student['courses'].join(', ')}', // Dersleri virgülle ayırarak göster
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    student['email'], // Email'i ekledik
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Align(
                    alignment: Alignment.centerRight, // Butonu sağa yasladık
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        // Öğrencinin profil sayfasına git
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => StudentProfilePage(
                                  student: student,
                                  index: index,
                                  onEvaluationUpdated: _updateEvaluation,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StudentProfilePage extends StatefulWidget {
  final Map<String, dynamic> student;
  final int index;
  final Function(int, String) onEvaluationUpdated;

  const StudentProfilePage({
    super.key,
    required this.student,
    required this.index,
    required this.onEvaluationUpdated,
  });

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  late TextEditingController _evaluationController;

  @override
  void initState() {
    super.initState();
    _evaluationController = TextEditingController();
    _evaluationController.text = widget.student['evaluation'];
  }

  @override
  void dispose() {
    _evaluationController.dispose();
    super.dispose();
  }

  /*void _saveEvaluation() {
    widget.onEvaluationUpdated(widget.index, _evaluationController.text);
    Navigator.pop(context); // Profili güncelleyip geri dön
  }
*/
  @override
  Widget build(BuildContext context) {
    final student = widget.student;
    final courses = student['courses'];
    //final progress = student['progress'];

    return Scaffold(
      appBar: AppBar(
        title: Text('${student['name']} Profili'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ad: ${student['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('E-posta: ${student['email']}'),
            SizedBox(height: 20),
            Text(
              'Dersler:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...courses.map((course) {
              return ListTile(title: Text(course));
            }).toList(),
            /* SizedBox(height: 20),
            Text(
              'Değerlendirme:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _evaluationController,
              decoration: InputDecoration(
                labelText: 'Değerlendirme Yazınız',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEvaluation,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.deepOrange, // Use backgroundColor instead of primary
              ),
              child: Text('Değerlendirmeyi Kaydet'),
            ),*/
          ],
        ),
      ),
    );
  }
}
