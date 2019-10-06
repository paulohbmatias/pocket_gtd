import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';

abstract class BoxRepository extends BlocBase{
  Future<int> save(BoxModel box);
  Future<bool> update(BoxModel box);
  Future<bool> delete(BoxModel box);
  Future<bool> deleteAll();
  Future<List<BoxModel>> getAll();
  Future<Stream<List<BoxModel>>> listenBoxes();
}