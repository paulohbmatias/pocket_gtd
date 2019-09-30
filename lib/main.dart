import 'package:flutter/material.dart';
import 'package:pocket_gtd/modules/dashboard/dashboard_provider.dart';
import 'package:pocket_gtd/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/shared/repositories/impl/box_repository_impl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  testGetAll()async{
    BoxRepository boxRepository = BoxRepositoryImpl();

      var boxes = await boxRepository.getAll();
      print(boxes);
  }

  @override
  Widget build(BuildContext context) {
    testGetAll();
    return MaterialApp(
      title: 'Pocket GTD',
      theme: ThemeData.dark(),
      home: DashboardProvider(),
    );
  }
}
