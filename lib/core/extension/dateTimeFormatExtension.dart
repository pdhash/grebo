import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum DateTimeFormat { date, time }

String timeFormat(DateTime timestamp) {
  var outputFormat = DateFormat('h:mm a');
  var outputDate = outputFormat.format(timestamp);
  return outputDate;
}

extension DateTimeFormatExtension on DateTimeFormat {
  String get datePickerFormat {
    switch (this) {
      case DateTimeFormat.date:
        return 'yyyy-MMMM-dd';
      case DateTimeFormat.time:
        return "HH:mm";
    }
  }

  static String displayChatTimeFromTimestamp(DateTime timestamp) {
    int v = timestamp.difference(DateTime.now()).inDays;
    if (v > 1) {
      return "${"today".tr} ${timeFormat(timestamp)}";
    } else {
      var outputFormat = DateFormat('dd-MM-yyyy');
      var outputDate = outputFormat.format(timestamp);
      return outputDate;
    }
  }

  static String displayTimeFromTimestampForPost(DateTime timestamp) {
    var v = DateTime.now();
    if (v.day == timestamp.day) {
      if (timestamp.minute < 60) {
        var outputFormat = DateFormat('mm');
        return "${outputFormat.format(v)}min";
      } else {
        var outputFormat = DateFormat('h');
        return "${outputFormat.format(v)}hrs";
      }
    } else {
      var outputFormat = DateFormat('dd-MM-yyyy');
      var outputDate = outputFormat.format(timestamp);
      return outputDate;
    }
  }

  String get availabilityDateTimeFormat {
    switch (this) {
      case DateTimeFormat.date:
        return 'yyyy-MM-ddTHH:mm:ss';
      case DateTimeFormat.time:
        return "h:mm a";
    }
  }

  String get availabilityDBDateTimeFormat {
    switch (this) {
      case DateTimeFormat.date:
        return 'yyyy-MM-ddTHH:mm:ss';
      case DateTimeFormat.time:
        Duration duration = DateTime.now().timeZoneOffset;
        return "yyyy-MM-dd'T'HH:mm:ss${duration.isNegative ? "-" : "+"}${durationToString(duration.inMinutes)}";
    }
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
}

String appTimeFunDB(TimeOfDay timeOfDay) {
  final dt = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, timeOfDay.hour, timeOfDay.minute);
  var outputFormat =
      DateFormat(DateTimeFormat.time.availabilityDBDateTimeFormat);
  var outputDate = outputFormat.format(dt);
  print("==============$outputDate");

  return outputDate;
}

String appTimeFun(String time) {
  final dateTime = DateTime.parse(time);
  print("date========$dateTime");

  var outputFormat = DateFormat(DateTimeFormat.time.availabilityDateTimeFormat);
  var outputDate = outputFormat.format(dateTime);

  return outputDate;
}
