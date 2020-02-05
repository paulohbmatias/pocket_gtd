
import 'package:hive/hive.dart';

part 'routine_often_enum.g.dart';

@HiveType()
enum RoutineOftenEnum{
  @HiveField(0)
  DAY, 

  @HiveField(1)
  WEEK, 
  
  @HiveField(2)
  MONTH, 
  
  @HiveField(3)
  YEAR
}