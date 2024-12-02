import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'Arabicsurahnum.dart';
import 'SurahModel.dart';
import 'kcons.dart';
import 'to_arabic_convetor.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

class SurahBuilder extends StatefulWidget {
  final Surah surah;

  const SurahBuilder({Key? key, required this.surah}) : super(key: key);

  @override
  State<SurahBuilder> createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  bool viewFullSurah = true; // للتحكم في العرض (نص كامل أو الآيات بشكل منفصل)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => jumpToAyah(0)); // الانتقال إلى أول آية عند فتح السورة
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surah.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text.rich(
            TextSpan(
              children: widget.surah.ayahs.map((ayah) {
                return TextSpan(
                  children: [
                    // النص الخاص بالآية
                    TextSpan(
                      text: ayah.text,
                      style: TextStyle(
                        fontSize: arabicFontSize,
                        fontFamily: arabicFont,
                        color: Colors.black,
                      ),
                    ),
                    // رقم الآية داخل رمز
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Text(
                          ayah.numberInSurah.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }


  /// بناء النص الكامل مع إضافة الأرقام بين الآيات
  Widget fullSurahWithNumbersBuilder() {
    List<Widget> fullSurahWidgets = [];
    for (var i = 0; i < widget.surah.ayahs.length; i++) {
      final ayah = widget.surah.ayahs[i];
      fullSurahWidgets.add(
        Text(
          ayah.text,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: arabicFontSize,
            fontFamily: arabicFont,
            color: const Color.fromARGB(196, 0, 0, 0),
          ),
        ),
      );

      // إضافة رقم الآية باستخدام ArabicSuraNumber
      fullSurahWidgets.add(ArabicSuraNumber(i: i));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: fullSurahWidgets,
      ),
    );
  }

  /// بناء واجهة الآيات الفردية
  Widget buildAyahWidget(int index, Ayah ayah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (index == 0 && widget.surah.number != 9) const BasmalaWidget(),
        verseBuilder(
          index == 0 && widget.surah.number != 9
              ? ayah.text.replaceRange(0, 38, "")
              : ayah.text,
          ayah.numberInSurah,
        ),
      ],
    );
  }

  /// أداة بناء النصوص (نص الآية مع الرقم)
  Widget verseBuilder(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Text(
            text,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: arabicFontSize,
              fontFamily: arabicFont,
              color: const Color.fromARGB(196, 0, 0, 0),
            ),
          ),
          ArabicSuraNumber(i: index - 1),
        ],
      ),
    );
  }

  /// الانتقال إلى آية معينة
  void jumpToAyah(int ayahIndex) {
    itemScrollController.scrollTo(
      index: ayahIndex,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}

/// ويدجت خاصة بالبسملة
class BasmalaWidget extends StatelessWidget {
  const BasmalaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          'بسم الله الرحمن الرحيم',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontFamily: 'me_quran', fontSize: 24),
        ),
      ),
    );
  }
}
