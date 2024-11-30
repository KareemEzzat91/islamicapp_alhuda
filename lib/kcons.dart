import 'package:shared_preferences/shared_preferences.dart';

import 'LoadQuranData.dart';
import 'SurahModel.dart';

String arabicFont = "quran";
double arabicFontSize= 24;
double MushafFontSize= 24;

Uri QuranAppUri=Uri.parse( "");
Future saveSettings ()async{
  final prefs= await SharedPreferences.getInstance();
  prefs.setInt("arabicFontSize", arabicFontSize.toInt());
  prefs.setInt('MushafFontSize', MushafFontSize.toInt());

}

Future getSettings ()async{
  try {
    final prefs= await SharedPreferences.getInstance();
    arabicFontSize= await prefs.getInt("arabicFontSize")!.toDouble();
    MushafFontSize= await prefs.getInt("MushafFontSize")!.toDouble();}catch(e){
      arabicFontSize= 24;
      MushafFontSize= 24;
  }

}
List<Map<String, dynamic>> Surahs = [
  {'surah_id': 1, 'surah_name_ar': 'الفاتحة', 'surah_name_en': 'Al-Fatiha', 'type': 'مكية', 'number_of_ayat': 7},
  {'surah_id': 2, 'surah_name_ar': 'البقرة', 'surah_name_en': 'Al-Baqarah', 'type': 'مدنية', 'number_of_ayat': 286},
  {'surah_id': 3, 'surah_name_ar': 'آل عمران', 'surah_name_en': 'Aal-E-Imran', 'type': 'مدنية', 'number_of_ayat': 200},
  {'surah_id': 4, 'surah_name_ar': 'النساء', 'surah_name_en': 'An-Nisa', 'type': 'مدنية', 'number_of_ayat': 176},
  {'surah_id': 5, 'surah_name_ar': 'المائدة', 'surah_name_en': 'Al-Ma’idah', 'type': 'مدنية', 'number_of_ayat': 120},
  {'surah_id': 6, 'surah_name_ar': 'الأنعام', 'surah_name_en': 'Al-An’am', 'type': 'مكية', 'number_of_ayat': 165},
  {'surah_id': 7, 'surah_name_ar': 'الأعراف', 'surah_name_en': 'Al-A’raf', 'type': 'مكية', 'number_of_ayat': 206},
  {'surah_id': 8, 'surah_name_ar': 'الأنفال', 'surah_name_en': 'Al-Anfal', 'type': 'مدنية', 'number_of_ayat': 75},
  {'surah_id': 9, 'surah_name_ar': 'التوبة', 'surah_name_en': 'At-Tawbah', 'type': 'مدنية', 'number_of_ayat': 129},
  {'surah_id': 10, 'surah_name_ar': 'يونس', 'surah_name_en': 'Yunus', 'type': 'مكية', 'number_of_ayat': 109},
  {'surah_id': 11, 'surah_name_ar': 'هود', 'surah_name_en': 'Hud', 'type': 'مكية', 'number_of_ayat': 123},
  {'surah_id': 12, 'surah_name_ar': 'يوسف', 'surah_name_en': 'Yusuf', 'type': 'مكية', 'number_of_ayat': 111},
  {'surah_id': 13, 'surah_name_ar': 'الرعد', 'surah_name_en': 'Ar-Ra’d', 'type': 'مدنية', 'number_of_ayat': 43},
  {'surah_id': 14, 'surah_name_ar': 'إبراهيم', 'surah_name_en': 'Ibrahim', 'type': 'مكية', 'number_of_ayat': 52},
  {'surah_id': 15, 'surah_name_ar': 'الحجر', 'surah_name_en': 'Al-Hijr', 'type': 'مكية', 'number_of_ayat': 99},
  {'surah_id': 16, 'surah_name_ar': 'النحل', 'surah_name_en': 'An-Nahl', 'type': 'مكية', 'number_of_ayat': 128},
  {'surah_id': 17, 'surah_name_ar': 'الإسراء', 'surah_name_en': 'Al-Isra', 'type': 'مكية', 'number_of_ayat': 111},
  {'surah_id': 18, 'surah_name_ar': 'الكهف', 'surah_name_en': 'Al-Kahf', 'type': 'مكية', 'number_of_ayat': 110},
  {'surah_id': 19, 'surah_name_ar': 'مريم', 'surah_name_en': 'Maryam', 'type': 'مكية', 'number_of_ayat': 98},
  {'surah_id': 20, 'surah_name_ar': 'طه', 'surah_name_en': 'Ta-Ha', 'type': 'مكية', 'number_of_ayat': 135},
  {'surah_id': 21, 'surah_name_ar': 'الأنبياء', 'surah_name_en': 'Al-Anbiya', 'type': 'مكية', 'number_of_ayat': 112},
  {'surah_id': 22, 'surah_name_ar': 'الحج', 'surah_name_en': 'Al-Hajj', 'type': 'مدنية', 'number_of_ayat': 78},
  {'surah_id': 23, 'surah_name_ar': 'المؤمنون', 'surah_name_en': 'Al-Mu’minun', 'type': 'مكية', 'number_of_ayat': 118},
  {'surah_id': 24, 'surah_name_ar': 'النور', 'surah_name_en': 'An-Nur', 'type': 'مدنية', 'number_of_ayat': 64},
  {'surah_id': 25, 'surah_name_ar': 'الفرقان', 'surah_name_en': 'Al-Furqan', 'type': 'مكية', 'number_of_ayat': 77},
  {'surah_id': 26, 'surah_name_ar': 'الشعراء', 'surah_name_en': 'Ash-Shu’ara', 'type': 'مكية', 'number_of_ayat': 227},
  {'surah_id': 27, 'surah_name_ar': 'النمل', 'surah_name_en': 'An-Naml', 'type': 'مكية', 'number_of_ayat': 93},
  {'surah_id': 28, 'surah_name_ar': 'القصص', 'surah_name_en': 'Al-Qasas', 'type': 'مكية', 'number_of_ayat': 88},
  {'surah_id': 29, 'surah_name_ar': 'العنكبوت', 'surah_name_en': 'Al-Ankabut', 'type': 'مكية', 'number_of_ayat': 69},
  {'surah_id': 30, 'surah_name_ar': 'الروم', 'surah_name_en': 'Ar-Rum', 'type': 'مكية', 'number_of_ayat': 60},
  {'surah_id': 31, 'surah_name_ar': 'لقمان', 'surah_name_en': 'Luqman', 'type': 'مكية', 'number_of_ayat': 34},
  {'surah_id': 32, 'surah_name_ar': 'السجدة', 'surah_name_en': 'As-Sajda', 'type': 'مكية', 'number_of_ayat': 30},
  {'surah_id': 33, 'surah_name_ar': 'الأحزاب', 'surah_name_en': 'Al-Ahzab', 'type': 'مدنية', 'number_of_ayat': 73},
  {'surah_id': 34, 'surah_name_ar': 'سبإ', 'surah_name_en': 'Saba', 'type': 'مكية', 'number_of_ayat': 54},
  {'surah_id': 35, 'surah_name_ar': 'فاطر', 'surah_name_en': 'Fatir', 'type': 'مكية', 'number_of_ayat': 45},
  {'surah_id': 36, 'surah_name_ar': 'يس', 'surah_name_en': 'Ya-Sin', 'type': 'مكية', 'number_of_ayat': 83},
  {'surah_id': 37, 'surah_name_ar': 'الصافات', 'surah_name_en': 'As-Saffat', 'type': 'مكية', 'number_of_ayat': 182},
  {'surah_id': 38, 'surah_name_ar': 'ص', 'surah_name_en': 'Sad', 'type': 'مكية', 'number_of_ayat': 88},
  {'surah_id': 39, 'surah_name_ar': 'الزمر', 'surah_name_en': 'Az-Zumar', 'type': 'مكية', 'number_of_ayat': 75},
  {'surah_id': 40, 'surah_name_ar': 'غافر', 'surah_name_en': 'Ghafir', 'type': 'مكية', 'number_of_ayat': 85},
  {'surah_id': 41, 'surah_name_ar': 'فصلت', 'surah_name_en': 'Fussilat', 'type': 'مكية', 'number_of_ayat': 54},
  {'surah_id': 42, 'surah_name_ar': 'الشورى', 'surah_name_en': 'Ash-Shura', 'type': 'مكية', 'number_of_ayat': 53},
  {'surah_id': 43, 'surah_name_ar': 'الزخرف', 'surah_name_en': 'Az-Zukhruf', 'type': 'مكية', 'number_of_ayat': 89},
  {'surah_id': 44, 'surah_name_ar': 'الدخان', 'surah_name_en': 'Ad-Dukhan', 'type': 'مكية', 'number_of_ayat': 59},
  {'surah_id': 45, 'surah_name_ar': 'الجاثية', 'surah_name_en': 'Al-Jathiya', 'type': 'مكية', 'number_of_ayat': 37},
  {'surah_id': 46, 'surah_name_ar': 'الأحقاف', 'surah_name_en': 'Al-Ahqaf', 'type': 'مكية', 'number_of_ayat': 35},
  {'surah_id': 47, 'surah_name_ar': 'محمد', 'surah_name_en': 'Muhammad', 'type': 'مدنية', 'number_of_ayat': 38},
  {'surah_id': 48, 'surah_name_ar': 'الفتح', 'surah_name_en': 'Al-Fath', 'type': 'مدنية', 'number_of_ayat': 29},
  {'surah_id': 49, 'surah_name_ar': 'الحجرات', 'surah_name_en': 'Al-Hujurat', 'type': 'مدنية', 'number_of_ayat': 18},
  {'surah_id': 50, 'surah_name_ar': 'ق', 'surah_name_en': 'Qaf', 'type': 'مكية', 'number_of_ayat': 45},
  {'surah_id': 51, 'surah_name_ar': 'الذاريات', 'surah_name_en': 'Adh-Dhariyat', 'type': 'مكية', 'number_of_ayat': 60},
  {'surah_id': 52, 'surah_name_ar': 'الطور', 'surah_name_en': 'At-Tur', 'type': 'مكية', 'number_of_ayat': 49},
  {'surah_id': 53, 'surah_name_ar': 'النجم', 'surah_name_en': 'An-Najm', 'type': 'مكية', 'number_of_ayat': 62},
  {'surah_id': 54, 'surah_name_ar': 'القمر', 'surah_name_en': 'Al-Qamar', 'type': 'مكية', 'number_of_ayat': 55},
  {'surah_id': 55, 'surah_name_ar': 'الرحمن', 'surah_name_en': 'Ar-Rahman', 'type': 'مدنية', 'number_of_ayat': 78},
  {'surah_id': 56, 'surah_name_ar': 'الواقعة', 'surah_name_en': 'Al-Waqia', 'type': 'مكية', 'number_of_ayat': 96},
  {'surah_id': 57, 'surah_name_ar': 'الحديد', 'surah_name_en': 'Al-Hadid', 'type': 'مدنية', 'number_of_ayat': 29},
  {'surah_id': 58, 'surah_name_ar': 'المجادلة', 'surah_name_en': 'Al-Mujadila', 'type': 'مدنية', 'number_of_ayat': 22},
  {'surah_id': 59, 'surah_name_ar': 'الحشر', 'surah_name_en': 'Al-Hashr', 'type': 'مدنية', 'number_of_ayat': 24},
  {'surah_id': 60, 'surah_name_ar': 'الممتحنة', 'surah_name_en': 'Al-Mumtahina', 'type': 'مدنية', 'number_of_ayat': 13},
  {'surah_id': 61, 'surah_name_ar': 'الصف', 'surah_name_en': 'As-Saff', 'type': 'مدنية', 'number_of_ayat': 14},
  {'surah_id': 62, 'surah_name_ar': 'الجمعة', 'surah_name_en': 'Al-Jumua', 'type': 'مدنية', 'number_of_ayat': 11},
  {'surah_id': 63, 'surah_name_ar': 'المنافقون', 'surah_name_en': 'Al-Munafiqoon', 'type': 'مدنية', 'number_of_ayat': 11},
  {'surah_id': 64, 'surah_name_ar': 'التغابن', 'surah_name_en': 'At-Taghabun', 'type': 'مدنية', 'number_of_ayat': 18},
  {'surah_id': 65, 'surah_name_ar': 'الطلاق', 'surah_name_en': 'At-Talaq', 'type': 'مدنية', 'number_of_ayat': 12},
  {'surah_id': 66, 'surah_name_ar': 'التحريم', 'surah_name_en': 'At-Tahrim', 'type': 'مدنية', 'number_of_ayat': 12},
  {'surah_id': 67, 'surah_name_ar': 'الملك', 'surah_name_en': 'Al-Mulk', 'type': 'مكية', 'number_of_ayat': 30},
  {'surah_id': 68, 'surah_name_ar': 'القلم', 'surah_name_en': 'Al-Qalam', 'type': 'مكية', 'number_of_ayat': 52},
  {'surah_id': 69, 'surah_name_ar': 'الحاقة', 'surah_name_en': 'Al-Haaqqa', 'type': 'مكية', 'number_of_ayat': 52},
  {'surah_id': 70, 'surah_name_ar': 'المعارج', 'surah_name_en': 'Al-Maarij', 'type': 'مكية', 'number_of_ayat': 44},
  {'surah_id': 71, 'surah_name_ar': 'نوح', 'surah_name_en': 'Nuh', 'type': 'مكية', 'number_of_ayat': 28},
  {'surah_id': 72, 'surah_name_ar': 'الجن', 'surah_name_en': 'Al-Jinn', 'type': 'مكية', 'number_of_ayat': 28},
  {'surah_id': 73, 'surah_name_ar': 'المزمل', 'surah_name_en': 'Al-Muzzammil', 'type': 'مكية', 'number_of_ayat': 20},
  {'surah_id': 74, 'surah_name_ar': 'المدثر', 'surah_name_en': 'Al-Muddaththir', 'type': 'مكية', 'number_of_ayat': 56},
  {'surah_id': 75, 'surah_name_ar': 'القيامة', 'surah_name_en': 'Al-Qiyama', 'type': 'مكية', 'number_of_ayat': 40},
  {'surah_id': 76, 'surah_name_ar': 'الإنسان', 'surah_name_en': 'Al-Insan', 'type': 'مدنية', 'number_of_ayat': 31},
  {'surah_id': 77, 'surah_name_ar': 'المرسلات', 'surah_name_en': 'Al-Mursalat', 'type': 'مكية', 'number_of_ayat': 50},
  {'surah_id': 78, 'surah_name_ar': 'النبأ', 'surah_name_en': 'An-Naba', 'type': 'مكية', 'number_of_ayat': 40},
  {'surah_id': 79, 'surah_name_ar': 'النازعات', 'surah_name_en': 'An-Nazi’at', 'type': 'مكية', 'number_of_ayat': 46},
  {'surah_id': 80, 'surah_name_ar': 'عبس', 'surah_name_en': 'Abasa', 'type': 'مكية', 'number_of_ayat': 42},
  {'surah_id': 81, 'surah_name_ar': 'التكوير', 'surah_name_en': 'At-Takwir', 'type': 'مكية', 'number_of_ayat': 29},
  {'surah_id': 82, 'surah_name_ar': 'الانفطار', 'surah_name_en': 'Al-Infitar', 'type': 'مكية', 'number_of_ayat': 19},
  {'surah_id': 83, 'surah_name_ar': 'المطففين', 'surah_name_en': 'Al-Mutaffifin', 'type': 'مكية', 'number_of_ayat': 36},
  {'surah_id': 84, 'surah_name_ar': 'الانشقاق', 'surah_name_en': 'Al-Inshiqaq', 'type': 'مكية', 'number_of_ayat': 25},
  {'surah_id': 85, 'surah_name_ar': 'البروج', 'surah_name_en': 'Al-Burooj', 'type': 'مكية', 'number_of_ayat': 22},
  {'surah_id': 86, 'surah_name_ar': 'الطارق', 'surah_name_en': 'At-Tariq', 'type': 'مكية', 'number_of_ayat': 17},
  {'surah_id': 87, 'surah_name_ar': 'الأعلى', 'surah_name_en': 'Al-Ala', 'type': 'مكية', 'number_of_ayat': 19},
  {'surah_id': 88, 'surah_name_ar': 'الغاشية', 'surah_name_en': 'Al-Ghashiya', 'type': 'مكية', 'number_of_ayat': 26},
  {'surah_id': 89, 'surah_name_ar': 'الفجر', 'surah_name_en': 'Al-Fajr', 'type': 'مكية', 'number_of_ayat': 30},
  {'surah_id': 90, 'surah_name_ar': 'البلد', 'surah_name_en': 'Al-Balad', 'type': 'مكية', 'number_of_ayat': 20},
  {'surah_id': 91, 'surah_name_ar': 'الشمس', 'surah_name_en': 'Ash-Shams', 'type': 'مكية', 'number_of_ayat': 15},
  {'surah_id': 92, 'surah_name_ar': 'الليل', 'surah_name_en': 'Al-Lail', 'type': 'مكية', 'number_of_ayat': 21},
  {'surah_id': 93, 'surah_name_ar': 'الضحى', 'surah_name_en': 'Ad-Duha', 'type': 'مكية', 'number_of_ayat': 11},
  {'surah_id': 94, 'surah_name_ar': 'الشرح', 'surah_name_en': 'Ash-Sharh', 'type': 'مكية', 'number_of_ayat': 8},
  {'surah_id': 95, 'surah_name_ar': 'التين', 'surah_name_en': 'At-Tin', 'type': 'مكية', 'number_of_ayat': 8},
  {'surah_id': 96, 'surah_name_ar': 'العلق', 'surah_name_en': 'Al-Alaq', 'type': 'مكية', 'number_of_ayat': 19},
  {'surah_id': 97, 'surah_name_ar': 'القدر', 'surah_name_en': 'Al-Qadr', 'type': 'مكية', 'number_of_ayat': 5},
  {'surah_id': 98, 'surah_name_ar': 'البينة', 'surah_name_en': 'Al-Bayyina', 'type': 'مدنية', 'number_of_ayat': 8},
  {'surah_id': 99, 'surah_name_ar': 'الزلزلة', 'surah_name_en': 'Az-Zalzala', 'type': 'مدنية', 'number_of_ayat': 8},
  {'surah_id': 100, 'surah_name_ar': 'العاديات', 'surah_name_en': 'Al-Adiyat', 'type': 'مكية', 'number_of_ayat': 11},
  {'surah_id': 101, 'surah_name_ar': 'القارعة', 'surah_name_en': 'Al-Qaria', 'type': 'مكية', 'number_of_ayat': 11},
  {'surah_id': 102, 'surah_name_ar': 'التكاثر', 'surah_name_en': 'At-Takathur', 'type': 'مكية', 'number_of_ayat': 8},
  {'surah_id': 103, 'surah_name_ar': 'العصر', 'surah_name_en': 'Al-Asr', 'type': 'مكية', 'number_of_ayat': 3},
  {'surah_id': 104, 'surah_name_ar': 'الهمزة', 'surah_name_en': 'Al-Humaza', 'type': 'مكية', 'number_of_ayat': 9},
  {'surah_id': 105, 'surah_name_ar': 'الفيل', 'surah_name_en': 'Al-Fil', 'type': 'مكية', 'number_of_ayat': 5},
  {'surah_id': 106, 'surah_name_ar': 'قريش', 'surah_name_en': 'Quraysh', 'type': 'مكية', 'number_of_ayat': 4},
  {'surah_id': 107, 'surah_name_ar': 'الماعون', 'surah_name_en': 'Al-Ma’un', 'type': 'مكية', 'number_of_ayat': 7},
  {'surah_id': 108, 'surah_name_ar': 'الكوثر', 'surah_name_en': 'Al-Kawthar', 'type': 'مكية', 'number_of_ayat': 3},
  {'surah_id': 109, 'surah_name_ar': 'الكافرون', 'surah_name_en': 'Al-Kafirun', 'type': 'مكية', 'number_of_ayat': 6},
  {'surah_id': 110, 'surah_name_ar': 'النصر', 'surah_name_en': 'An-Nasr', 'type': 'مدنية', 'number_of_ayat': 3},
  {'surah_id': 111, 'surah_name_ar': 'المسد', 'surah_name_en': 'Al-Masad', 'type': 'مكية', 'number_of_ayat': 5},
  {'surah_id': 112, 'surah_name_ar': 'الإخلاص', 'surah_name_en': 'Al-Ikhlas', 'type': 'مكية', 'number_of_ayat': 4},
  {'surah_id': 113, 'surah_name_ar': 'الفلق', 'surah_name_en': 'Al-Falaq', 'type': 'مكية', 'number_of_ayat': 5},
  {'surah_id': 114, 'surah_name_ar': 'الناس', 'surah_name_en': 'An-Nas', 'type': 'مكية', 'number_of_ayat': 6},];
List<dynamic> quran=[];
List <Surah> Sur=[];

