import 'package:flutter/material.dart';

import '../../kconst/kcons.dart';
import 'Azkardetails.dart';

class Azkarhomescreen extends StatefulWidget {
  const Azkarhomescreen({super.key});

  @override
  _AzkarhomescreenState createState() => _AzkarhomescreenState();
}

class _AzkarhomescreenState extends State<Azkarhomescreen> {
  String _searchQuery = ""; // State to hold the search query

  @override
  Widget build(BuildContext context) {
    // Filter the Azkar list based on the search query
    final filteredAzkar = Azkar.where((adhkar) {
      final query = _searchQuery.toLowerCase();
      return (adhkar.category?.toLowerCase().contains(query) ?? false) ||
          (adhkar.filename?.toLowerCase().contains(query) ?? false);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7F00FF),
        title: const Text(
          "الأذكار",
          style: TextStyle(fontFamily: "me_quran"),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AzkarSearchDelegate(Azkar),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredAzkar.length,
        itemBuilder: (context, index) {
          final adhkar = filteredAzkar[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => Azkardetails(Zkr: adhkar),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff7F00FF), Color(0xffE100FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          adhkar.category ?? "No Category",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AzkarSearchDelegate extends SearchDelegate {
  final List<dynamic> azkar;

  AzkarSearchDelegate(this.azkar);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ""; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = azkar.where((adhkar) {
      return (adhkar.category?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (adhkar.filename?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final adhkar = results[index];
        return ListTile(
          title: Text(adhkar.category ?? "No Category"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => Azkardetails(Zkr: adhkar),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = azkar.where((adhkar) {
      return (adhkar.category?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (adhkar.filename?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();

    return suggestions.isEmpty
        ? Center(
      child: Text(
        "لا توجد نتائج تطابق بحثك",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
      ),
    )
        : ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final adhkar = suggestions[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => Azkardetails(Zkr: adhkar),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff7F00FF), Color(0xffE100FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adhkar.category ?? "No Category",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
