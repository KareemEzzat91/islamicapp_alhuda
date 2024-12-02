import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp_alhuda/to_arabic_convetor.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'Arabicsurahnum.dart';
import 'SurahModel.dart';
import 'kcons.dart';



final ItemScrollController  itemScrollController =ItemScrollController();
final ItemPositionsListener  itemPositionsListener =ItemPositionsListener.create();
bool isclicked =true ;
class Surahbuilder extends StatefulWidget {
  final Surah  surah ;

   Surahbuilder({super.key, required this.surah});

  @override
  State<Surahbuilder> createState() => _SurahbuilderState();
}

class _SurahbuilderState extends State<Surahbuilder> {

  bool view = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     String fullsurah = "";
    for  ( final ayah in widget.surah.ayahs ){
      fullsurah += "${ayah.text}\uFD3E${(ayah.number+1).toString().toArabicNumbers}\uFD3F" ;
    };
    return Scaffold(
      appBar: AppBar(leading:  IconButton(icon:const Icon(Icons.view_array_outlined) ,onPressed: (){view?view=false:view=true;setState(() {
      });},),title: Text(widget.surah.name),),
      body: ScrollablePositionedList.builder(
          itemCount:view?1 :widget.surah.ayahs.length, itemBuilder: (c, i) {
        final ayah = widget.surah.ayahs[i];
      return view? verseBuilder(fullsurah,i+1): BuildAyah(i, ayah);//
      }),

    );
  }

  Column BuildAyah(int i, Ayah ayah) {
    return Column(
          children: [
        i == 0 && widget.surah.number!=9 ? const RetunBasmala():const Text("")
      ,i==0 && widget.surah.number!=9?verseBuilder (ayah.text.replaceRange(0, 38, ""),ayah.numberInSurah):verseBuilder (ayah.text,ayah.numberInSurah)]);
  }// تحت يعض


  jumbToAyah() {
    if (isclicked) {
/*
      itemScrollController.scrollTo(index: , duration: Duration(seconds: 2),curve: Curves.easeInOut);
*/
    }
  }

  Row verseBuilder(String text ,index) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
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
                  ArabicSuraNumber(i:index-1),

                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }


 /*
  SafeArea SingleSuraBuilder(LenghtOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];// عدد الاعيات
      }
    }

    if (!view)
      for (int i = 0; i < LenghtOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }




    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view
            ? ScrollablePositionedList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                    ? const Text('')
                    : const RetunBasmala(),
                Container(
                  color: index % 2 != 0
                      ? const Color.fromARGB(255, 253, 251, 240)
                      : const Color.fromARGB(255, 253, 247, 230),
                  child: PopupMenuButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: verseBuilder(index, previousVerses),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            saveBookMark(widget.sura + 1, index);
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.bookmark_add,
                                color:
                                Color.fromARGB(255, 56, 115, 59),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Bookmark'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {

                          },
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(
                                Icons.share,
                                color:
                                Color.fromARGB(255, 56, 115, 59),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Share'),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            );
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: LenghtOfSura,
        )
            : ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.sura + 1 != 1 && widget.sura + 1 != 9
                          ? const RetunBasmala()
                          : const Text(''),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          fullSura, //mushaf mode
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: mushafFontSize,
                            fontFamily: arabicFont,
                            color: const Color.fromARGB(196, 44, 44, 44),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
*/

}
class RetunBasmala extends StatelessWidget {
  const RetunBasmala({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      Center(
        child: Text(
          'بسم الله الرحمن الرحيم',
          style: TextStyle(fontFamily: 'me_quran', fontSize: 30),
          textDirection: TextDirection.rtl,
        ),
      ),
    ]);
  }
}