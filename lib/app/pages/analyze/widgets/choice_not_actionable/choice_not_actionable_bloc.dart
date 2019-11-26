import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class ChoiceNotActionableBloc extends BlocBase {
  final TaskModel task;
  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  ChoiceNotActionableBloc(this.task);

  moveTo(BoxModel box) =>
      taskRepository.moveTask(BoxModel.fromId(BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX)), box, task);

  remove() => task.delete();
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
