// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:lwhub/utils/export_utils.dart';

//======= StRING EXTENSION =======//
extension StringExtensions on String {
  /// Print Development Logs
  void printLog() {
    if (kDebugMode) log("===> $this");
  }

  /// Save to clipboard
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: this));
  }

  /// Get FileName
  String fileName() {
    return contains('/') ? split('/').last : '';
  }

  /// Get File Extension
  String fileType() {
    return contains('/') ? split('.').last : '';
  }

  /// manage https://
  String manageUrl() {
    return !contains("https://") && !contains("http://") ? "https://$this" : this;
  }

  String stringToDateTimeString({required String time, String? format, bool? isDateFormat}) {
    late String splitStartTime;
    if (time.contains('0Z')) {
      final splitDate = time.split('0Z');
      splitStartTime = splitDate[0];
    } else {
      splitStartTime = time;
    }
    DateTime? meetingStart = DateTime.tryParse((splitStartTime));
    if (isDateFormat == true) {
      return meetingStart.toString();
    } else {
      return (DateFormat(format).format(meetingStart ?? DateTime.now()));
    }
  }

  // Convert String Date format to other specific format
  String toConvert(String fromFormat, String toFormat) {
    try {
      DateFormat newDateFormat = DateFormat(toFormat);
      DateTime dateTime = DateFormat(fromFormat).parse(this);
      String selectedDate = newDateFormat.format(dateTime);
      return selectedDate;
    } catch (ex) {
      "toConvertDate $ex".printLog();
      return "";
    }
  }

  Color holidayColor(String monthName) {
    Color monthColor;
    switch (monthName) {
      case "January":
        monthColor = const Color(0xFFE98ED1);
        break;
      case "February":
        monthColor = const Color(0XFF64c331);
        break;
      case "March":
        monthColor = const Color(0XFFec8681);
        break;
      case "April":
        monthColor = const Color(0XFF5d9ed1);
        break;
      case "May":
        monthColor = const Color(0xFF7F79D1);
        break;
      case "June":
        monthColor = const Color(0XFF5d9ed1);
        break;
      case "July":
        monthColor = const Color(0xFF44D381);
        break;
      case "August":
        monthColor = const Color(0xff64c3d1);
        break;
      case "September":
        monthColor = const Color(0xFF7F79D1);
        break;
      case "October":
        monthColor = const Color(0xFFDB75C0);
        break;
      case "November":
        monthColor = const Color(0xFFEBB441);
        break;
      default:
        monthColor = const Color(0XFF99c2d1);
        break;
    }
    return monthColor;
  }
}

//to use Json Encode and Decode any value
extension JsonExtension on dynamic {
  String get jsonEncodeConvert {
    return json.encode(this);
  }

  dynamic get jsonDecodeConvert {
    return json.decode(this);
  }
}

//======= DATETIME EXTENSION =======//
extension DateExtension on DateTime {
  // Get String time difference

  DateTime applyTimeOfDay({required int hour, required int minute}) {
    return DateTime(year, month, day, hour, minute);
  }

  // Convert Datetime type to string with specific format
  String toCovertString({String toFormat = "dd-MM-yy"}) {
    try {
      String sDateTime = DateFormat(toFormat).format(this);
      return sDateTime;
    } catch (ex) {
      "toCovertString $ex".printLog();
      return "";
    }
  }

  String chatDateFormate({String toFormate = "MMMM dd yyyy"}) {
    final dateTime = DateTime(year, month, day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return dateTime == today
        ? StringsConst.today
        : dateTime == yesterday
            ? StringsConst.yesterDay
            : toCovertString(toFormat: toFormate);
  }

  String toConvertBeFormat() {
    String sDateTime = "${toCovertString(toFormat: 'yyyy-MM-dd')}T${toCovertString(toFormat: "HH:mm:ss")}.000Z";
    return sDateTime;
  }

  int get lastDayOfMonth => DateTime(year, month + 1, 0).day;

  DateTime get lastDateOfMonth => DateTime(year, month + 1, 0);

  DateTime toEventDate() {
    return DateTime(DateTime.now().year, month, day);
  }

  DateTime findLastDateOfTheWeek() {
    return add(Duration(days: DateTime.daysPerWeek - weekday - 1));
  }
}

Map<String, dynamic> jsonParser(dynamic dynamicMapData) {
  final jsonString = jsonEncode(dynamicMapData);
  return jsonDecode(jsonString);
}

/// MAP With Async
extension AsyncMap<K, V> on Map<K, V> {
  Future<void> forEachAsync(FutureOr<void> Function(K, V) fun) async {
    for (var value in entries) {
      final k = value.key;
      final v = value.value;
      await fun(k, v);
    }
  }
}

/// Calculate code execution time
Stopwatch stopwatch = Stopwatch();

enum DevExecutionTime { start, stop, reset }

/// usage:
/// executeTimeWatch(devExecutionTime: DevExecutionTime.reset);
/// executeTimeWatch(devExecutionTime: DevExecutionTime.start);
void executeTimeWatch({required DevExecutionTime devExecutionTime}) {
  switch (devExecutionTime) {
    case DevExecutionTime.start:
      stopwatch.start();
      break;
    case DevExecutionTime.stop:
      "Execution time in seconds: ${stopwatch.elapsedMilliseconds}".printLog();
      stopwatch.stop();
      break;
    case DevExecutionTime.reset:
      stopwatch.reset();
      break;
  }
}

extension DateExtensions on DateTime {
  String createdAtFormatted() {
    DateTime now = DateTime.now();
    Duration difference = now.difference(this);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'a few seconds ago';
    }
  }
}
