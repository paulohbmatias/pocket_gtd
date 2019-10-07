//import 'package:flutter_test/flutter_test.dart';
//import 'package:hive/hive.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:path/path.dart';
//import 'package:pocket_gtd/app/shared/models/box_model.dart';
//import 'package:pocket_gtd/app/shared/models/task_model.dart';
//import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
//import 'package:pocket_gtd/app/shared/repositories/impl/box_repository_impl.dart';
//
//void main() {
//  group("Boxes", () {
//    BoxRepository boxRepository;
//    BoxModel boxModel;
//    setUpAll(() async {
//      boxRepository = BoxRepositoryImpl();
//      boxModel = BoxModel.fromMap(
//          {'title': 'Caixa 1', 'description': 'Caixa que armazena coisas'});
//      final appDocumentDir = await getApplicationDocumentsDirectory();
//
//      String dbPath = join(appDocumentDir.path, "pocker_gtd.hive");
//
//      Hive.init(dbPath);
//      Hive.registerAdapter(BoxModelAdapter(), 0);
//      Hive.registerAdapter(TaskModelAdapter(), 1);
//    });
//
//    test("Save", () async {
//      expect(await boxRepository.save(boxModel), isInstanceOf<int>());
//    }, skip: false);
//
//     test("Update", () async {
//       boxModel.idLocal = await boxRepository.save(boxModel);
//       boxModel.title = ">>>";
//
//       expect(await boxRepository.update(boxModel), true);
//     }, skip: false);
//
//     test("Delete", () async {
//       expect(await boxRepository.delete(boxModel), true);
//     }, skip: false);
//
//     test("GetAll", () async {
//       expect(await boxRepository.getAll(), isInstanceOf<List<BoxModel>>());
//     }, skip: false);
//
//     test("DeleteAll", () async {
//       expect(await boxRepository.deleteAll(), true);
//     }, skip: false);
//  });
//}
