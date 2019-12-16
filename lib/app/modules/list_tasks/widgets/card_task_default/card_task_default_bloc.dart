import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class CardTaskDefaultBloc extends BlocBase {
  final BoxModel box;

  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  CardTaskDefaultBloc(this.box);

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
