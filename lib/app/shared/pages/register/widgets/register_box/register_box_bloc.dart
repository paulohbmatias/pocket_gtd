import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBoxBloc extends BlocBase with RegisterValidators{
  BoxRepository boxRepository = AppModule.to.getDependency<BoxRepository>();

  BehaviorSubject<String> _title = BehaviorSubject();
  BehaviorSubject<String> _description = BehaviorSubject();
  BehaviorSubject<bool> _isLoading = BehaviorSubject();

  Observable<String> title(BuildContext context) =>
      _title.stream.transform(validateTitleFromStream(context));

  Observable<String> description(BuildContext context) =>
      _description.stream.transform(validateDescriptionFromStream(context));

  Observable<bool> get isLoading => _isLoading.stream;

  Observable<bool> isValidFields(BuildContext context) =>
      Observable.combineLatest2<String, String, bool>(
          title(context), description(context), (email, password) {
        return validateTitleFromString(context, _title.value).isEmpty &&
            validateDescriptionFromString(context, _description.value)
                .isEmpty
            ? true
            : false;
      });

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;

  void cancelDialog(BuildContext context) async {
    _cleanFields();
    Navigator.of(context).pop();
  }

  void saveBox(BuildContext context) async {
    changeIsLoading(true);
    try {
      BoxModel boxModel =
      BoxModel(null, null, _title.value, _description.value);
      await boxRepository.save(boxModel);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      changeIsLoading(false);
    }
  }

  _cleanFields() {
    changeTitle("");
    changeDescription("");
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _title.close();
    _description.close();
    _isLoading.close();
    super.dispose();
  }
}
  