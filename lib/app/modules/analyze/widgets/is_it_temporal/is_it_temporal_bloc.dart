import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class IsItTemporalBloc extends BlocBase {
  final TaskModel task;

  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  IsItTemporalBloc(this.task);

  schedule(DateTime when){
    task.when = when;
    task.save();
    taskRepository.moveTask(
      BoxModel.fromEnum(InitialBoxesEnum.INBOX),
      BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED),
      task,
    );
  }

  nextActions() {
    task.when = DateTime.now();
    task.save();
    taskRepository.moveTask(
      BoxModel.fromEnum(InitialBoxesEnum.INBOX),
      BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED),
      task,
    );
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
