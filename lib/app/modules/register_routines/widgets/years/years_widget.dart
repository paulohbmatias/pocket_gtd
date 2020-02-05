import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_bloc.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';
import 'package:pocket_gtd/app/shared/utils/date_utils.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class YearsWidget extends StatelessWidget {
  final bloc = RegisterRoutinesModule.to.bloc<RegisterRoutinesBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(I18n.of(context).start),
              ),
              Expanded(
                child: Material(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(Duration(seconds: 2)),
                          lastDate: DateTime(2060));
                      if(date != null) bloc.changeStartAt(date);
                    },
                    child: StreamBuilder<DateTime>(
                        stream: bloc.startAt,
                        initialData: DateTime.now(),
                        builder: (context, snapshot) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[300]
                                  // boxShadow: [BoxShadow(color: Colors.grey[300])],
                                  ),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                  "${DateUtils.monthFromDate(snapshot.data)} ${snapshot.data.day}"));
                        }),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
