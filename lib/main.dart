import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:path/path.dart';

void main() async{
  final appDocumentDir = await getApplicationDocumentsDirectory();

  String dbPath = join(appDocumentDir.path, "pocker_gtd.hive");

  Hive.init(dbPath);
  Hive.registerAdapter(BoxModelAdapter(), 0);
  Hive.registerAdapter(TaskModelAdapter(), 1);
  runApp(AppModule());
}
