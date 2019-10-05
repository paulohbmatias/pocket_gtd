import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/box_repository_impl.dart';
import 'package:pocket_gtd/app/shared/repositories/impl/task_repository_impl.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

void main() {
  group("Tasks", () {
    BoxModel boxFrom;
    BoxModel boxTo;
    BoxRepository boxRepository;
    TaskRepository taskRepository;
    TaskModel taskModel;
    setUpAll(() async {
      boxFrom = BoxModel(null, null, "BoxFrom", "Caixa");
      boxTo = BoxModel(null, null, "BoxTo", "Caixa");

      taskModel = TaskModel.fromMap(
          {'title': 'Caixa 1', 'description': 'Caixa que armazena coisas'});
      final appDocumentDir = await getApplicationDocumentsDirectory();

      String dbPath = join(appDocumentDir.path, "pocker_gtd.hive");

      Hive.init(dbPath);
      Hive.registerAdapter(BoxModelAdapter(), 0);
      Hive.registerAdapter(TaskModelAdapter(), 1);

      boxRepository = BoxRepositoryImpl();

      boxFrom.idLocal = await boxRepository.save(boxFrom);
      boxTo.idLocal = await boxRepository.save(boxTo);

      taskRepository = TaskRepositoryImpl(boxFrom.idLocal);
    });

    test("Save", () async {
      expect(await taskRepository.save(taskModel), isInstanceOf<int>());
    }, skip: false);

     test("Update", () async {
       taskModel.idLocal = await taskRepository.save(taskModel);
       taskModel.title = ">>>";

       expect(await taskRepository.update(taskModel), true);
     }, skip: false);

     test("MoveTo", () async {
       expect(await taskRepository.moveTask(boxFrom.idLocal, boxTo.idLocal, taskModel), true);
     }, skip: false);

     test("Delete", () async {
       expect(await taskRepository.delete(taskModel), true);
     }, skip: false);

     test("GetAll", () async {
       expect(await taskRepository.getAll(), isInstanceOf<List<TaskModel>>());
     }, skip: false);

     test("DeleteAll", () async {
       expect(await taskRepository.deleteAll(), true);
     }, skip: false);
  });
}
