import 'package:pocket_gtd/app/shared/models/box_model.dart';

abstract class BoxRepository{
  Future<int> save(BoxModel box);
  Future<void> update(BoxModel box);
  Future<void> delete(BoxModel box);
  Future<void> deleteAll();
  Future<List<BoxModel>> getAll();
}