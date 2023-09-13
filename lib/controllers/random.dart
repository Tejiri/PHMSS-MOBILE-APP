import 'dart:math';

import 'package:intl/intl.dart';
import 'package:phmss_patient_app/models/user.dart';

dynamic convertStringToIntIfPossible(dynamic variable) {
  if (variable is String) {
    try {
      return int.parse(variable);
    } catch (e) {
      print("Couldn't convert string to int: $e");
      return variable; // Return the original string if conversion fails
    }
  }
  return variable; // Return the original variable if it's not a string
}

formatTime({required time}) {
  final timeFormat = DateFormat.jm();
  DateTime parsedTime = DateFormat("H:m:s").parse(time);
  return timeFormat.format(parsedTime);
}

formatDate({required date}) {
  final dateTimeFormat =
      DateFormat.yMMMMd('en_US'); 

  DateTime parsedDateTime = DateFormat("y-MM-dd H:m:s").parse(date);

  return dateTimeFormat.format(parsedDateTime);
}

String generateRandomString({required int len,required User? user}) {
  String uid = (user?.id).toString();
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String rand =
      List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  return (rand + uid);
}
