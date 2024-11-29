
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/SplashScreen/splashscreen.dart';

void main() {
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
