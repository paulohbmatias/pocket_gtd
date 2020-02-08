import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/enums/days_of_week_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';

part 'routine_model.g.dart';

@HiveType()
class RoutineModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int idLocal;

  @HiveField(2)
  String title;

  @HiveField(3)
  String details;

  @HiveField(4)
  DateTime begin;

  @HiveField(5)
  DateTime end;

  @HiveField(6)
  bool isDateUndefined;

  @HiveField(7)
  int often;

  @HiveField(8)
  int initDay;

  @HiveField(9)
  int initMonth;

  @HiveField(10)
  RoutineOftenEnum routineOften;

  @HiveField(11)
  List<DateTime> days;

  @HiveField(12)
  List<int> daysOfWeek;

  @HiveField(13)
  bool isActive = false;

  @HiveField(14)
  DateTime notification;

  @HiveField(15)
  DateTime lastAdded;

  @override
  String toString() {
    if (routineOften == RoutineOftenEnum.DAY) {
      return often <= 1 ? "repeats daily" : "repeat every $often days";
    } else if (routineOften == RoutineOftenEnum.WEEK) {
      return often <= 1 ? "repeats weekly" : "repeat every $often weeks";
    } else if (routineOften == RoutineOftenEnum.MONTH) {
      return often <= 1 ? "repeats monthly" : "repeat every $often months";
    } else{
      return often <= 1 ? "repeats annually" : "repeat every $often years"; 
    }
  }
}
