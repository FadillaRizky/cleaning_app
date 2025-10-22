import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SyaratKetentuan extends StatefulWidget {
  const SyaratKetentuan({super.key});

  @override
  State<SyaratKetentuan> createState() => _SyaratKetentuanState();


}

class _SyaratKetentuanState extends State<SyaratKetentuan> {
  String _policy = '';

  @override
  void initState() {
    super.initState();
    loadDoc();
  }

  Future<void> loadDoc() async {
    final text = await rootBundle.loadString('assets/syarat_dan_ketentuan.txt');
    setState(() {
      _policy = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Syarat & Ketentuan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_policy),
            ],
          ),
        ),
      ),
    );
  }
}
