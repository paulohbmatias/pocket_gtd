import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class BoxOptionsBloc extends BlocBase {
  final BoxModel box;

  final boxRepository = AppModule.to.getDependency<BoxRepository>();
  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  BoxOptionsBloc(this.box);

  Future<List<BoxModel>> getBoxes() async =>
      (await boxRepository.getAll()).where((b) => b.idLocal != box.idLocal).toList();

  Future<void> moveTo(TaskModel task, BoxModel boxTo) async => taskRepository.moveTask(box, boxTo, task);

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
