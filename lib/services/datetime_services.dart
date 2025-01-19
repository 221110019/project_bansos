import 'package:flutter/material.dart';

class DatetimeServices {
  Future<DateTime?> selectDate(context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    return picked;
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return time;
  }
}
