
import 'package:pocket_gtd/app/shared/models/task_model.dart';

abstract class TaskRepository{
  Future<int> save(TaskModel task);
  Future<bool> update(TaskModel task);
  Future<bool> delete(TaskModel task);
  Future<bool> deleteAll();
  Future<List<TaskModel>> getAll();
  Future<bool> moveTask(int from, int to, TaskModel task);
}