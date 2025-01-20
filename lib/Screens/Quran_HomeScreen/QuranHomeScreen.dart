import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/l10n.dart';
import '../SalahHomeScreen/Adhan/adhantest.dart';
import 'Hijb/Hijbwidget.dart';
import 'HomeScreencubit/homescreen_cubit.dart';
import 'Parawidget/Parawidget.dart';
import 'Surahwidget/surahwidget.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({super.key});

  @override
  State<QuranHomeScreen> createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen> {
  int index = 0;
  final List<String> surahs = [
    "Al-Fatiha",
    "Al-Baqarah",
    // Add other surah names here
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const surahwidget(),
      const Parawidget(),
      const AdhanTest(),
      const hijbwidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          S.of(context).ALHUDA,
          style: TextStyle(
            color: Color(0xff672CBC),
            fontWeight: FontWeight.bold,
            fontFamily: "me_quran",
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SurahSearchDelegate(surahs: surahs, index: index));
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 185,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffDF98FA),
                      Color(0xff9055FF),
                    ],
                    begin: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 60,
                      right: 0,
                      child: ClipRect(
                        child: Image.asset(
                          "assets/images/Group.png",
                          scale: 0.78,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu_book_outlined,
                                  color: Colors.white,
                                  size: 17,
                                  textDirection: TextDirection.ltr,
                                ),
                                SizedBox(width: 12,),
                                Text(
                                  S.of(context).LastRead,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontFamily: "me_quran",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<HomescreenCubit, HomescreenState>(
                            builder: (context, state) {
                              final bloc = context.read<HomescreenCubit>();
                              return Column(
                                children: [
                                  Text(
                                    bloc.surahname,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      fontFamily: "me_quran",
                                    ),
                                  ),
                                  Text(
                                    "Surah No: ${bloc.Ayahnum}",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18,
                                      fontFamily: "me_quran",
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              CustomSlidingSegmentedControl<int>(
                isStretch: true,
                height: 50,
                fixedWidth: 90,
                initialValue: 1,
                children: {
                  1: Text(
                    S.of(context).Surah,
                    style: TextStyle(
                      color: index == 0 ? Colors.white : Color(0xff8789A3),
                      fontSize: 15,
                      fontFamily: "me_quran",
                    ),
                  ),
                  2: Text(
                    S.of(context).Para,
                    style: TextStyle(
                      color: index == 1 ? Colors.white : Color(0xff8789A3),
                      fontSize: 15,
                      fontFamily: "me_quran",
                    ),
                  ),
                  3: Text(
                    S.of(context).Page,
                    style: TextStyle(
                      color: index == 2 ? Colors.white : Color(0xff8789A3),
                      fontSize: 15,
                      fontFamily: "me_quran",
                    ),
                  ),
                  4: Text(
                    S.of(context).Hijn,
                    style: TextStyle(
                      color: index == 3 ? Colors.white : Color(0xff8789A3),
                      fontSize: 15,
                      fontFamily: "me_quran",
                    ),
                  ),
                },
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Color(0xff994EF8),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInToLinear,
                onValueChanged: (v) {
                  setState(() {
                    index = v - 1;
                  });
                },
              ),
              const Divider(),
              Container(
                child: screens[index] ?? SingleChildScrollView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SurahSearchDelegate extends SearchDelegate<String> {
  final List<String> surahs;
  final int index;

  SurahSearchDelegate({required this.surahs, required this.index});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Selected Surah: $query'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> filteredSurahs;

    switch (index) {
      case 0: // Surah
        filteredSurahs = surahs.where((surah) => surah.toLowerCase().contains(query.toLowerCase())).toList();
        break;
      case 1: // Para
        filteredSurahs = surahs.where((surah) => surah.toLowerCase().contains(query.toLowerCase())).toList(); // Update logic for Para if necessary
        break;
      case 2: // Page
        filteredSurahs = surahs.where((surah) => surah.toLowerCase().contains(query.toLowerCase())).toList(); // Update logic for Page if necessary
        break;
      case 3: // Hijn
        filteredSurahs = surahs.where((surah) => surah.toLowerCase().contains(query.toLowerCase())).toList(); // Update logic for Hijn if necessary
        break;
      default:
        filteredSurahs = [];
    }

    return filteredSurahs.isEmpty
        ? Center(child: Text('No matching surahs found.', style: TextStyle(fontSize: 18, color: Colors.grey.shade600)))
        : ListView.builder(
      itemCount: filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = filteredSurahs[index];
        return ListTile(
          title: Text(surah),
          onTap: () {
            close(context, surah);
          },
        );
      },
    );
  }
}
