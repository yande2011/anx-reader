import 'dart:io';

import 'package:anx_reader/utils/get_path/documents_path.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<String> getAnxDataBasesPath() async {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      final path = await getDatabasesPath();
      return path;
    case TargetPlatform.iOS:
      return await getApplicationDocumentsDirectory().then((value) => value.path);
    case TargetPlatform.windows:
      final documentsPath = await getDocumentsPath();
      return '$documentsPath\\databases';
    default:
      throw Exception('Unsupported platform');
  }
}
