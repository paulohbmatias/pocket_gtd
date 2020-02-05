import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/enums/days_of_week_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';

part 'routine_model.g.dart';

@HiveType()
class RoutineModel {

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
  List<DaysOfWeekEnum> daysOfWeek;
}
