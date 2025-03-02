import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holyquran/pages/paradetail.dart';

class ParaIndexPage extends StatefulWidget {
  const ParaIndexPage({super.key});

  @override
  _ParaIndexPageState createState() => _ParaIndexPageState();
}

class _ParaIndexPageState extends State<ParaIndexPage> {
  List<dynamic> paras = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/paraname.json');
    final jsonData = json.decode(jsonString);
    setState(() {
      paras = jsonData["paras"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Para Index",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)], // ✅ Smooth Blue-Green Gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF61A3FE), Color(0xFF63FFD5)], // ✅ Beautiful Gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: paras.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: paras.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: InkWell(
                      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ParaDetailPage(
        id: paras[index]['id'],
        paraName: paras[index]['paraname'],
        resume: 0,
      ),
    ),
  );
},
                      borderRadius: BorderRadius.circular(15),
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.deepPurple.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple.shade200,
                            child: Text(
                              "${paras[index]['id']}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          title: Text(
                            paras[index]['paraname'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
