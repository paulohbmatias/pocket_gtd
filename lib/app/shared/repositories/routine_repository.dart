import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';

abstract class RoutineRepository{
  Future<int> save(RoutineModel box);
  Future<bool> saveAt(RoutineModel box);
  Future<bool> update(RoutineModel box);
  Future<bool> delete(RoutineModel box);
  Future<bool> deleteAll();
  Future<int> getLength(int routineId);
  Future<List<RoutineModel>> getAll();
  Future<Stream<List<RoutineModel>>> listenAll();
}