import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';

class BoxOptionsBloc extends BlocBase {
  final boxRepository = AppModule.to.getDependency<BoxRepository>();
  final taskRepository = AppModule.to.getDependency<TaskRepository>();

  Future<List<BoxModel>> getBoxes(BoxModel box) async {
    final list = (await boxRepository.getAll())
          .where((b) => b.idLocal != box.idLocal)
          .toList();
    return list;
  }

  Future<void> moveTo(BuildContext context, TaskModel task, BoxModel boxFrom,
      BoxModel boxTo) async {
    try {
      if (boxTo.idLocal ==
          BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS)) {
        task.when = DateTime.now();
        boxTo = BoxModel.fromEnum(InitialBoxesEnum.SCHEDULED);
        await task.save();
      }
      await taskRepository.moveTask(boxFrom, boxTo, task);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
