import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/register/register_module.dart';
import 'package:pocket_gtd/app/pages/register/widgets/register_box/register_box_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';
class RegisterBoxWidget extends StatelessWidget {
  final bloc = RegisterModule.to.bloc<RegisterBoxBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        FlatButton(
          onPressed: () => bloc.cancelDialog(context),
          child: Text(S.of(context).cancel),
        ),
        StreamBuilder<bool>(
            stream: bloc.isValidFields(context),
            initialData: false,
            builder: (context, snapshot) {
              return FlatButton(
                onPressed: snapshot.hasData && snapshot.data
                    ? () => bloc.saveBox(context)
                    : null,
                child: Text(S.of(context).save),
              );
            })
      ],
      title: Text(S.of(context).create_box),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StreamBuilder<String>(
              stream: bloc.title(context),
              builder: (context, snapshot) {
                return TextField(
                  decoration: InputDecoration(hintText: S.of(context).title),
                  onChanged: bloc.changeTitle,
                );
              }),
          StreamBuilder<String>(
              stream: bloc.description(context),
              builder: (context, snapshot) {
                return TextField(
                  decoration:
                  InputDecoration(hintText: S.of(context).content),
                  onChanged: bloc.changeDescription,
                );
              }),
        ],
      ),
    );
  }
}
  