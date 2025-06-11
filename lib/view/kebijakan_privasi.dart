import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KebijakanPrivasi extends StatefulWidget {
  const KebijakanPrivasi({super.key});

  @override
  State<KebijakanPrivasi> createState() => _KebijakanPrivasiState();


}

class _KebijakanPrivasiState extends State<KebijakanPrivasi> {
  String _policy = '';

  @override
  void initState() {
    super.initState();
    loadPolicy();
  }

  Future<void> loadPolicy() async {
    final text = await rootBundle.loadString('assets/privacy_policy.txt');
    setState(() {
      _policy = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kebijakan Privasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kebijakan Privasi UtilizesGO",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(_policy),
            ],
          ),
        ),
      ),
    );
  }
}
