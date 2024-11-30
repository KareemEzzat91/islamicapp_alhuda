
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamicapp_alhuda/LoadQuranData.dart';

import 'Screens/SplashScreen/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await  loadQuranData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

   return   const MaterialApp(
     home: splashscreen(),
   );
  }
}
