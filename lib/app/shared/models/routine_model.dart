import 'package:pocket_gtd/app/shared/enums/days_of_week_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';

class RoutineModel{
  String title;
  String details;
  DateTime begin;
  DateTime end;
  bool isDateUndefined;
  int often;
  RoutineOftenEnum routineOften;
  List<DateTime> days;
  List<DaysOfWeekEnum> daysOfWeek;
}