import 'package:pocket_gtd/shared/models/box_model.dart';
import 'package:pocket_gtd/shared/repositories/box_repository.dart';
import 'package:hive/hive.dart';

class BoxRepositoryImpl implements BoxRepository {

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
    Box boxBoxes = await getBox();
    int key = await boxBoxes.add(box);
    box.id = key;
    await boxBoxes.putAt(box.id, box);
    return key != null ? key : null;
  }

  @override
  Future<void> update(BoxModel box) async {
    Box boxBoxes = await getBox();
    await boxBoxes.putAt(box.id, box);
  }

  @override
  Future<void> delete(BoxModel box) async {
    Box boxBoxes = await getBox();
    await boxBoxes.deleteAt(box.id);
  }

  @override
  Future<List<BoxModel>> getAll() async {
    Box boxBoxes = await getBox();
    return boxBoxes.values.cast<BoxModel>().toList(growable: false);
  }

  @override
  Future<void> deleteAll() async {
    Box boxBoxes = await getBox();
    await boxBoxes.deleteFromDisk();
  }
}
