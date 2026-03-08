// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

class DBScript {
  static final _databaseName =
      "Praises.db"; //Cloud Material Management System DB
  //static final _dbVersion = 1;

  static final DEVICE_SETTINGS = "DEVICE_SETTINGS";
  static final Settings_ID = "ID";
  static final Settings_Key = "Key";
  static final Settings_Value = "Value";

  static final initialScript = <String>[
    '''
          CREATE TABLE $DEVICE_SETTINGS (
            $Settings_ID INTEGER PRIMARY KEY AUTOINCREMENT,
             $Settings_Key TEXT NOT NULL,
            $Settings_Value TEXT NOT NULL
          )
          '''
  ];

  static final migrationScripts = <String>[];

  final config = MigrationConfig(
      initializationScript: initialScript, migrationScripts: migrationScripts);

  DBScript._privateConstructor();
  static final DBScript instance = DBScript._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    String path1 = path.join(await getDatabasesPath(), _databaseName);
    return await openDatabaseWithMigration(path1, config);
  }
}
