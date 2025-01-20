import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../kconst/kcons.dart';
import '../HomeScreencubit/homescreen_cubit.dart';
import 'QuranPartDetailsScreen.dart';

class Parawidget extends StatelessWidget {
  const Parawidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quranParts.length, // Number of Quran parts
      itemBuilder: (context, index) {
        final part = quranParts[index]; // Access the specific part data

        return BlocBuilder<HomescreenCubit, HomescreenState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: GestureDetector(
                onTap: () async {
                  // Navigate to the details screen with the selected part
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => QuranPartDetailsScreen(part: part),
                    ),
                  );
                },
                child: Row(
                  children: [
                    // Circle Avatar with Part Index
                    CircleAvatar(
                      backgroundImage: const AssetImage("assets/images/Vector.png"),
                      radius: 25,
                      child: Text(
                        (index + 1).toString(), // Human-readable index
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Spacing between CircleAvatar and details

                    // Column with Part Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الجزء ${part["part"]}", // Part number in Arabic
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "عدد الآيات: ${part["ayahs"]}", // Number of Ayahs
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff8789A3),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "السور: ${part["surahs"].join(", ")}", // Surahs in this part
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff8789A3),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arabic Surah Name (Optional Addition)
                    Text(
                      "الجزء ${part["part"]}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff863ED5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          color: Colors.grey,
          indent: 16,
          endIndent: 16,
        );
      },
    );
  }
}
