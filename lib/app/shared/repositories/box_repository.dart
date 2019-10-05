import 'package:pocket_gtd/app/shared/models/box_model.dart';

abstract class BoxRepository{
  Future<int> save(BoxModel box);
  Future<bool> update(BoxModel box);
  Future<bool> delete(BoxModel box);
  Future<bool> deleteAll();
  Future<List<BoxModel>> getAll();
}