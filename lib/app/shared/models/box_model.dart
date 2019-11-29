import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';
part 'box_model.g.dart';

@HiveType()
class BoxModel extends HiveObject{

  @HiveField(0)
  int id;

  @HiveField(1)
  int idLocal;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  int length;

  BoxModel(this.id, this.idLocal, this.title, this.content);

  BoxModel.fromId(this.idLocal);

  BoxModel.fromEnum(InitialBoxesEnum boxEnum){
    this.idLocal = getIdFromEnum(boxEnum);
  }

  static String getBoxName(BuildContext context, BoxModel box){
    switch(box.idLocal){
      case 0: return S.of(context).inbox;
      case 1: return S.of(context).next_actions;
      case 2: return S.of(context).projects;
      case 3: return S.of(context).one_day_maybe;
      case 4: return S.of(context).references;
      case 5: return S.of(context).scheduled;
      case 6: return S.of(context).waiting;
      case 7: return S.of(context).done;
      default: return box.title;
    }
  }
  BoxModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.idLocal = map['idLocal'];
    this.title = map['title'];
    this.content = map['content'];
  }

  BoxModel.fromDatabase(var map) {
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['content'];
  }

  static int getIdFromEnum(InitialBoxesEnum initialBoxesEnum){
    switch(initialBoxesEnum){
      case InitialBoxesEnum.INBOX:
        return 0;
      case InitialBoxesEnum.NEXT_ACTIONS:
        return 1;
      case InitialBoxesEnum.PROJECTS:
        return 2;
      case InitialBoxesEnum.ONE_DAY_MAYBE:
        return 3;
      case InitialBoxesEnum.REFERENCES:
        return 4;
      case InitialBoxesEnum.SCHEDULED:
        return 5;
      case InitialBoxesEnum.WAITING:
        return 6;
      case InitialBoxesEnum.DONE:
        return 7;
      default:
        return 0;
    }
  }

  toJson() => {
    'id': this.id,
    'idLocal': this.idLocal,
    'title': this.title,
    'content': this.content
  };

}