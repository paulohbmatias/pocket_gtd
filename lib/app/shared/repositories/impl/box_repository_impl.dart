import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';

class BoxRepositoryImpl extends BlocBase implements BoxRepository {
  Box _box;
  final String storeName = "boxes";

  Future<Box> getBox() async {
    if (_box != null)
      return await Hive.openBox(storeName);
    else {
      _box = await _initBox();
      return _box;
    }
  }

  Future<Box> _initBox() async {
    return await Hive.openBox(storeName);
  }

  @override
  Future<int> save(BoxModel box) async {
    try {
      Box boxBoxes = await getBox();
      int key = await boxBoxes.add(box);
      box.idLocal = key;
      await boxBoxes.putAt(box.idLocal, box);
      return box.idLocal;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> update(BoxModel box) async {
    try {
      Box boxBoxes = await getBox();
      await boxBoxes.putAt(box.idLocal, box);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(BoxModel box) async {
    try {
      Box boxBoxes = await getBox();
      await boxBoxes.deleteAt(box.idLocal);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BoxModel>> getAll() async {
    try {
      Box boxBoxes = await getBox();
      return boxBoxes.values.cast<BoxModel>().toList(growable: false);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteAll() async {
    try {
      Box boxBoxes = await getBox();
      await boxBoxes.deleteFromDisk();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Stream<List<BoxModel>>> listenBoxes() async {
    try {
      Box boxBoxes = await getBox();
      return boxBoxes.watch().map<List<BoxModel>>(
          (event) => boxBoxes.values.cast<BoxModel>().toList(growable: false));
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _box.close();
    super.dispose();
  }
}
