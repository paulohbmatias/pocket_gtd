import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/app/shared/repositories/routine_repository.dart';
import 'package:pocket_gtd/app/shared/utils/routine_utils.dart';
import 'package:rxdart/rxdart.dart';

class RoutinesBloc extends BlocBase {
  final _routineRepository = AppModule.to.getDependency<RoutineRepository>();
  final _routineUtils = AppModule.to.getDependency<RoutineUtils>();
  StreamSubscription<List<RoutineModel>> _routineSubscription;

  final _routines = BehaviorSubject<List<RoutineModel>>();

  Future<Stream<List<RoutineModel>>> listenRoutines() async {
    _routines.sink.add(await _routineRepository.getAll());
    _routineSubscription = (await _routineRepository.listenAll())
        .listen((data) => _routines.sink.add(data));
    return _routines.stream;
  }

  void add(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        elevation: 20,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (context) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: RegisterRoutinesModule());
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
  }

  void activeRoutine(RoutineModel routine, bool isActive){
    routine.isActive = isActive;
    routine.save();
    _routineUtils.addRoutines();

  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _routines.close();
    if (_routineSubscription != null) _routineSubscription.cancel();
    super.dispose();
  }
}
