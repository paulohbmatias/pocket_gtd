import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_gtd/shared/models/box_model.dart';
import 'package:pocket_gtd/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/shared/repositories/impl/box_repository_impl.dart';

void main() {
  group("Boxes", () {
    BoxRepository boxRepository;
    setUpAll(() async {
      boxRepository = BoxRepositoryImpl();
    });

    test("Save", () async {
      BoxModel box = BoxModel.fromMap(
          {'title': 'Caixa 1', 'description': 'Caixa que armazena coisas'});
      expect(await boxRepository.save(box), isInstanceOf<int>());
    }, skip: false);

    test("Update", () async {
      BoxModel box = BoxModel.fromMap({
        'id': 1,
        'title': 'Caixa 2',
        'description': 'Caixa que armazena coisas'
      });

      expect(await boxRepository.update(box), isInstanceOf<int>());
    }, skip: false);

    test("Delete", () async {
      BoxModel box = BoxModel.fromMap({
        'id': 1,
        'title': 'Caixa 1',
        'description': 'Caixa que armazena coisas'
      });
      expect(await boxRepository.delete(box), isInstanceOf<int>());
    }, skip: false);

    test("GetAll", () async {
      expect(await boxRepository.getAll(), isInstanceOf<List<BoxModel>>());
    }, skip: false);

    test("DeleteAll", () async {
      expect(await boxRepository.deleteAll(), isInstanceOf<int>());
    }, skip: false);
  });
}
