import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final int boxID;
  final prefix = "boxes/";

  TaskRepositoryImpl(this.boxID);

  Future<Box> getBox({int id}) async {
    return await _initBox();
  }

  Future<Box> _initBox({int id}) async {
    String name = "$prefix${id ?? boxID}";
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    } else {
      return await Hive.openBox(name);
    }
  }

  @override
  Future<bool> save(TaskModel task, {Box boxToSave}) async {
    try {
      Box boxTasks = boxToSave == null ? await getBox() : boxToSave;
      int key = await boxTasks.add(task);
      task.idLocal = key;
      await boxTasks.putAt(task.idLocal, task);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(TaskModel task) async {
    try {
      Box boxTasks = await getBox();
      await boxTasks.putAt(task.idLocal, task);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(TaskModel task) async {
    try {
      Box boxTasks = await getBox();
      await boxTasks.deleteAt(task.idLocal);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TaskModel>> getAll() async {
    try {
      Box boxTasks = await getBox();
      return boxTasks.values.cast<TaskModel>().toList(growable: false);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> deleteAll() async {
    try {
      Box boxTasks = await getBox();
      await boxTasks.deleteFromDisk();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> moveTask(int from, int to, TaskModel task) async {
    try {
      Box boxFrom = await getBox(id: from);
      await boxFrom.deleteAt(task.idLocal);
      Box boxTo = await getBox(id: to);
      await save(task, boxToSave: boxTo);
      return false;
    } catch (e) {
      return false;
    }
  }
}
