import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:islamicapp_alhuda/Screens/SalahHomeScreen/QiblaScreen/qiblah_compass.dart';
import 'package:islamicapp_alhuda/Screens/SalahHomeScreen/QiblaScreen/qiblah_maps.dart';

import 'loading_indicator.dart';

class Qiblascreen extends StatefulWidget {
  const Qiblascreen({super.key});

  @override
  State<Qiblascreen> createState() => _QiblascreenState();
}

class _QiblascreenState extends State<Qiblascreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        ),
        body: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return LoadingIndicator();
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );
            }

            if (snapshot.data!) {
              return QiblahCompass();
            } else {
              return QiblahMaps();
            }
          },
        ),
      );
  }
}
