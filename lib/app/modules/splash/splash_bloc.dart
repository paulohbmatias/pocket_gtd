import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:path/path.dart';
import 'package:pocket_gtd/app/modules/dashboard/dashboard_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/icon_model.dart';
import 'package:pocket_gtd/app/shared/models/priority_enum.dart';
import 'package:pocket_gtd/app/shared/models/priority_enum.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/models/user_model.dart';
import 'package:pocket_gtd/app/shared/preferences/preferences_app.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class SplashBloc extends BlocBase {
  final boxRepository = AppModule.to.getDependency<BoxRepository>();

  Future<void> load(BuildContext context) async {
    Future.delayed(Duration(seconds: 3)).whenComplete(() async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardModule()));
    });
    await _initDB();
    await createInitialBoxes(context);
    if (await isTheFirstTime()) {
      await setTheFirstTime();
    }
  }

  Future<void> _initDB({String email}) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();

    String dbPath =
        join(appDocumentDir.path, "pocker_gtd_${email ?? "default"}.hive");

    Hive.init(dbPath);
    Hive.registerAdapter(BoxModelAdapter(), 0);
    Hive.registerAdapter(TaskModelAdapter(), 1);
    Hive.registerAdapter(UserModelAdapter(), 2);
    Hive.registerAdapter(IconModelAdapter(), 3);
    Hive.registerAdapter(PriorityEnumAdapter(), 4);
  }

  Future<bool> isTheFirstTime() => PreferencesApp.isTheFirstTime();

  Future<void> setTheFirstTime() async =>
      PreferencesApp.setIsTheFirstTime(false);

  Future<void> createInitialBoxes(BuildContext context) async {
    try {
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX),
          I18n.of(context).inbox,
          I18n.of(context).inbox_for_tasks,
          IconModel.fromIconData(OMIcons.inbox)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS),
          I18n.of(context).next_actions,
          I18n.of(context).next_actions_to_perform,
          IconModel.fromIconData(OMIcons.keyboardArrowRight)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.PROJECTS),
          I18n.of(context).projects,
          I18n.of(context).this_box_contains_your_personal_projects,
          IconModel.fromIconData(OMIcons.developerBoard)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.ONE_DAY_MAYBE),
          I18n.of(context).one_day_maybe,
          I18n.of(context).actions_may_be_done_someday,
          IconModel.fromIconData(OMIcons.cloud)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.REFERENCES),
          I18n.of(context).references,
          I18n.of(context).references_for_future_consultations,
          IconModel.fromIconData(OMIcons.folder)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.SCHEDULED),
          I18n.of(context).scheduled,
          I18n.of(context).actions_to_perform_at_a_specific_time,
          IconModel.fromIconData(MdiIcons.calendarOutline)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.WAITING),
          I18n.of(context).waiting,
          I18n.of(context).waiting_for_others,
          IconModel.fromIconData(OMIcons.hourglassEmpty)));
      await boxRepository.saveAt(BoxModel(
          null,
          BoxModel.getIdFromEnum(InitialBoxesEnum.DONE),
          I18n.of(context).done,
          I18n.of(context).completed_tasks,
          IconModel.fromIconData(OMIcons.done)));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
