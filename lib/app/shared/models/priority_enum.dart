import 'package:hive/hive.dart';

part 'priority_enum.g.dart';

@HiveType()
enum PriorityEnum{
  @HiveField(0)
  LOW, 
  @HiveField(1)
  NORMAL,
  @HiveField(2) 
  HIGH,
  @HiveField(3)
  URGENT
}