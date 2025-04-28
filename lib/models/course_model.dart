class CourseModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map, String id) {
    return CourseModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    };
  }
}
