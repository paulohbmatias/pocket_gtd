import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final prefix = "boxes_";

  Future<Box> getBox(int id) async {
    return await _initBox(id);
  }

  Future<Box> _initBox(int id) async {
    String name = "$prefix$id";
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    } else {
      return await Hive.openBox(name);
    }
  }

  @override
  Future<int> save(TaskModel task, BoxModel box) async {
    try {
      Box boxTasks = await getBox(box.idLocal);
      int key = await boxTasks.add(task);
      task.idLocal = key;
      await boxTasks.put(task.idLocal, task);
      boxTasks.values;
      return task.idLocal;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> update(TaskModel task, BoxModel box) async {
    try {
      Box boxTasks = await getBox(box.idLocal);
      await boxTasks.put(task.idLocal, task);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(TaskModel task, BoxModel box) async {
    try {
      Box boxTasks = await getBox(box.idLocal);
      await boxTasks.delete(task.idLocal);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TaskModel>> getAll(BoxModel box) async {
    try {
      Box boxTasks = await getBox(box.idLocal);
      return boxTasks.values.cast<TaskModel>().toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> deleteAll(BoxModel box) async {
    try {
      Box boxTasks = await getBox(box.idLocal);
      await boxTasks.deleteFromDisk();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> moveTask(BoxModel from, BoxModel to, TaskModel task) async {
    try {
      await delete(task, from);
      await save(task, to);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


}
