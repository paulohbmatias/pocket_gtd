import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BlocBase {

  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _description = BehaviorSubject();

  Observable<String> get title => _title.stream;
  Observable<String> get description => _description.stream;

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;

  void cancelDialog(BuildContext context) => Navigator.of(context).pop();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _title.close();
    _description.close();
    super.dispose();
  }

}
  