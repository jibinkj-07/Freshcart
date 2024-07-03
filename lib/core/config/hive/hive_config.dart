import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

abstract final class HiveConfig {
  static Future<void> init() async {
    // getting application directory path with [path_provider]
    Directory directory = await getApplicationDocumentsDirectory();
    // initializing hive with directory path obtained above
    await Hive.initFlutter(directory.path);

    // below are the registrations for custom class adapter boxes
  }
}
