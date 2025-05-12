import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Map<String, List<String>> timeSlots = {
    'Pazartesi': ['Sabah', 'Öğle', 'Akşam'],
    'Salı': ['Sabah', 'Öğle', 'Akşam'],
    'Çarşamba': ['Sabah', 'Öğle', 'Akşam'],
    'Perşembe': ['Sabah', 'Öğle', 'Akşam'],
    'Cuma': ['Sabah', 'Öğle', 'Akşam'],
    'Cumartesi': ['Sabah', 'Öğle', 'Akşam'],
    'Pazar': ['Sabah', 'Öğle', 'Akşam'],
  };

  final Set<String> selectedSlots = {};

  void toggleSlot(String day, String time) {
    final slotKey = "$day - $time";
    setState(() {
      if (selectedSlots.contains(slotKey)) {
        selectedSlots.remove(slotKey);
      } else {
        selectedSlots.add(slotKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Takvim / Ders Saatleri",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 214, 255),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Haftalık uygun olduğunuz saatleri seçin:",
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ...timeSlots.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children:
                      entry.value.map((time) {
                        final key = "${entry.key} - $time";
                        final selected = selectedSlots.contains(key);
                        return FilterChip(
                          label: Text(time),
                          selected: selected,
                          onSelected: (_) => toggleSlot(entry.key, time),
                          selectedColor: Colors.deepOrange,
                          labelStyle: GoogleFonts.poppins(
                            color: selected ? Colors.white : Colors.black,
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Seçilen zaman dilimlerini kaydet (ileride Firestore entegrasyonu yapılabilir)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Takvim başarıyla kaydedildi!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              "Kaydet",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
