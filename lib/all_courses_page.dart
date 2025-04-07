import 'package:flutter/material.dart';

class AllCoursesPage extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> searchResults;
  final String filter;
  final Function search;
  final Function(String) setFilter;

  const AllCoursesPage({
    super.key,
    required this.searchController,
    required this.searchResults,
    required this.filter,
    required this.search,
    required this.setFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tüm Dersler"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Arama ve Filtreleme Alanı
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Arama yap...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    search();
                  },
                ),
              ),
              onChanged: (value) => search(),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: filter,
              onChanged: (String? newFilter) {
                setFilter(newFilter!);
              },
              items:
                  <String>['Ders', 'Eğitmen'].map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            // Arama Sonuçları
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index]),
                    onTap: () {
                      // Arama sonucu seçildiğinde yapılacak işlemler (örn. ders sayfasına yönlendirme)
                    },
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
