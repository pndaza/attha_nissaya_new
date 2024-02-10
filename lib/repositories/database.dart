import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../client/shared_pref_client.dart';
import '../data/constants.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

// Open Assets Database
  _initDatabase() async {
    // print('initializing Database');
    late String databasesDirPath;

    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      databasesDirPath = await getDatabasesPath();
    }
    if (Platform.isLinux || Platform.isWindows) {
      final docDirPath = await getApplicationSupportDirectory();
      databasesDirPath = docDirPath.path;
    }
    var dbFilePath = join(databasesDirPath, DatabaseInfo.dbName);

    var exists = await databaseExists(dbFilePath);

    if (exists &&
        SharedPreferenceClient.isInitialized &&
        SharedPreferenceClient.databaseVerion == DatabaseInfo.dbVersion) {
      // database is up to date
      return await openDatabase(dbFilePath);
    }

    final recents = <Map<String, Object?>>[];

    if (exists &&
        SharedPreferenceClient.isInitialized &&
        SharedPreferenceClient.databaseVerion < DatabaseInfo.dbVersion) {
      // database is outdated

      // backuping user data to memory
      final oldDatabase = await openDatabase(dbFilePath);
      try {
        recents.addAll(
            await backup(oldDatabase: oldDatabase, tableName: 'recent'));
      } catch (e, _) {
        debugPrint('error backing up recents: $e');
      }

      debugPrint('updating database');
      // deleting old database
      await deleteDatabase(dbFilePath);
      // saving new database
      await _saveDatabaseFromAssets(dbFilePath: dbFilePath);

      final newDatabase = await openDatabase(dbFilePath);
      if (recents.isNotEmpty) {
        try {
          await restore(
              newDatabase: newDatabase, tableName: 'recent', values: recents);
              debugPrint('recents are restroed successfully');
        } catch (e, _) {
          debugPrint('error restoring recents: $e');
        }
      }

      return await openDatabase(dbFilePath);
    }

    // database is not initialized

    // make sure destination path is created
    try {
      await Directory(dirname(databasesDirPath)).create(recursive: true);
    } catch (_) {}
    // saving database
    await _saveDatabaseFromAssets(dbFilePath: dbFilePath);

    return await openDatabase(dbFilePath);
  }

  Future<void> _saveDatabaseFromAssets({required String dbFilePath}) async {
    // Copy from asset
    const dbFileAssetsPath =
        "${DatabaseInfo.assetsPath}/${DatabaseInfo.dbName}";
    await _copyDatabase(assetsPath: dbFileAssetsPath, destination: dbFilePath);

    // save to pref
    SharedPreferenceClient.isInitialized = true;
    SharedPreferenceClient.databaseVerion = DatabaseInfo.dbVersion;
  }

  Future<void> _copyDatabase(
      {required String assetsPath, required String destination}) async {
    ByteData data = await rootBundle.load(assetsPath);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(destination).writeAsBytes(bytes, flush: true);
  }

  Future<List<Map<String, Object?>>> backup(
      {required Database oldDatabase, required String tableName}) async {
    // print('maps: ${maps.length}');
    try {
      return await oldDatabase.query(tableName);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> restore(
      {required Database newDatabase,
      required String tableName,
      required List<Map<String, Object?>> values}) async {
    for (final value in values) {
      await newDatabase.insert(tableName, value);
    }
  }

  Future close() async {
    return _database?.close();
  }
}
