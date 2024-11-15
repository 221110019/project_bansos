import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  Database? database;
  String dbName = 'stoksbarang.db';

  DatabaseServices() {
    getDatabase();
  }

  Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    database = await initDatabase();
    return database!;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS stoksbarang (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            foto TEXT,
            jumlah INTEGER,
            kategori TEXT,
            deskripsi TEXT
          )
          ''');
      },
    );
  }
}
