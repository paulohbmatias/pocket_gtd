import 'package:hive/hive.dart';

part 'days_of_week_enum.g.dart';

@HiveType()
enum DaysOfWeekEnum{
  
  @HiveField(0)
  MONDAY, 
  
  @HiveField(1)
  TUESDAY, 
  
  @HiveField(2)
  WEDNESDAY, 
  
  @HiveField(3)
  THURSDAY, 
  
  @HiveField(4)
  FRIDAY, 
  
  @HiveField(5)
  SATURDAY, 
  
  @HiveField(6)
  SUNDAY
}