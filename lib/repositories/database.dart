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
      final docDirPath = await getApplicationDocumentsDirectory();
      databasesDirPath = docDirPath.path;
    }
    var dbFilePath = join(databasesDirPath, DatabaseInfo.dbName);

    var exists = await databaseExists(dbFilePath);

    if (exists &&
        SharedPreferenceClient.isInitialized &&
        SharedPreferenceClient.databaseVerion == DatabaseInfo.dbVersion) {
      // database is upto date
      return await openDatabase(dbFilePath);
    }

    if (exists &&
        SharedPreferenceClient.isInitialized &&
        SharedPreferenceClient.databaseVerion < DatabaseInfo.dbVersion) {
      // database is outdated

      debugPrint('updating database');
      // deleting old database
      await deleteDatabase(dbFilePath);
      // saving new database
      await _saveDatabaseFromAssets(dbFilePath: dbFilePath);

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

  Future close() async {
    return _database?.close();
  }
}
