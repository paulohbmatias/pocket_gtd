import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/list_tasks/list_tasks_module.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/widgets/empty_list/empty_list_widget.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class ListBoxesBloc extends BlocBase {
  final BoxRepository boxRepository =
      BoxesModule.to.getDependency<BoxRepository>();

  List<BoxModel> listBoxes = List();

  BehaviorSubject<List<BoxModel>> _boxes = BehaviorSubject();

  Observable<List<BoxModel>> get boxes => _boxes.stream;

  Function(List<BoxModel>) get changeBoxList => _boxes.sink.add;

  Future<int> getBoxLength(int boxID) {
    return boxRepository.getLength(boxID);
  }

  void openBox(BuildContext context, BoxModel box) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          maintainState: true,
          builder: (context) => ListTasksModule(
              box,
              ListTypeEnum.DEFAULT,
              EmptyListWidget(
                I18n.of(context).app_pages_boxes_empty_box,
                icon: MdiIcons.packageVariant,
              ))),
    );
  }

  Future<List<BoxModel>> getBoxes() async =>
      (await boxRepository.getAll()).where((box) {
        return box.idLocal != BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX) &&
            box.idLocal != BoxModel.getIdFromEnum(InitialBoxesEnum.SCHEDULED) &&
            box.idLocal !=
                BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS);
      }).toList();

  Future<Stream<List<BoxModel>>> listenBoxes() async {
    listBoxes = await getBoxes();
    changeBoxList(listBoxes);
    (await boxRepository.listenBoxes())
      ..listen((list) {
        changeBoxList(list.where((box) {
          return box.idLocal !=
                  BoxModel.getIdFromEnum(InitialBoxesEnum.INBOX) &&
              box.idLocal !=
                  BoxModel.getIdFromEnum(InitialBoxesEnum.SCHEDULED) &&
              box.idLocal !=
                  BoxModel.getIdFromEnum(InitialBoxesEnum.NEXT_ACTIONS);
        }));
      });
    return boxes;
  }

  Future<void> removeBox(BoxModel boxModel) async {
    await boxRepository.delete(boxModel);
  }

  @override
  void dispose() {
    _boxes.close();
    boxRepository.dispose();
    super.dispose();
  }
}
