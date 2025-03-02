import 'package:flutter/material.dart';
import 'package:holyquran/pages/paradetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/resume.dart';
import 'pages/para_index.dart';
import 'pages/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int? lastParaId = prefs.getInt('last_page_id');
  String? lastParaName = prefs.getString('last_para_name');

  runApp(MyApp(lastParaId: lastParaId, lastParaName: lastParaName));
}

class MyApp extends StatelessWidget {
  final int? lastParaId;
  final String? lastParaName;

  const MyApp({super.key, this.lastParaId, this.lastParaName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/resume': (context) => _getResumePage(),
        '/para_index': (context) => const ParaIndexPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }

  Widget _getResumePage() {
    if (lastParaId != null) {
      return  ParaDetailPage(id: lastParaId!, paraName: lastParaName ?? "h",resume: 1,);
    } else {
      return const ResumePage();
    }
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {"title": "Resume", "icon": Icons.assignment, "route": "/resume"},
    {"title": "Para Index", "icon": Icons.menu_book, "route": "/para_index"},
    {"title": "About", "icon": Icons.info, "route": "/about"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "Quran App",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white, // ✅ Text Color White for Contrast
    ),
  ),
  backgroundColor: Colors.transparent, // ✅ Transparent Background
  elevation: 0, // ✅ No Default Shadow
  centerTitle: true,
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 21, 168, 53), Color.fromARGB(255, 214, 172, 35)], // ✅ Purple Gradient
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26, // ✅ Light Shadow for Depth
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
  ),
 
  automaticallyImplyLeading: false, // ✅ Back Icon Hide Kiya
),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)], // ✅ Beautiful Gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: menuItems.map((item) {
              return Card(
                elevation: 3,
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(item["icon"], color: Colors.deepPurple, size: 30),
                    title: Center(
                      child: Text(
                        item["title"],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    trailing: const SizedBox(),
                    onTap: () {
                      Navigator.pushNamed(context, item["route"]);
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
