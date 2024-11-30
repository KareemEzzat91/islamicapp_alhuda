import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'SurahModel.dart';



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

  bool view = true ;

  @override
 void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(widget.surah.name), ),
      body:ListView.builder(itemCount:widget.surah.ayahs.length ,itemBuilder:(c,i){
       final ayah=  widget.surah.ayahs[i];
        return Row(children: [
          Text(ayah.text)
        ],);
      } ) ,

    );
  }

  jumbToAyah() {
    if(isclicked) {
/*
      itemScrollController.scrollTo(index: , duration: Duration(seconds: 2),curve: Curves.easeInOut);
*/
    }
  }
}
