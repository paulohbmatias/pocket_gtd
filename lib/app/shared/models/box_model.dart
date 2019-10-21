import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/enums/initial_boxes_enum.dart';
part 'hive/box_model.g.dart';

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