import 'package:pocket_gtd/shared/models/task_model.dart';

abstract class TaskRepository{
  Future<int> save(TaskModel task);
  Future<bool> update(TaskModel task);
  Future<bool> delete(TaskModel task);
  Future<List<TaskModel>> getAll();
}