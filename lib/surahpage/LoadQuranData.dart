import 'dart:convert';
import 'package:flutter/services.dart';

import 'SurahModel.dart';
import '../kconst/kcons.dart';


Future<void> loadQuranData() async {
  try {
    final String response = await rootBundle.loadString('assets/Fonts/ar.alafasy');
    final Map<String, dynamic> data = json.decode(response);

    print("تحميل البيانات...");
    alquran = data['data']["surahs"];

    // تحويل كل عنصر إلى كائن من النوع Surah
    alquran.forEach((surah1) {
      final surah = Surah.fromJson(surah1);
      Sur.add(surah); // إضافة الكائن إلى القائمة النهائية.
      print(surah.ayahs.length);  // طباعة السورة للتأكد.
    });

    print("تم تحميل ${Sur.length} من السور.");
  } catch (e) {
    print("حدث خطأ أثناء تحميل البيانات: $e");
  }
}
