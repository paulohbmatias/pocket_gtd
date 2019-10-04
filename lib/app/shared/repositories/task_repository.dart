
import 'package:pocket_gtd/app/shared/models/task_model.dart';

abstract class TaskRepository{
  Future<int> save(TaskModel task);
  Future<int> update(TaskModel task);
  Future<int> delete(TaskModel task);
  Future<int> deleteAll();
  Future<List<TaskModel>> getAll();
}