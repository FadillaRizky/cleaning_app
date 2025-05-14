
import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../api.dart';

class DetailDailyController extends GetxController {
  var selectedDuration = ''.obs;
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  Future<Map<String, dynamic>> getDetailPackage(String id) async{
    final data1 = await Api.getDetailPackage(id);
    final data2 = await Api.getDurationPackage(id);
    return {
      'data1': data1,
      'data2': data2,
    };
  }


  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(pickedDate);
      dateController.text = formattedDate;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      String formattedTime = DateFormat('HH:mm').format(selectedTime);
      timeController.text = formattedTime;
    }
  }
}