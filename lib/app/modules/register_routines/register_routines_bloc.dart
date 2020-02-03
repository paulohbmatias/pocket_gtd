import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/initial_day_of_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/often_month_enum.dart';
import 'package:pocket_gtd/app/shared/enums/days_of_week_enum.dart';
import 'package:pocket_gtd/app/shared/enums/routine_often_enum.dart';
import 'package:pocket_gtd/app/shared/models/routine_model.dart';
import 'package:pocket_gtd/app/shared/utils/notification_utils.dart';
import 'package:pocket_gtd/app/shared/validators/register_validators.dart';
import 'package:pocket_gtd/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class RegisterRoutinesBloc extends BlocBase with RegisterValidators {
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
  final listDays = List.generate(31, (i) => i+1);
  final listDaysOfMonth = List<String>();
  List<DaysOfWeekEnum> listDaysOfWeek = List();

  RegisterRoutinesBloc({this.routine, this.isUpdate = false}) {
    if (routine != null) {
      changeTitle(routine.title);
      changeDetails(routine.details);
      detailsController.text = routine.details;
      titleController.text = routine.title;
    }
  }
  final _selectedDay = BehaviorSubject.seeded(1);
  final _startAt = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final _dayOfInit = BehaviorSubject<DaysOfWeekEnum>.seeded(DaysOfWeekEnum.SUNDAY);
  final _oftenMonth = BehaviorSubject<OftenMonthEnum>.seeded(OftenMonthEnum.SPECIFIC_DAY);
  final _often = BehaviorSubject<int>.seeded(1);
  final _listDaysOfWeek = BehaviorSubject<List<DaysOfWeekEnum>>();
  final _routineOften = BehaviorSubject<RoutineOftenEnum>.seeded(RoutineOftenEnum.DAY);
  final _initialDayOfMonth = BehaviorSubject<InitialDayOfMonthEnum>.seeded(InitialDayOfMonthEnum.FIRST);
  final _details = BehaviorSubject<String>();
  final _title = BehaviorSubject<String>();
  final _notification = BehaviorSubject<DateTime>();
  BehaviorSubject<bool> _isLoading = BehaviorSubject();
  BehaviorSubject<bool> _openDetails = BehaviorSubject();

  Observable<int> get selectedDay => _selectedDay.stream;
  Observable<DateTime> get startAt => _startAt.stream;
  Observable<DaysOfWeekEnum> get dayOfInit => _dayOfInit.stream;
  Observable<OftenMonthEnum> get oftenMonth => _oftenMonth.stream;
  Observable<int> get often => _often.stream;
  Observable<List<DaysOfWeekEnum>> get daysOfWeekSelected => _listDaysOfWeek.stream;
  Observable<RoutineOftenEnum> get routineOften => _routineOften.stream;
  Observable<InitialDayOfMonthEnum> get initialDayOfMonth => _initialDayOfMonth.stream;

  Observable<String> title(BuildContext context) =>
      _title.stream.transform(validateTitleFromStream(context));

  Observable<String> details(BuildContext context) =>
      _details.stream.transform(validateDescriptionFromStream(context));

  Observable<String> get notification =>
      _notification.stream.transform(validateDate());

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
  Function(DaysOfWeekEnum) get changeDayOfInit => _dayOfInit.sink.add;
  Function(int) get changeSelectedDay => _selectedDay.sink.add;
  Function(RoutineOftenEnum) get changeRoutineOften => _routineOften.sink.add;
  Function(InitialDayOfMonthEnum) get changeInitialDayOfMonth => _initialDayOfMonth.sink.add;
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

  changeDaysOfWeek(DaysOfWeekEnum day, bool value){
    if(value){
      listDaysOfWeek.add(day);
    }else{
      listDaysOfWeek.removeWhere((item) => item == day);
    }
    _listDaysOfWeek.sink.add(listDaysOfWeek);
  }

  Map<String, RoutineOftenEnum> getRoutinerOftenOptions(BuildContext context, bool isPlural) => {
    isPlural ? I18n.of(context).days : I18n.of(context).day: RoutineOftenEnum.DAY,
    isPlural ? I18n.of(context).weeks : I18n.of(context).week: RoutineOftenEnum.WEEK,
    isPlural ? I18n.of(context).months : I18n.of(context).month: RoutineOftenEnum.MONTH,
    isPlural ? I18n.of(context).years : I18n.of(context).year: RoutineOftenEnum.YEAR,
  };

  Map<String, DaysOfWeekEnum> getRoutineDays(BuildContext context) => {
    I18n.of(context).sunday: DaysOfWeekEnum.SUNDAY,
    I18n.of(context).monday: DaysOfWeekEnum.MONDAY,
    I18n.of(context).tuesday: DaysOfWeekEnum.TUESDAY,
    I18n.of(context).wednesday: DaysOfWeekEnum.WEDNESDAY,
    I18n.of(context).thursday: DaysOfWeekEnum.THURSDAY,
    I18n.of(context).friday: DaysOfWeekEnum.FRIDAY,
    I18n.of(context).saturday: DaysOfWeekEnum.SATURDAY,
  };

  Map<String, InitialDayOfMonthEnum> getInitialDayOfMonth(BuildContext context) => {
    I18n.of(context).First: InitialDayOfMonthEnum.FIRST,
    I18n.of(context).Second: InitialDayOfMonthEnum.SECOND,
    I18n.of(context).Third: InitialDayOfMonthEnum.THIRD,
    I18n.of(context).Fourth: InitialDayOfMonthEnum.FOURTH,
    I18n.of(context).Last: InitialDayOfMonthEnum.LAST,
  };

  void cancelDialog(BuildContext context) async {
    _cleanFields();
    Navigator.of(context).pop();
  }

  void saveTask(BuildContext context) async {
    changeIsLoading(true);
    try {
      RoutineModel routineModel = RoutineModel()
        ..title = _title.value
        ..details = _details.value != null && _details.value.isEmpty
            ? null
            : _details.value;
    } catch (e) {
      print(e);
    } finally {
      titleController.clear();
      detailsController.clear();
      _title.sink.add(null);
      _details.sink.add(null);
      changeIsLoading(false);
      Fluttertoast.showToast(
          msg: I18n.of(context).successfully_added,
          backgroundColor: Colors.black87,
          fontSize: 15,
          toastLength: Toast.LENGTH_SHORT);
      focusTitle.requestFocus();
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
