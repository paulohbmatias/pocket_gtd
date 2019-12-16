
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'icon_model.g.dart';

@HiveType()
class IconModel {
  @HiveField(0)
  int codePoint;

  @HiveField(1)
  String fontFamily;

  @HiveField(2)
  String fontPackage;

  @HiveField(3)
  bool matchTextDirection;

  IconData get iconData => IconData(
    codePoint, fontFamily: fontFamily, fontPackage: fontPackage, matchTextDirection: matchTextDirection
  );

  IconModel(this.codePoint, this.fontFamily, this.fontPackage,
      this.matchTextDirection);

  IconModel.fromIconData(IconData icon){
    this.codePoint = icon.codePoint;
    this.fontFamily = icon.fontFamily;
    this.fontPackage = icon.fontPackage;
    this.matchTextDirection = icon.matchTextDirection;
  }
}
