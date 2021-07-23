import 'package:tracktion/helper/http.dart';
import 'package:tracktion/models/db/database.dart';

class ServerMigrator {
  final SQLDatabase db;

  ServerMigrator({required this.db});

  void migrate() async {
    final migrations = await this.db.getAllMigrations();

    for (final migration in migrations) {
      try {
        final res = await Ht.request(
            path: migration.endPoint + "/",
            verb: migration.verb,
            payload: migration.payload);
        if (res.statusCode > 400) {
          print("Something went wrong");
          break;
        }
        await this.db.deleteMigration(migration);
      } catch (e) {
        print(e);
        break;
      }
    }
    print("Migrations completed");
  }
}
