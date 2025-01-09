import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamicapp_alhuda/Screens/HomeScreen/HomeScreencubit/homescreen_cubit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
 import 'Arabicsurahnum.dart';
import 'SurahModel.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

class SurahBuilder extends StatefulWidget {
  final Surah surah;

  const SurahBuilder({Key? key, required this.surah}) : super(key: key);

  @override
  State<SurahBuilder> createState() => _SurahBuilderState();
}
int num=0 ;


class _SurahBuilderState extends State<SurahBuilder> {
  bool playicon=false;
  bool viewFullSurah = false;
 final _audioPlayer = AudioPlayer();
  Future<void> playPrimaryAudio(url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
  Future<void> PlayAllSurah(Surah surah) async {
    for (final ayah in surah.ayahs) {
      try {
        await _audioPlayer.setUrl(surah.ayahs[num].audioSecondary.first);
        _audioPlayer.play();

         await _audioPlayer.playerStateStream.firstWhere((state) => state.processingState == ProcessingState.completed);
        setState(() {
          num++;
        });
        if (!playicon ){
          return;
        }


      } catch (e) {
        print("Error playing audio: $e");
      }
    }
    num=0;
    playicon=false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => jumpToAyah(0)); // الانتقال إلى أول آية عند فتح السورة
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }

          const bool shouldPop = true;
          if (context.mounted && shouldPop) {
            context.read<HomescreenCubit>().change(widget.surah.name, widget.surah.number);
            print(widget.surah.name);
            Navigator.pop(context,widget.surah);
          }
        },
    child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.surah.name,
            style: const TextStyle(
              fontFamily: 'Amiri', // خط أنيق
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              onPressed: () {
                setState(() {
                  viewFullSurah = !viewFullSurah;
                });
              },
            ),
          ],
          leading: IconButton(onPressed: ()async{
            setState(() {
              playicon?playicon=false :playicon=true;
            });
            playicon?  await PlayAllSurah(widget.surah):null ;//else stop

            // playicon =true  Play
            //

          }, icon:playicon?const Icon(Icons.pause):const Icon(Icons.play_circle)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: viewFullSurah
              ? SingleChildScrollView(
                child: Text.rich(
              TextSpan(
                children: widget.surah.ayahs.map((ayah) {

                  return TextSpan(
                    locale: Locale("ar"),
                    children: [
                      // نص الآية
                     ayah.numberInSurah ==1 && widget.surah.number!=9 ?const WidgetSpan(child: BasmalaWidget()):const TextSpan(text: ""),
                      TextSpan(
                        text: ayah.numberInSurah ==1 && widget.surah.number!=9? ayah.text.replaceRange(0, 39, ""):ayah.text,
                        style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'me_quran',
                          color:  num+1 ==ayah.number?Colors.red:
                          Colors.black,
                          height: 2.0,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 5,)),
                      // رقم الآية داخل دائرةs
                       WidgetSpan( alignment: PlaceholderAlignment.bottom,child:ArabicSuraNumber(i:ayah.numberInSurah,)),
                      const WidgetSpan(child: SizedBox(width: 5,)),
                    ],
                  );
                }).toList(),
              ),
              textDirection: TextDirection.rtl,
            ),
          )
              : fullSurahWithNumbersBuilder(),
        ),
      ),
    );
  }

  Widget fullSurahWithNumbersBuilder() {
    return ListView.builder(
      itemCount: widget.surah.ayahs.length,
      itemBuilder: (c, i) {
        final ayah = widget.surah.ayahs[i];
        return buildAyahWidget(i, ayah);
      },
    );
  }

  Widget buildAyahWidget(int index, Ayah ayah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (index == 0 && widget.surah.number != 9) const BasmalaWidget(),
        GestureDetector(
          onDoubleTap: ()async{
           await playPrimaryAudio(ayah.audioSecondary.first);

          },
          child: verseBuilder(
            index == 0 && widget.surah.number != 9
                ? ayah.text.replaceRange(0, 39, "")
                : ayah.text,
            ayah.numberInSurah,
          ),
        ),
      ],
    );
  }

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
            style:  TextStyle(
              fontSize: 22,
              fontFamily: 'me_quran',
              color:  num+1 ==index? Colors.red:Color(0xFF333333),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal.shade100,
            ),
            child: Text(
              index.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'me_quran',
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void jumpToAyah(int ayahIndex) {
    itemScrollController.scrollTo(
      index: ayahIndex,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}

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
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
