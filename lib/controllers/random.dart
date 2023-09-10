import 'package:intl/intl.dart';

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
