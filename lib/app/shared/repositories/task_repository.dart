
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

abstract class TaskRepository{
  Future<int> save(TaskModel task, BoxModel box);
  Future<bool> update(TaskModel task, BoxModel box);
  Future<bool> delete(TaskModel task, BoxModel box);
  Future<bool> deleteAll(BoxModel box);
  Future<List<TaskModel>> getAll(BoxModel box);
  Future<Stream<List<TaskModel>>> listenTasks(BoxModel box);
  Future<bool> moveTask(BoxModel from, BoxModel to, TaskModel task);
}