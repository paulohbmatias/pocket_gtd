import 'package:pocket_gtd/shared/models/box_model.dart';

abstract class BoxRepository{
  Future<int> save(BoxModel box);
  Future<int> update(BoxModel box);
  Future<int> delete(BoxModel box);
  Future<int> deleteAll();
  Future<List<BoxModel>> getAll();
}