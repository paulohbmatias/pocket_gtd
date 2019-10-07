import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:path/path.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';
import 'package:pocket_gtd/app/shared/preferences/preferences_app.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class SplashBloc extends BlocBase {
  final boxRepository = AppModule.to.getDependency<BoxRepository>();

  Future<void> load(BuildContext context) async {
    await _initDB();
    if (await isTheFirstTime()) {
      await createInitialBoxes(context);
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
  }

  Future<bool> isTheFirstTime() => PreferencesApp.isTheFirstTime();

  Future<void> setTheFirstTime() async => PreferencesApp.setIsTheFirstTime(true);

  Future<void> createInitialBoxes(BuildContext context) async {
    await boxRepository.saveAt(BoxModel(
        null,
        BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX),
        S.of(context).inbox,
        S.of(context).inbox_for_tasks));
    await boxRepository.saveAt(BoxModel(
        null,
        BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS),
        S.of(context).next_actions,
        S.of(context).next_actions_to_perform));
    await boxRepository.saveAt(BoxModel(
        null,
        BoxModel.getIdFromEnum(InitialBoxesEnum.ONE_DAY_MAYBE),
        S.of(context).one_day_maybe,
        S.of(context).actions_may_be_done_someday));
    await boxRepository.saveAt(BoxModel(
        null,
        BoxModel.getIdFromEnum(InitialBoxesEnum.REFERENCES),
        S.of(context).references,
        S.of(context).references_for_future_consultations));
    await boxRepository.saveAt(BoxModel(
        null,
        BoxModel.getIdFromEnum(InitialBoxesEnum.SCHEDULED),
        S.of(context).scheduled,
        S.of(context).actions_to_perform_at_a_specific_time));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
