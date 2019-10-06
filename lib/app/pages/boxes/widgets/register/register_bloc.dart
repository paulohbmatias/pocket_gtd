import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BlocBase with RegisterValidators {
  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _description = BehaviorSubject();

  Observable<String> title(BuildContext context) =>
      _title.stream.transform(validateTitleFromStream(context));
  Observable<String> description(BuildContext context) =>
      _description.stream.transform(validateDescriptionFromStream(context));
  Observable<bool> isValidFields(BuildContext context) =>
      Observable.combineLatest2<String, String, bool>(title(context), description(context),
              (email, password) {
            return validateTitleFromString(context, _title.value).isEmpty &&
                validateDescriptionFromString(context, _description.value).isEmpty
                ? true
                : false;
          });

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;

  void cancelDialog(BuildContext context) async{
    _cleanFields();
    Navigator.of(context).pop();
  }

  void saveBox(){

  }

  _cleanFields(){
    changeTitle("");
    changeDescription("");
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _title.close();
    _description.close();
    super.dispose();
  }
}
