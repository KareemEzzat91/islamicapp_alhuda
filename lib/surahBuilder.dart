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
  bool viewFullSurah = false;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              setState(() {
                viewFullSurah ? viewFullSurah=false :viewFullSurah=true;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: viewFullSurah?SingleChildScrollView(
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
                        height: 2.0,
                      ),
                    ),
                    // رقم الآية
                  WidgetSpan(child: ArabicSuraNumber(i: ayah.numberInSurah))
                  ],
                );
              }).toList(),
            ),
            textDirection: TextDirection.rtl,
          ),
        ):
        fullSurahWithNumbersBuilder(),
      ),
    );
  }



  /// بناء النص الكامل مع إضافة الأرقام بين الآيات
  Widget fullSurahWithNumbersBuilder() {
   return ListView.builder(
        itemCount: widget.surah.ayahs.length, itemBuilder: (c, i) {
      final ayah = widget.surah.ayahs[i];
      return  buildAyahWidget(i, ayah);
    });
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
