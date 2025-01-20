import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp_alhuda/Screens/Quran_HomeScreen/QuranHomeScreen.dart';

import 'AzkarHomeScreen/AzkarHomeScreen.dart';
import 'Hijricalendar/hijricalendarScreen.dart';
import 'SalahHomeScreen/salahHomeScreen.dart';
import 'SettingsScreen/settings.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex =0;
  List Screens =[
    QuranHomeScreen(),
    Azkarhomescreen(),
    SalahHomeScreen(),
    HijriCalendarScreen(),
    SettingsScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Screens[_selectedIndex],
      bottomNavigationBar:  FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.menu_book_rounded),
            title: Text("القرآن".trim()),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.clean_hands_outlined),
            title: Text("الأذكار".trim()),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.emoji_people_outlined),
            title: Text("الصلاة".trim()),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            title: Text("التقويم".trim()),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.settings),
            title: Text("الإعدادات".trim()),
          ),
        ],
      ),

    );
  }
}
