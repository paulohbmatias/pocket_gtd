import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
import 'package:pocket_gtd/app/shared/models/icon_model.dart';
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

  @HiveField(4)
  IconModel icon;

  int length;

  InitialBoxesEnum get boxEnum{
    switch(idLocal){
      case 0: return InitialBoxesEnum.INBOX;
      case 1: return InitialBoxesEnum.NEXT_ACTIONS;
      case 2: return InitialBoxesEnum.PROJECTS;
      case 3: return InitialBoxesEnum.ONE_DAY_MAYBE;
      case 4: return InitialBoxesEnum.REFERENCES;
      case 5: return InitialBoxesEnum.SCHEDULED;
      case 6: return InitialBoxesEnum.WAITING;
      case 7: return InitialBoxesEnum.DONE;
      default: return null;
    }
  }

  BoxModel(this.id, this.idLocal, this.title, this.content, this.icon);

  BoxModel.fromId(this.idLocal);

  BoxModel.fromEnum(InitialBoxesEnum boxEnum){
    this.idLocal = getIdFromEnum(boxEnum);
  }

  static String getBoxName(BuildContext context, BoxModel box){
    switch(box.idLocal){
      case 0: return I18n.of(context).inbox;
      case 1: return I18n.of(context).next_actions;
      case 2: return I18n.of(context).projects;
      case 3: return I18n.of(context).one_day_maybe;
      case 4: return I18n.of(context).references;
      case 5: return I18n.of(context).scheduled;
      case 6: return I18n.of(context).waiting;
      case 7: return I18n.of(context).done;
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