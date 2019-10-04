import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_gtd/modules/dashboard/dashboard_provider.dart';
import 'package:pocket_gtd/shared/models/box_model.dart';
import 'package:pocket_gtd/shared/models/task_model.dart';


void main() async{
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BoxModelAdapter(), 0);
  Hive.registerAdapter(TaskModelAdapter(), 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

//  test() async{
//    BoxRepository boxRepository = BoxRepositoryImpl();
//
//    await boxRepository.save(BoxModel(null, "Box aí", "Box"));
//    List<BoxModel> list = await boxRepository.getAll();
//    print(list.length);
//    list.first.title = "update";
//    await boxRepository.update(list.first);
//    List<BoxModel> list2 = await boxRepository.getAll();
//    await boxRepository.delete(list.last);
//    List<BoxModel> list3 = await boxRepository.getAll();
//    await boxRepository.deleteAll();
//    List<BoxModel> list4 = await boxRepository.getAll();
//    print('');
//  }

  @override
  Widget build(BuildContext context) {
//    test();
    return MaterialApp(
      title: 'Pocket GTD',
      theme: ThemeData.dark(),
      home: DashboardProvider(),
    );
  }
}
