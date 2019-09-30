import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/shared/models/box_model.dart';
import 'package:pocket_gtd/shared/models/task_model.dart';
import 'package:pocket_gtd/shared/repositories/task_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class TaskRepositoryImpl implements TaskRepository {
  final BoxModel box;
  StoreRef store;
  Database _db;

  TaskRepositoryImpl(this.box) {
    this.store = intMapStoreFactory.store('boxes/${box.id}');
  }

  Future<Database> get db async {
    if (_db != null)
      return _db;
    else {
      _db = await _initDB();
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
    Database dbTask = await db;
    var key = await store.add(dbTask, task.toJson());
    return key != null ? int.parse(key.toString()) : null;
  }

  @override
  Future<bool> update(TaskModel task) async {
    Database dbTask = await db;
    int updateds = await store.update(dbTask, task.toJson(),
        finder: Finder(filter: Filter.byKey(task.id)));
    return updateds >= 1;
  }

  Future<bool> delete(TaskModel task) async {
    Database dbTask = await db;
    int updateds = await store.delete(dbTask,
        finder: Finder(filter: Filter.byKey(task.id)));
    return updateds >= 1;
  }

  @override
  Future<List<TaskModel>> getAll() async {
    Database dbTask = await db;
    List<RecordSnapshot<dynamic, dynamic>> tasks = await store.find(dbTask);
    return tasks.map((task) => TaskModel.fromDatabase(task));
  }
}
