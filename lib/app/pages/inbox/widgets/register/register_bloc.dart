import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BlocBase {


  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _description = BehaviorSubject();
  BehaviorSubject<DateTime> _deadline = BehaviorSubject();

  Observable<String> get title => _title.stream;
  Observable<String> get description => _description.stream;
  Observable<DateTime> get deadline => _deadline.stream;

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(DateTime) get changeDeadline => _deadline.sink.add;

  void cancelDialog(BuildContext context) => Navigator.of(context).pop();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _title.close();
    _description.close();
    _deadline.close();
    super.dispose();
  }

}
  