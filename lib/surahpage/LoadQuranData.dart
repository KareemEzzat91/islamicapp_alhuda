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

Future<void> loadAdhkarData() async {
  try {
    // Load JSON string from assets
    final String response = await rootBundle.loadString("assets/Fonts/adhkar.json");

    // Decode JSON string to a Map
    final List<dynamic> jsonData = json.decode(response);

    // Convert Map to Adhkar object
  Azkar = (jsonData).map((e) => Adhkar.fromJson(e)).toList();
  } catch (e) {
    print('Error loading Adhkar data: $e');
  }
}


class Adhkar {
  int? id;
  String? category;
  String? audio;
  String? filename;
  List<Array>? array;

  Adhkar({this.id, this.category, this.audio, this.filename, this.array});

  Adhkar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    audio = json['audio'];
    filename = json['filename'];
    if (json['array'] != null) {
      array = (json['array'] as List).map((v) => Array.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['audio'] = audio;
    data['filename'] = filename;
    if (array != null) {
      data['array'] = array!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Array {
  int? id;
  String? text;
  int? count;
  String? audio;
  String? filename;

  Array({this.id, this.text, this.count, this.audio, this.filename});

  Array.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    count = json['count'];
    audio = json['audio'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['count'] = count;
    data['audio'] = audio;
    data['filename'] = filename;
    return data;
  }
}

