import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllCoursesPage extends StatefulWidget {
  const AllCoursesPage({super.key});

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> filteredCourses = [];
  String filter = 'Tüm Kategoriler';

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('courses').get();
      final List<Map<String, dynamic>> courseList =
          snapshot.docs.map((doc) {
            return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
          }).toList();

      setState(() {
        courses = courseList;
        filteredCourses = courseList;
      });
    } catch (e) {
      // ignore: avoid_print
      print("❌ Veri alınamadı: $e");
    }
  }

  void performSearch() {
    String query = searchController.text.toLowerCase();

    setState(() {
      filteredCourses =
          courses.where((course) {
            final title = course['title']?.toLowerCase() ?? '';
            final instructor = course['instructorName']?.toLowerCase() ?? '';
            final matchesFilter =
                filter == 'Tüm Kategoriler' || course['category'] == filter;

            return (title.contains(query) || instructor.contains(query)) &&
                matchesFilter;
          }).toList();
    });
  }

  void updateFilter(String newFilter) {
    setState(() {
      filter = newFilter;
    });
    performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tüm Dersler"),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Arama alanı
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Arama yap...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: performSearch,
                ),
              ),
              onChanged: (value) => performSearch(),
            ),
            const SizedBox(height: 10),

            // Filtreleme alanı
            DropdownButton<String>(
              value: filter,
              onChanged: (String? newFilter) {
                if (newFilter != null) {
                  updateFilter(newFilter);
                }
              },
              items:
                  <String>[
                    'Tüm Kategoriler',
                    'Yazılım',
                    'Mobil',
                    'Tasarım',
                    'Veri Bilimi',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            // Ders listesi
            Expanded(
              child:
                  filteredCourses.isEmpty
                      ? const Center(child: Text("Hiçbir ders bulunamadı."))
                      : ListView.builder(
                        itemCount: filteredCourses.length,
                        itemBuilder: (context, index) {
                          final course = filteredCourses[index];
                          return Card(
                            child: ListTile(
                              title: Text(course['title'] ?? ''),
                              subtitle: Text(
                                "Kategori: ${course['category'] ?? ''} | Eğitmen: ${course['instructorName'] ?? ''}",
                              ),
                              onTap: () {
                                // Ders detay sayfasına geçiş yapılabilir
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
