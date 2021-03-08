import 'package:moor/moor_web.dart';

import '../database.dart';

SQLDatabase constructDb({bool logStatements = false}) {
  return SQLDatabase(WebDatabase('db', logStatements: logStatements));
}
