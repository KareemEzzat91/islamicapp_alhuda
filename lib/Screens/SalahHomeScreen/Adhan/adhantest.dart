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

 Future<void> fetchPrayerTimes() async {
  final shard = await SharedPreferences.getInstance();
  List<String>? savedPrayers = shard.getStringList("Adhan");

  if (savedPrayers != null && savedPrayers.isNotEmpty) {
   setState(() {
    prayTimes = savedPrayers;
   });
  } else {
   final locationData = await getLocationData();
   if (!mounted) return;

   if (locationData != null) {
    final coordinates = Coordinates(locationData.latitude!, locationData.longitude!);
    final calculationParameters = CalculationMethod.egyptian.getParameters();
    calculationParameters.madhab = Madhab.hanafi;
    final today = DateComponents.from(DateTime.now());

    setState(() async {
     prayerTimes = PrayerTimes(coordinates, today, calculationParameters);

     await shard.setStringList("Adhan", [
      prayerTimes!.fajr.toIso8601String(),
      prayerTimes!.sunrise.toIso8601String(),
      prayerTimes!.dhuhr.toIso8601String(),
      prayerTimes!.asr.toIso8601String(),
      prayerTimes!.maghrib.toIso8601String(),
      prayerTimes!.isha.toIso8601String(),
     ]);
     prayTimes = [
      prayerTimes!.fajr.toIso8601String(),
      prayerTimes!.sunrise.toIso8601String(),
      prayerTimes!.dhuhr.toIso8601String(),
      prayerTimes!.asr.toIso8601String(),
      prayerTimes!.maghrib.toIso8601String(),
      prayerTimes!.isha.toIso8601String(),
     ];
    });
   } else {
    setState(() {
     locationError = "Couldn't Get Your Location!";
    });
   }
  }
 }

 Future<LocationData?> getLocationData() async {
  if (!(await location.serviceEnabled())) {
   if (!(await location.requestService())) {
    setState(() {
     locationError = "Location service is disabled. Please enable it.";
    });
    return null;
   }
  }

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

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: Text('Prayer Times'),
    backgroundColor: Color(0xff672CBC),
   ),
   body: Center(
    child: prayTimes.isEmpty
        ? locationError != null
        ? ErrorScreen(message: locationError!)
        : LoadingScreen()
        : PrayerTimesList(prayTimes: prayTimes),
   ),
  );
 }
}

class ErrorScreen extends StatelessWidget {
 final String message;
 const ErrorScreen({required this.message});

 @override
 Widget build(BuildContext context) {
  return Column(
   mainAxisAlignment: MainAxisAlignment.center,
   children: [
    Icon(Icons.error, color: Colors.red, size: 60),
    SizedBox(height: 10),
    Text(message, style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
   ],
  );
 }
}

class LoadingScreen extends StatelessWidget {
 const LoadingScreen();

 @override
 Widget build(BuildContext context) {
  return Column(
   mainAxisAlignment: MainAxisAlignment.center,
   children: const [
    CircularProgressIndicator(),
    SizedBox(height: 10),
    Text('Fetching prayer times...', style: TextStyle(fontSize: 18, color: Colors.grey)),
   ],
  );
 }
}

class PrayerTimesList extends StatelessWidget {
 final List<String> prayTimes;
 const PrayerTimesList({required this.prayTimes});

 String formatTime(DateTime time) {
  final formatter = DateFormat.jm(); // 12-hour format (AM/PM)
  return formatter.format(time);
 }

 @override
 Widget build(BuildContext context) {
  final titles = ['Fajr', 'Al Shroq', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  final icons = [
   Icons.wb_sunny_outlined,
   Icons.sunny_snowing,
   Icons.wb_sunny,
   Icons.cloud,
   Icons.nights_stay,
   Icons.brightness_3,
  ];

  return ListView.builder(
   padding: const EdgeInsets.all(16),
   itemCount: prayTimes.length,
   itemBuilder: (context, index) {
    final time = DateTime.tryParse(prayTimes[index]) ?? DateTime.now();

    return Card(
     elevation: 5,
     margin: const EdgeInsets.symmetric(vertical: 10),
     child: ListTile(
      leading: Icon(icons[index], color: Theme.of(context).primaryColor, size: 30),
      title: Text(
       titles[index],
       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
       formatTime(time),
       style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
      ),
     ),
    );
   },
  );
 }
}
