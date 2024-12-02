import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../kcons.dart';
import '../../../surahBuilder.dart';

class surahwidget extends StatelessWidget {
  const surahwidget({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Surahs.length,
      itemBuilder: (context, index) {
        final surah = Surahs[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>SurahBuilder(surah: Sur[index] ,)));
              // go to surahpage
            },
            child: Row(
              children: [
                // Circle Avatar with Surah Index
                CircleAvatar(
                  backgroundImage: const AssetImage("assets/images/Vector.png"),
                  radius: 25,
                  child: Text(
                    (index + 1).toString(), // +1 to display human-readable index
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16), // Spacing between CircleAvatar and Column

                // Column with Surah Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah["surah_name_en"],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        surah["type"],
                        style: const TextStyle(fontSize: 14, color: Color(0xff8789A3)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${surah["number_of_ayat"]} Ayat',
                        style: const TextStyle(fontSize: 14, color: Color(0xff8789A3)),
                      ),
                    ],
                  ),
                ),

                // Arabic Surah Name
                Text(
                  surah["surah_name_ar"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xff863ED5)),
                ),
              ],
            ),
          ),
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
