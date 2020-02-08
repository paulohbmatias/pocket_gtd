import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/initial_day_of_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/often_month_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/app/shared/repositories/routine_repository.dart';
import 'package:pocket_gtd/app/shared/utils/notification_utils.dart';
import 'package:pocket_gtd/app/shared/utils/routine_utils.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class RegisterRoutinesBloc extends BlocBase with RegisterValidators {
  final _routineRepository = AppModule.to.getDependency<RoutineRepository>();
  final _routineUtils = AppModule.to.getDependency<RoutineUtils>();
  final RoutineModel routine;
  final bool isUpdate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final oftenController = TextEditingController(text: "1");
  final notificationUtils = AppModule.to.getDependency<NotificationUtils>();
  final focusTitle = FocusNode();
  final focusDetails = FocusNode(
    canRequestFocus: true,
  );
  final listDays = List.generate(31, (i) => i + 1);
  final listDaysOfMonth = List<String>();
  List<int> listDaysOfWeek = List();

  RegisterRoutinesBloc({this.routine, this.isUpdate = false}) {
    if (routine != null) {
      changeTitle(routine.title);
      changeDetails(routine.details);
      changeNotification(routine.notification);
      detailsController.text = routine.details;
      titleController.text = routine.title;
    }
  }
  final _selectedDay = BehaviorSubject.seeded(1);
  final _selectedMonth = BehaviorSubject.seeded(1);
  final _startAt = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final _dayOfInit =
      BehaviorSubject<int>.seeded(1);
  final _oftenMonth =
      BehaviorSubject<OftenMonthEnum>.seeded(OftenMonthEnum.SPECIFIC_DAY);
  final _often = BehaviorSubject<int>.seeded(1);
  final _listDaysOfWeek = BehaviorSubject<List<int>>();
  final _routineOften =
      BehaviorSubject<RoutineOftenEnum>.seeded(RoutineOftenEnum.DAY);
  final _initialDayOfMonth = BehaviorSubject<InitialDayOfMonthEnum>.seeded(
      InitialDayOfMonthEnum.FIRST);
  final _details = BehaviorSubject<String>();
  final _title = BehaviorSubject<String>();
  final _notification = BehaviorSubject<DateTime>();
  BehaviorSubject<bool> _isLoading = BehaviorSubject();
  BehaviorSubject<bool> _openDetails = BehaviorSubject();

  Observable<int> get selectedDay => _selectedDay.stream;
  Observable<int> get selectedMonth => _selectedMonth.stream;
  Observable<DateTime> get startAt => _startAt.stream;
  Observable<int> get dayOfInit => _dayOfInit.stream;
  Observable<OftenMonthEnum> get oftenMonth => _oftenMonth.stream;
  Observable<int> get often => _often.stream;
  Observable<List<int>> get daysOfWeekSelected =>
      _listDaysOfWeek.stream;
  Observable<RoutineOftenEnum> get routineOften => _routineOften.stream;
  Observable<InitialDayOfMonthEnum> get initialDayOfMonth =>
      _initialDayOfMonth.stream;

  Observable<String> title(BuildContext context) =>
      _title.stream.transform(validateTitleFromStream(context));

  Observable<String> details(BuildContext context) =>
      _details.stream.transform(validateDescriptionFromStream(context));

  Observable<String> get notification =>
      _notification.stream.transform(validateTime());

  Observable<bool> get isLoading => _isLoading.stream;

  Observable<bool> get openDetails => _openDetails.stream;

  Observable<bool> isValidFields(BuildContext context) =>
      _title.transform(StreamTransformer<String, bool>.fromHandlers(
          handleData: (data, sink) {
        if (data != null &&
            validateDescriptionFromString(context, data).isEmpty) {
          sink.add(true);
        } else {
          sink.add(false);
        }
      }));
  Function(OftenMonthEnum) get changeOftenMonth => _oftenMonth.sink.add;
  Function(int) get changeOften => _often.sink.add;
  Function(int) get changeDayOfInit => _dayOfInit.sink.add;
  Function(int) get changeSelectedDay => _selectedDay.sink.add;
  Function(int) get changeSelectedMonth => _selectedMonth.sink.add;
  Function(RoutineOftenEnum) get changeRoutineOften => _routineOften.sink.add;
  Function(InitialDayOfMonthEnum) get changeInitialDayOfMonth =>
      _initialDayOfMonth.sink.add;
  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDetails => _details.sink.add;
  Function(DateTime) get changeNotification => _notification.sink.add;
  Function(DateTime) get changeStartAt => _startAt.sink.add;
  Function(bool) get changeIsLoading => _isLoading.sink.add;
  changeOpenDetails(bool value) {
    _openDetails.sink.add(value);
    focusTitle.unfocus();
    focusTitle.canRequestFocus = true;
  }

  changeDaysOfWeek(int day, bool value) {
    if (value) {
      listDaysOfWeek.add(day);
    } else {
      listDaysOfWeek.removeWhere((item) => item == day);
    }
    _listDaysOfWeek.sink.add(listDaysOfWeek);
  }

  Map<String, RoutineOftenEnum> getRoutinerOftenOptions(
          BuildContext context, bool isPlural) =>
      {
        isPlural ? I18n.of(context).days : I18n.of(context).day:
            RoutineOftenEnum.DAY,
        isPlural ? I18n.of(context).weeks : I18n.of(context).week:
            RoutineOftenEnum.WEEK,
        // isPlural ? I18n.of(context).months : I18n.of(context).month:
        //     RoutineOftenEnum.MONTH,
        // isPlural ? I18n.of(context).years : I18n.of(context).year:
        //     RoutineOftenEnum.YEAR,
      };

  Map<String, int> getRoutineDays(BuildContext context) => {
        I18n.of(context).sunday: 1,
        I18n.of(context).monday: 2,
        I18n.of(context).tuesday: 3,
        I18n.of(context).wednesday: 4,
        I18n.of(context).thursday: 5,
        I18n.of(context).friday: 6,
        I18n.of(context).saturday: 7,
      };

  Map<String, InitialDayOfMonthEnum> getInitialDayOfMonth(
          BuildContext context) =>
      {
        I18n.of(context).First: InitialDayOfMonthEnum.FIRST,
        I18n.of(context).Second: InitialDayOfMonthEnum.SECOND,
        I18n.of(context).Third: InitialDayOfMonthEnum.THIRD,
        I18n.of(context).Fourth: InitialDayOfMonthEnum.FOURTH,
        I18n.of(context).Last: InitialDayOfMonthEnum.LAST,
      };
  Map<String, int> getMonthsOfYear(BuildContext context) => {
        I18n.of(context).january: 1,
        I18n.of(context).february: 2,
        I18n.of(context).march: 3,
        I18n.of(context).april: 4,
        I18n.of(context).may: 5,
        I18n.of(context).june: 6,
        I18n.of(context).july: 7,
        I18n.of(context).august: 8,
        I18n.of(context).september: 9,
        I18n.of(context).october: 10,
        I18n.of(context).november: 11,
        I18n.of(context).december: 12,
      };

  void cancelDialog(BuildContext context) async {
    _cleanFields();
    Navigator.of(context).pop();
  }

  void saveRoutine(BuildContext context) async {
    changeIsLoading(true);
    try {
      RoutineModel routineModel = RoutineModel()
        ..title = _title.value
        ..details = _details.value != null && _details.value.isEmpty
            ? null
            : _details.value
        ..often = _often.value
        ..daysOfWeek = _listDaysOfWeek.value
        ..routineOften = _routineOften.value
        ..notification = _notification.value;
      if (_routineOften.value == RoutineOftenEnum.DAY ||
          _routineOften.value == RoutineOftenEnum.YEAR) {
        routineModel.begin = _startAt.value;
      } else if (_routineOften.value == RoutineOftenEnum.WEEK) {
        routineModel.begin = _startAt.value;
        routineModel.daysOfWeek = _listDaysOfWeek.value;
      } else {
        if (_oftenMonth.value == OftenMonthEnum.SPECIFIC_DAY) {
          routineModel.initDay = _selectedDay.value;
          routineModel.initMonth = _selectedMonth.value;
        }
      }
      await _routineRepository.save(routineModel);
    } catch (e) {
      print(e);
    } finally {
      changeIsLoading(false);
      Fluttertoast.showToast(
          msg: I18n.of(context).successfully_added_routine,
          backgroundColor: Colors.black87,
          fontSize: 15,
          toastLength: Toast.LENGTH_SHORT);
      await _routineUtils.addRoutines();
      Navigator.of(context).pop();
    }
  }

  void updateTask(BuildContext context) async {
    changeIsLoading(true);
    try {
      routine.title = _title.value;
      routine.details = _details.value;
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  _cleanFields() {
    changeTitle("");
    changeDetails("");
  }

  @override
  void dispose() {
    _selectedMonth.close();
    _startAt.close();
    _dayOfInit.close();
    _initialDayOfMonth.close();
    _selectedDay.close();
    _oftenMonth.close();
    _listDaysOfWeek.close();
    _routineOften.close();
    _often.close();
    _title.close();
    _details.close();
    _isLoading.close();
    _notification.close();
    _openDetails.close();
    super.dispose();
  }
}
