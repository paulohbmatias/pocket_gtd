import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/pages/register/register_module.dart';
import 'package:pocket_gtd/app/shared/pages/register/widgets/register_task/register_task_bloc.dart';
import 'package:pocket_gtd/app/shared/utils/DisableFocusNode.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class RegisterTaskWidget extends StatefulWidget {
  @override
  _RegisterTaskWidgetState createState() => _RegisterTaskWidgetState();
}

class _RegisterTaskWidgetState extends State<RegisterTaskWidget> {
  final bloc = RegisterModule.to.getBloc<RegisterTaskBloc>();
  Future<List<BoxModel>> futureBoxes;
  DateTime picked;

  @override
  void initState() {
    futureBoxes = bloc.getBoxes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            S.of(context).register_task,
            style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.normal),
          ),
          trailing: StreamBuilder<bool>(
              stream: bloc.isValidFields(context),
              initialData: false,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? CupertinoButton(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          bloc.isUpdate ? "UPDATE" : "SAVE",
                        ),
                        onPressed: snapshot.hasData && snapshot.data
                            ? () => bloc.isUpdate ? bloc.updateTask(context) : bloc.saveTask(context)
                            : null,
                      )
                    : Container();
              }),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: CupertinoTextField(
                  padding: const EdgeInsets.all(8),
                  controller: bloc.titleController,
                  placeholder: "Title",
                  onChanged: bloc.changeTitle,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: CupertinoTextField(
                  padding: const EdgeInsets.all(8),
                  controller: bloc.contentController,
                  placeholder: "Content",
                  onChanged: bloc.changeDescription,
                ),
              ),
              StreamBuilder<String>(
                  stream: bloc.deadline,
                  initialData: S.of(context).deadline,
                  builder: (context, snapshot) {
                    return CupertinoTextField(
                      controller: bloc.deadlineController,
                      onTap: () async {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (date) => bloc.changeDeadline(date),
                                   initialDateTime: DateTime.now(),
                                  use24hFormat: true,
                                ),
                              );
                            });
//                        picked = await picke(
//                            context: context,
//                            initialDate: new DateTime.now(),
//                            firstDate: new DateTime(2018),
//                            lastDate: new DateTime(2020));
//                        if (picked != null) bloc.changeDeadline(picked);
                      },
                      placeholder: S.of(context).deadline,
                      prefix: Icon(MdiIcons.calendar),
                      keyboardType: TextInputType.datetime,
                      enabled: true,
                      autofocus: false,
                      enableInteractiveSelection: false,
                      focusNode: DisabledFocusNode(),
                    );
                  }),
            ],
          ),
        ));
  }
}
