import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParaDetailPage extends StatefulWidget {
  final int id;
  final String paraName;
  final int resume;

  const ParaDetailPage({
    super.key,
    required this.id,
    required this.paraName,
    required this.resume,
  });

  @override
  _ParaDetailPageState createState() => _ParaDetailPageState();
}

class _ParaDetailPageState extends State<ParaDetailPage> {
  List<String> images = [];
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    print(widget.resume);
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      // Load JSON data from assets
      String jsonString = await rootBundle.loadString('assets/image.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      // Initialize SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      // Determine the initial page based on widget.resume
      int initialPage;
      if (widget.resume == 0) {
        // If widget.resume is 0, use widget.id directly
        initialPage = widget.id - 1; // Assuming widget.id is 1-based
      } else if (widget.resume == 1) {
        // If widget.resume is 1, use SharedPreferences to get the last saved page
        int lastSavedPage = prefs.getInt('last_page_id') ?? (widget.id - 1);
        initialPage = (lastSavedPage >= 0 && lastSavedPage < jsonData.length) ? lastSavedPage : 0;
      } else {
        // Default behavior (fallback)
        initialPage = widget.id - 1;
      }

      // Update state with the loaded data
      setState(() {
        images = jsonData.map<String>((para) => para["image"].toString()).toList();
        currentPage = initialPage;
        _pageController = PageController(initialPage: initialPage);
      });
    } catch (e) {
      // Handle errors gracefully
      print("Error loading JSON: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data: $e")),
      );
    }
  }

  Future<void> saveLastPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_page_id', page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: images.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
                saveLastPage(index); // Save page when changed
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                );
              },
            ),
    );
  }
}