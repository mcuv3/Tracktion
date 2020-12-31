import 'package:flutter/foundation.dart';

class Common {
  DateTime currentDate;
  Common({@required this.currentDate});
  set updateDate(DateTime date) => currentDate = date;
  get date => this.currentDate;
}
