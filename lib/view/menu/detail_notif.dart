import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DetailNotif extends StatelessWidget {
  final String title;
  final String description;
  const DetailNotif({super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(description)
            ],
          ),
        ),
      ),
    );
  }

  static DetailNotif fromArguments() {
    final args = Get.arguments as Map<String, dynamic>;
    return DetailNotif(
      description: args['description'], title: args['title'],
    );
  }
}
