import 'dart:convert';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdhanTest extends StatefulWidget {
 const AdhanTest({super.key});

 @override
 State<AdhanTest> createState() => _AdhanTestState();
}

class _AdhanTestState extends State<AdhanTest> {
 final location = Location();
 String? locationError;
 PrayerTimes? prayerTimes;

 List<String> prayTimes = [];

 @override
 void initState() {
  super.initState();
  fetchPrayerTimes();
 }

 /// Fetch prayer times based on the user's location or SharedPreferences.
 Future<void> fetchPrayerTimes() async {
  final shard = await SharedPreferences.getInstance();
  List<String>? savedPrayers = shard.getStringList("Adhan");

  if (savedPrayers != null && savedPrayers.isNotEmpty) {
   // Use saved prayer times from SharedPreferences
   setState(() {
    prayTimes = savedPrayers;
   });
  } else {
   // If no saved times, fetch prayer times from location
   final locationData = await getLocationData();
   if (!mounted) return;

   if (locationData != null) {
    final coordinates = Coordinates(locationData.latitude!, locationData.longitude!);
    final calculationParameters = CalculationMethod.egyptian.getParameters();
    calculationParameters.madhab = Madhab.hanafi;
    final today = DateComponents.from(DateTime.now());

    setState(() async {
     prayerTimes = PrayerTimes(coordinates, today, calculationParameters);

     // Save prayer times to SharedPreferences for future use
     await shard.setStringList("Adhan", [
      prayerTimes!.fajr.toString(),
      prayerTimes!.sunrise.toString(),
      prayerTimes!.dhuhr.toString(),
      prayerTimes!.asr.toString(),
      prayerTimes!.maghrib.toString(),
      prayerTimes!.isha.toString(),
     ]);
     prayTimes = [
      prayerTimes!.fajr.toString(),
      prayerTimes!.sunrise.toString(),
      prayerTimes!.dhuhr.toString(),
      prayerTimes!.asr.toString(),
      prayerTimes!.maghrib.toString(),
      prayerTimes!.isha.toString(),
     ];
    });

    // TODO: Schedule Notifications Here
    // schedulePrayerNotifications(prayerTimes);
   } else {
    setState(() {
     locationError = "Couldn't Get Your Location!";
    });
   }
  }
 }

 /// Get the user's location with error handling for permissions and services.
 Future<LocationData?> getLocationData() async {
  // Check if location services are enabled
  if (!(await location.serviceEnabled())) {
   if (!(await location.requestService())) {
    setState(() {
     locationError = "Location service is disabled. Please enable it.";
    });
    return null;
   }
  }

  // Check for location permissions
  final permissionStatus = await location.hasPermission();
  if (permissionStatus == PermissionStatus.denied) {
   if (await location.requestPermission() != PermissionStatus.granted) {
    setState(() {
     locationError = "Location permission denied. Please allow access.";
    });
    return null;
   }
  }

  try {
   return await location.getLocation();
  } catch (e) {
   setState(() {
    locationError = "Failed to get location: $e";
   });
   return null;
  }
 }

 String formatTime(DateTime dateTime) {
  final formatter = DateFormat.jm(); // صيغة نظام 12 ساعة (AM/PM)
  return formatter.format(dateTime);
 }

 @override
 Widget build(BuildContext context) {
  return Center(
   child: prayTimes.isEmpty
       ? locationError != null
       ? Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Icon(Icons.error, color: Colors.red),
     SizedBox(height: 10),
     Text(locationError ?? 'Error fetching data'),
    ],
   )
       : Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
     CircularProgressIndicator(),
     SizedBox(height: 10),
     Text('Fetching prayer times...'),
    ],
   )
       : ListView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.all(16),
    itemCount: prayTimes.length,
    itemBuilder: (context, index) {
     final titles = ['Fajr', 'Al Shroq', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
     final icons = [
      Icons.wb_sunny_outlined,
      Icons.sunny_snowing,
      Icons.wb_sunny,
      Icons.cloud,
      Icons.nights_stay,
      Icons.brightness_3,
     ];

     final time = DateTime.tryParse(prayTimes[index]) ?? DateTime.now(); // Fallback if parsing fails

     return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
       leading: Icon(icons[index], color: Theme.of(context).primaryColor),
       title: Text(
        titles[index],
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
       ),
       subtitle: Text(
        formatTime(time), // Display time in 12-hour format
        style: const TextStyle(fontSize: 20, color: Colors.grey),
       ),
      ),
     );
    },
   ),
  );
 }
}
