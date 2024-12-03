import 'package:flutter/material.dart';
import 'package:islamicapp_alhuda/surahpage/to_arabic_convetor.dart';


class ArabicSuraNumber extends StatelessWidget {
  const ArabicSuraNumber({Key? key,required this.i}) : super(key: key);
  final int i;
  @override
  Widget build(BuildContext context) {
    return Text("\uFD3F${(i).toString().toArabicNumbers}\uFD3E",textDirection: TextDirection.rtl, style: const TextStyle(
        locale: Locale("ar"),
        color: Color.fromARGB(255, 0, 0, 0),

        fontFamily: 'me_quran',
        fontSize: 20,
        shadows: [
          Shadow(
            offset: Offset(.5, .5),
            blurRadius: 1.0,
            color: Colors.teal,
          ),
        ]),);
  }
}