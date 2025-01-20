import 'package:flutter/material.dart';
import 'Adhan/adhantest.dart';
import 'QiblaScreen/QiblaScreen.dart';

class SalahHomeScreen extends StatelessWidget {
  const SalahHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffE5E5E5), Color(0xff9055FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Header Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "مرحباً بك في قسم الصلاة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  fontFamily: "me_quran",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Prayer Times Section
            buildSection(
              context,
              title: "اوقات الصلاة",
              subtitle: "مواقيت الصلاة القادمة",
              imagePath: "assets/images/Azhan.jpg",
              blendColor: const Color(0xff672CBC),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdhanTest()),
                );
              },
              icon: Icons.access_time,
            ),
            const SizedBox(height: 30),
            // Qibla Direction Section
            buildSection(
              context,
              title: "القبلة",
              imagePath: "assets/images/Alkaba.jpeg",
              blendColor: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Qiblascreen()),
                );
              },
              overlayImage: "assets/images/Qibla-removebg-preview.png",
              icon: Icons.compass_calibration_rounded,
            ),
            const Spacer(),
            // Footer Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "نسأل الله القبول 🕌",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                  fontFamily: "me_quran",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(
      BuildContext context, {
        required String title,
        String? subtitle,
        required String imagePath,
        required Color blendColor,
        required VoidCallback onTap,
        String? overlayImage,
        IconData? icon,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 185,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(blendColor, BlendMode.color),
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            if (overlayImage != null)
              Positioned(
                top: 50,
                left: 10,
                child: Image.asset(
                  overlayImage,
                  scale: 5,
                ),
              ),
            Positioned(
              left: 20,
              top: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: "me_quran",
                        ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
