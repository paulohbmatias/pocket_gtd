import 'dart:collection';

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType()
class UserModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  int idLocal;

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;

  @HiveField(4)
  DateTime birth;

  @HiveField(5)
  String sex;

  @HiveField(6)
  String photo;

  UserModel();

  UserModel.fromJson(LinkedHashMap<String, dynamic> map) {
    this.id = map['id'];
    this.idLocal = map['id_local'];
    this.name = map['name'];
    this.email = map['email'];
    this.birth = map['birth'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(map['birth'].toString())) : null;
    this.sex = map['sex'];
    this.photo = map['photo'];
  }

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'id_local': this.idLocal,
        'name': this.name,
        'email': this.email,
        'birth': this.birth.millisecondsSinceEpoch,
        'sex': this.sex,
        'photo': this.photo
      };
}
