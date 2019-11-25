import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/register/register_module.dart';
import 'package:pocket_gtd/app/pages/register/widgets/register_task/register_task_bloc.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
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
    return Scaffold(
        key: bloc.scaffoldKey,
        appBar: AppBar(
          title: Text(
            S.of(context).register,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: bloc.titleController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: S.of(context).title,
                        ),
                        onChanged: bloc.changeTitle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: bloc.contentController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: S.of(context).content,
                        ),
                        maxLines: 4,
                        minLines: 2,
                        onChanged: bloc.changeDescription,
                      ),
                    ),
                    StreamBuilder<String>(
                        stream: bloc.deadline,
                        initialData: S.of(context).deadline,
                        builder: (context, snapshot) {
                          return TextField(
                            controller: bloc.deadlineController,
                            onTap: () async {
                              picked = await showDatePicker(
                                  context: context,
                                  initialDate: new DateTime.now(),
                                  firstDate: new DateTime(2018),
                                  lastDate: new DateTime(2020));
                              if (picked != null) bloc.changeDeadline(picked);
                            },
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: snapshot.data,
                              errorText: snapshot.error,
                              labelStyle: TextStyle(color: picked != null ? Colors.black : Colors.grey),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            enabled: true,
                            autofocus: false,
                            enableInteractiveSelection: false,
                            focusNode: DisabledFocusNode(),
                          );
                        }),
                  ],
                ),
              ),
            ),
            StreamBuilder<bool>(
                stream: bloc.isValidFields(context),
                initialData: false,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        bloc.isUpdate ? "UPDATE" : "SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: snapshot.hasData && snapshot.data
                          ? () => bloc.isUpdate ? bloc.updateTask(context) : bloc.saveTask(context)
                          : null,
                    ),
                  );
                })
          ],
        ));
  }
}
