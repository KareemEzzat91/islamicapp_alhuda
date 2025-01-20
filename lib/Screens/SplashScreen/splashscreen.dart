import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:islamicapp_alhuda/Screens/HomeScreen.dart';
import 'package:lottie/lottie.dart';


class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: Lottie.asset("assets/animation/Animation - 1730465622336.json"),
          ),
          Expanded(
            child: Lottie.asset("assets/animation/أنِر دربك بنور الإيمان (2).json"),
          ),
        ],
      ),
      nextScreen:const Homescreen() ,
      duration: 5000,
      splashIconSize: 850,
      backgroundColor: CupertinoColors.white,
    );
  }
}
