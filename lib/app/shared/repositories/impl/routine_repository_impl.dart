import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository{
  final String storeName = "routines";

  Future<Box> getBox({int id}) async {
    return await _initBox(id: id);
  }

  Future<Box> _initBox({int id}) async {
    String name = id == null ? storeName : "routines_$id";
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    } else {
      return await Hive.openBox(name);
    }
  }

  @override
  Future<int> save(RoutineModel routine) async {
    try {
      Box boxRoutines = await getBox();
      int key = await boxRoutines.add(routine);
      routine.idLocal = key;
      await boxRoutines.put(routine.idLocal, routine);
      return routine.idLocal;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> saveAt(RoutineModel routine) async{
    try {
      Box boxRoutines = await getBox();
      await boxRoutines.put(routine.idLocal, routine);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> update(RoutineModel routine) async {
    try {
      Box boxRoutines = await getBox();
      await boxRoutines.put(routine.idLocal, routine);
      boxRoutines.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(RoutineModel routine) async {
    try {
      Box boxRoutines = await getBox();
      await boxRoutines.delete(routine.idLocal);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<RoutineModel>> getAll() async {
    try {
      Box boxRoutines = await getBox();
      List<RoutineModel> list = boxRoutines.values.cast<RoutineModel>().toList(growable: false);
      return list;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteAll() async {
    try {
      Box boxRoutines = await getBox();
      await boxRoutines.deleteFromDisk();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getLength(int routineId) async {
    Box boxRoutines = await getBox(id: routineId);
    return boxRoutines.values.length;
  }

  @override
  Future<Stream<List<RoutineModel>>> listenAll() async {
    try {
      Box boxRoutines = await getBox();
      return boxRoutines.watch().asBroadcastStream().map<List<RoutineModel>>(
          (event) => boxRoutines.values.cast<RoutineModel>().toList(growable: false));
    } catch (e) {
      return null;
    }
  }
}
