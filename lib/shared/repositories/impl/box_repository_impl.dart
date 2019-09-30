import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/shared/models/box_model.dart';
import 'package:pocket_gtd/shared/repositories/box_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class BoxRepositoryImpl implements BoxRepository {
  Database _db;
  final String storeName = "boxes";


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
  Future<int> save(BoxModel box) async {
    Database dbBoxes = await db;
    var store = intMapStoreFactory.store(storeName);
    var key = await store.add(dbBoxes, box.toJson());
    return key != null ? int.parse(key.toString()) : null;
  }

  @override
  Future<int> update(BoxModel box) async {
    Database dbBoxes = await db;
    var store = intMapStoreFactory.store(storeName);
    int updates = await store.update(dbBoxes, box.toJson(),
        finder: Finder(filter: Filter.byKey(box.id)));
    return updates;
  }

  @override
  Future<int> delete(BoxModel box) async {
    Database dbBoxes = await db;
    var store = intMapStoreFactory.store(storeName);
    int updates = await store.delete(dbBoxes,
        finder: Finder(filter: Filter.byKey(box.id)));
    return updates;
  }

  @override
  Future<List<BoxModel>> getAll() async {
    Database dbBoxes = await db;
    var store = intMapStoreFactory.store(storeName);
    List<RecordSnapshot<dynamic, dynamic>> result = await store.find(dbBoxes);
    List<BoxModel> boxes = List();
    result.forEach((mapBox){
      BoxModel box = BoxModel.fromDatabase(mapBox.value);
      box.id = mapBox.key;
      boxes.add(box);
    });
    return boxes;
  }

  @override
  Future<int> deleteAll() async {
    Database dbBoxes = await db;
    var store = intMapStoreFactory.store(storeName);
    int deletes = await store.delete(dbBoxes);
    return deletes;
  }
}
