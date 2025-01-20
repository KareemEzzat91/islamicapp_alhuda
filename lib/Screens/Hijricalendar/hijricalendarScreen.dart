import 'package:flutter/material.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';

class HijriCalendarScreen extends StatefulWidget {
  const HijriCalendarScreen({super.key});

  @override
  State<HijriCalendarScreen> createState() => _HijriCalendarScreenState();
}

class _HijriCalendarScreenState extends State<HijriCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff672CBC), Color(0xff9055FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "التقويم الهجري والميلادي",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "me_quran",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "اختر التاريخ المناسب بسهولة",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildActionButton(
                context,
                "التاريخ الميلادي",
                Icons.date_range,
                Colors.blue,
                    () async {
                  final dateTime = await showGlobalDatePicker(
                    context: context,
                    pickerType: PickerType.JNormal,
                  );
                  if (dateTime != null) {
                    debugPrint(dateTime.toString());
                  }
                },
              ),
              buildActionButton(
                context,
                "التاريخ الهجري",
                Icons.star_border,
                Colors.purple,
                    () async {
                  final dateTime = await showGlobalDatePicker(
                    context: context,
                    pickerType: PickerType.JHijri,
                    textDirection: TextDirection.rtl,
                    okButtonText: "حفظ",
                    cancelButtonText: "عودة",
                  );
                  if (dateTime != null) {
                    debugPrint(dateTime.toString());
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Calendar Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                buildCalendar(
                  context,
                  "التقويم الهجري",
                  PickerType.JHijri,
                  const Color(0xff672CBC),
                ),
                const SizedBox(height: 16),
                buildCalendar(
                  context,
                  "التقويم الميلادي",
                  PickerType.JNormal,
                  const Color(0xff9055FF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton(
      BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCalendar(
      BuildContext context, String title, PickerType pickerType, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "me_quran",
            ),
          ),
          const SizedBox(height: 12),
          JGlobalDatePicker(
            widgetType: WidgetType.JContainer,
            pickerType: pickerType,
            buttons: const SizedBox(),
            primaryColor: Colors.blue,
            calendarTextColor: Colors.white,
            backgroundColor: backgroundColor,
            borderRadius: const Radius.circular(10),
            startDate: JDateModel(dateTime: DateTime.parse("1984-12-24")),
            selectedDate: JDateModel(dateTime: DateTime.now()),
            endDate: JDateModel(dateTime: DateTime.parse("2030-09-20")),
            pickerMode: DatePickerMode.day,
            pickerTheme: Theme.of(context),
            textDirection: TextDirection.rtl,
            onChange: (val) {
              debugPrint(val.toString());
            },
          ),
        ],
      ),
    );
  }
}
