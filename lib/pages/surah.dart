import 'package:flutter/material.dart';

class SurahPage extends StatelessWidget {
  const SurahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Surah")),
      body: const Center(
        child: Text("Surah Page Content"),
      ),
    );
  }
}
