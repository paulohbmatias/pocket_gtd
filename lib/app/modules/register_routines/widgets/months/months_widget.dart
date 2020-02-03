import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/initial_day_of_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/enums/often_month_enum.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';
import 'package:pocket_gtd/app/shared/enums/days_of_week_enum.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class MonthsWidget extends StatelessWidget {
  final bloc = RegisterRoutinesModule.to.bloc<RegisterRoutinesBloc>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OftenMonthEnum>(
      stream: bloc.oftenMonth,
      initialData: OftenMonthEnum.SPECIFIC_DAY,
      builder: (context, snapshot) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<OftenMonthEnum>(
                  value: OftenMonthEnum.SPECIFIC_DAY,
                  groupValue: snapshot.data,
                  title: StreamBuilder<int>(
                    stream: bloc.selectedDay,
                    initialData: 1,
                    builder: (context, snapshot) {
                      return DropdownButton<int>(
                        items: bloc.listDays.map<DropdownMenuItem<int>>((item) {
                          return DropdownMenuItem(
                            child: Text("${I18n.of(context).Day} $item"),
                            value: item,
                          );
                        }).toList(),
                        isExpanded: true,
                        value: snapshot.data,
                        onChanged: bloc.changeSelectedDay,
                      );
                    },
                  ),
                  onChanged: bloc.changeOftenMonth),
              RadioListTile<OftenMonthEnum>(
                  value: OftenMonthEnum.WEEK_DAY,
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: StreamBuilder<InitialDayOfMonthEnum>(
                            stream: bloc.initialDayOfMonth,
                            initialData: InitialDayOfMonthEnum.FIRST,
                            builder: (context, snapshot) {
                              return DropdownButton<InitialDayOfMonthEnum>(
                                items: bloc
                                    .getInitialDayOfMonth(context)
                                    .entries
                                    .map<
                                        DropdownMenuItem<
                                            InitialDayOfMonthEnum>>((item) {
                                  return DropdownMenuItem(
                                    child: Text(item.key),
                                    value: item.value,
                                  );
                                }).toList(),
                                isExpanded: true,
                                value: snapshot.data,
                                onChanged: bloc.changeInitialDayOfMonth,
                              );
                            },
                          ),
                        ),
                      ),
                      StreamBuilder<DaysOfWeekEnum>(
                        stream: bloc.dayOfInit,
                        initialData: DaysOfWeekEnum.SUNDAY,
                        builder: (context, snapshot) {
                          return DropdownButton<DaysOfWeekEnum>(
                            items: bloc
                                .getRoutineDays(context)
                                .entries
                                .map<DropdownMenuItem<DaysOfWeekEnum>>((item) {
                              return DropdownMenuItem(
                                child: Text(item.key),
                                value: item.value,
                              );
                            }).toList(),
                            value: snapshot.data,
                            onChanged: bloc.changeDayOfInit,
                          );
                        },
                      ),
                    ],
                  ),
                  groupValue: snapshot.data,
                  onChanged: bloc.changeOftenMonth),
            ],
          ),
        );
      },
    );
  }
}
