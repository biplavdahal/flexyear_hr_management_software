import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattedTime(String unformattedDateTime) {
  DateTime dateTime = DateTime.parse(unformattedDateTime);
  DateFormat format = DateFormat.jms();

  String formattedDate = format.format(dateTime);

  return formattedDate;
}

String formattedDate(String unformattedDateTime) {
  DateTime dateTime = DateTime.parse(unformattedDateTime);
  DateFormat format = DateFormat.yMMMMd();

  String formattedDate = format.format(dateTime);

  return formattedDate;
}

String getCurrentDateTime() {
  DateTime now = DateTime.now();

  return "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}";
}

 getCurrentTime() {
   DateTime now = DateTime.now();
   return "${now.hour}: ${now.minute}: ${now.second}";
}


String hourFormatter(String unformattedHour) {
  final _token = unformattedHour.split(":");

  String formattedHour = "";

  if (_token[0] != "00") {
    formattedHour = "${_token[0]} Hour(s) ";
  }

  if (_token[1] != "00") {
    formattedHour += "${_token[1]} Minute(s)";
  }

  return formattedHour.isEmpty ? "0 Minute(s)" : formattedHour;
}

String lastDateOfMonth([int? month]) {
  var now = month == null
      ? DateTime.now()
      : DateTime.parse(
          "${DateTime.now().year}-${month < 10 ? '0$month' : month}-01",
        );

  var lastDayDateTime = (now.month < 12)
      ? DateTime(now.year, now.month + 1, 0)
      : DateTime(now.year + 1, 1, 0);

  return "${lastDayDateTime.year}-${lastDayDateTime.month < 10 ? '0${lastDayDateTime.month}' : lastDayDateTime.month}-${lastDayDateTime.day < 10 ? '0${lastDayDateTime.day}' : lastDayDateTime.day}";
}

String getMonthStringFromDateString(
  String date, {
  bool shortten = false,
}) {
  List<String> months = [
    "",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> shortMonths = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  String month = date.split("-")[1];

  if (month.length == 1) {
    month = '0$month';
  }

  DateTime dateTime = DateTime.parse('2021-$month-01');

  if (shortten) {
    return shortMonths[dateTime.month];
  } else {
    return months[dateTime.month];
  }
}

String weekDayFromDateString(String date, {bool shortten = true}) {
  List<String> weekDays = shortten
      ? ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
      : [
          "",
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday"
        ];

  DateTime dateTime = DateTime.parse(date);

  return weekDays[dateTime.weekday];
}

TimeOfDay stringTimeToTimeOfDay(String strTime) {
  final _time = strTime.split(" ")[1];

  final _token = _time.split(":");

  return TimeOfDay(
    hour: int.parse(_token[0]),
    minute: int.parse(_token[1]),
  );
}
