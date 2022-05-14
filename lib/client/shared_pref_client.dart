import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _scrollDirectionKey = 'scroll_direction';
const _defaultScrollDirection = Axis.vertical;

const _isInitializeddKey = 'is_initialized';
const _defaultIsInitialized = false;

const _databaseVersion = 'database_version';
const _defaultDatabaseVersion = 1;

class SharedPreferenceClient {
  SharedPreferenceClient._();
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static bool get isInitialized =>
      instance.getBool(_isInitializeddKey) ?? _defaultIsInitialized;
  static set isInitialized(bool value) =>
      instance.setBool(_isInitializeddKey, value);

  static int get databaseVerion =>
      instance.getInt(_databaseVersion) ?? _defaultDatabaseVersion;
  static set databaseVerion(int value) =>
      instance.setInt(_databaseVersion, value);

  static Axis get scrollDirection => EnumToString.fromString(
      Axis.values,
      instance.getString(_scrollDirectionKey) ??
          EnumToString.convertToString(_defaultScrollDirection))!;

  static set scrollDirection(Axis value) => instance.setString(
      _scrollDirectionKey, EnumToString.convertToString(value));

  // Axis getScrollDirection() {
  //   final scrollDirectionValue = instance.getString(_scrollDirectionKey) ??
  //       EnumToString.convertToString(Axis.vertical);
  //   final Axis? scrollDirction =
  //       EnumToString.fromString(Axis.values, scrollDirectionValue);
  //   return scrollDirction!;
  // }

  // Future<void> saveScrollDirection(Axis scrollDirection) async {
  //   final scrollDirectionValue = EnumToString.convertToString(scrollDirection);
  //   await instance.setString(_scrollDirectionKey, scrollDirectionValue);
  // }
}
