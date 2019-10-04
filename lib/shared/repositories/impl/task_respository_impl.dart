import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/shared/models/box_model.dart';
import 'package:pocket_gtd/shared/models/task_model.dart';
import 'package:pocket_gtd/shared/repositories/task_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class TaskRepositoryImpl implements TaskRepository {
  final BoxModel box;
  String storeName;
  Database _db;

  TaskRepositoryImpl({@required this.box, @required this.storeName}) {
    storeName = 'boxes/${box.id}';
  }

  Future<Database> get db async {
    if (_db != null)
      return _db;
    else {
      _db = await _initDB();
      var store = intMapStoreFactory.store(storeName);
      await store.record(0).put(_db, {});
      await store.record(0).delete(_db);
      return _db;
    }
  }

  Future<Database> _initDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, "pocker_gtd.db");
    DatabaseFactory dbFactory = databaseFactoryIo;

    return await dbFactory.openDatabase(dbPath);
  }

  @override
  @override
  Future<int> save(TaskModel task) async {
    Database dbTasks = await db;
    var store = intMapStoreFactory.store(storeName);
    var key = await store.add(dbTasks, task.toJson());
    return key != null ? int.parse(key.toString()) : null;
  }

  @override
  Future<int> update(TaskModel task) async {
    Database dbTasks = await db;
    var store = intMapStoreFactory.store(storeName);
    int updates = await store.update(dbTasks, task.toJson(),
        finder: Finder(filter: Filter.byKey(task.id)));
    return updates;
  }

  Future<int> delete(TaskModel task) async {
    Database dbTasks = await db;
    var store = intMapStoreFactory.store(storeName);
    int updates = await store.delete(dbTasks,
        finder: Finder(filter: Filter.byKey(task.id)));
    return updates;
  }

  @override
  Future<List<TaskModel>> getAll() async {
    Database dbTasks = await db;
    var store = intMapStoreFactory.store(storeName);
    List<RecordSnapshot<dynamic, dynamic>> result = await store.find(dbTasks);
    List<TaskModel> tasks = List();
    result.forEach((mapTasks){
      TaskModel task = TaskModel.fromDatabase(mapTasks.value);
      box.id = mapTasks.key;
      tasks.add(task);
    });
    return tasks;
  }

  @override
  Future<int> deleteAll() async {
    Database dbTask = await db;
    var store = intMapStoreFactory.store(storeName);
    int deletes = await store.delete(dbTask);
    return deletes;
  }
}
