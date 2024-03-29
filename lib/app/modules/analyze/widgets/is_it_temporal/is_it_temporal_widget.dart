import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pocket_gtd/app/modules/analyze/analyze_module.dart';
import 'package:pocket_gtd/app/modules/analyze/widgets/is_it_temporal/is_it_temporal_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class IsItTemporalWidget extends StatelessWidget {
  final bloc = AnalyzeModule.to.bloc<IsItTemporalBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(OMIcons.calendarToday),
            title: Text(I18n.of(context).schedule),
            onTap: () async{
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.day,
                firstDate: DateTime.now().subtract(Duration(days: 1)),
                lastDate: DateTime(2060),
              );
              if(date == null){
                Navigator.of(context).pop();
                return;
              }
              final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

              DateTime when = DateTime(date.year, date.month, date.day, time.hour, time.minute);

              bloc.schedule(when);

              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(OMIcons.navigateNext),
            title: Text(I18n.of(context).next_actions),
            onTap: () {
              bloc.nextActions();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
