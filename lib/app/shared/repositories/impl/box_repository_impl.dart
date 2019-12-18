import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';

class BoxRepositoryImpl extends BlocBase implements BoxRepository {
  final String storeName = "boxes";

  Future<Box> getBox({int id}) async {
    return await _initBox(id: id);
  }

  Future<Box> _initBox({int id}) async {
    String name = id == null ? storeName : "boxes_$id";
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    } else {
      return await Hive.openBox(name);
    }
  }

  @override
  Future<int> save(BoxModel box) async {
    try {
      Box boxBoxes = await getBox();
      int key = await boxBoxes.add(box);
      box.idLocal = key;
      await boxBoxes.put(box.idLocal, box);
      return box.idLocal;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> saveAt(BoxModel box) async{
    try {
      Box boxBoxes = await getBox();
      await boxBoxes.put(box.idLocal, box);
      boxBoxes.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> update(BoxModel box) async {
    try {
      Box boxBoxes = await getBox();
      await boxBoxes.put(box.idLocal, box);
      boxBoxes.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(BoxModel box) async {
    try {
      Box boxBoxes = await getBox();
      await boxBoxes.delete(box.idLocal);
      boxBoxes.close();
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
      boxBoxes.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getLength(int boxID) async {
    Box boxBoxes = await getBox(id: boxID);
    boxBoxes.close();
    return boxBoxes.values.length;
  }

  @override
  Future<Stream<List<BoxModel>>> listenBoxes() async {
    try {
      Box boxBoxes = await getBox();
      return boxBoxes.watch().asBroadcastStream().map<List<BoxModel>>(
          (event) => boxBoxes.values.cast<BoxModel>().toList(growable: false));
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
