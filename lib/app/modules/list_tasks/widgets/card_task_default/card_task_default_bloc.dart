import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/modules/list_tasks/widgets/box_options/box_options_widget.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/repositories/task_repository.dart';
import 'package:pocket_gtd/generated/i18n.dart';

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
