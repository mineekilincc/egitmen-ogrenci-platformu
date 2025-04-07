// purchased_course.dart

import 'package:flutter/foundation.dart'; // @immutable'yi kullanabilmek için import

@immutable
class PurchasedCourse {
  final String title;
  final String instructor;
  final String date;

  // Constructor'ı const olarak işaretledik
  const PurchasedCourse({
    required this.title,
    required this.instructor,
    required this.date,
  });
}
