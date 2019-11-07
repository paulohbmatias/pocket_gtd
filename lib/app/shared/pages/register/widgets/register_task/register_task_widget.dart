import 'package:flutter/material.dart';
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

  @override
  void initState() {
    futureBoxes = bloc.getBoxes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).register_task),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: bloc.titleController,
                      decoration:
                      InputDecoration(hintText: S.of(context).title),
                      onChanged: bloc.changeTitle,
                    ),
                    TextField(
                      controller: bloc.contentController,
                      decoration: InputDecoration(
                          hintText: S.of(context).content),
                      onChanged: bloc.changeDescription,
                    ),
                    !bloc.isUpdate ?
                    FutureBuilder<List<BoxModel>>(
                        future: futureBoxes,
                        builder: (context, snapshot){
                          return snapshot.hasData ? StreamBuilder<BoxModel>(
                              stream: bloc.box,
                              initialData: snapshot.data.first,
                              builder: (context, boxSelected) {
                                return DropdownButton<BoxModel>(
                                  value: boxSelected.data,
                                  elevation: 0,
                                  isExpanded: true,
                                  onChanged: bloc.changeBox,
                                  iconSize: 32,
                                  icon: Icon(MdiIcons.package),
                                  items: snapshot.data
                                      .map<DropdownMenuItem<BoxModel>>(
                                          (value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value.title)))
                                      .toList(),
                                );
                              }) : Container();
                        }) : Container(),
                    StreamBuilder<String>(
                        stream: bloc.deadline,
                        initialData: S.of(context).deadline,
                        builder: (context, snapshot){
                          return TextField(
                            controller: bloc.deadlineController,
                            onTap: () async{
                              DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: new DateTime.now(),
                                  firstDate: new DateTime(2018),
                                  lastDate: new DateTime(2020)
                              );
                              if(picked != null) bloc.changeDeadline(picked);
                            },
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: snapshot.data,
                              errorText: snapshot.error,
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            enabled: true,
                            autofocus: false,
                            enableInteractiveSelection: false,
                            focusNode: DisabledFocusNode(),
                          );
                        }
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(bloc.isUpdate ? "UPDATE" : "SAVE", style: TextStyle(color: Colors.white),),
                    onPressed: () => bloc.isUpdate ? bloc.updateTask(context) : bloc.saveTask(context),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
  