import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/modules/register/widgets/register_reference/register_reference_bloc.dart';
import 'package:pocket_gtd/generated/i18n.dart';
class RegisterReferenceWidget extends StatefulWidget {
  @override
  _RegisterReferenceWidgetState createState() => _RegisterReferenceWidgetState();
}

class _RegisterReferenceWidgetState extends State<RegisterReferenceWidget> {
  final bloc = RegisterModule.to.bloc<RegisterReferenceBloc>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        FlatButton(
          onPressed: () => bloc.cancelDialog(context),
          child: Text(I18n.of(context).cancel),
        ),
        StreamBuilder<bool>(
            stream: bloc.isValidFields(context),
            initialData: false,
            builder: (context, snapshot) {
              return FlatButton(
                onPressed: snapshot.hasData && snapshot.data
                    ? () => bloc.isUpdate ? bloc.updateReference(context) : bloc.saveReference(context)
                    : null,
                child: !bloc.isUpdate ? Text(I18n.of(context).save) : Text(I18n.of(context).update),
              );
            })
      ],
      title: Text(I18n.of(context).register_reference),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StreamBuilder<String>(
              stream: bloc.title(context),
              builder: (context, snapshot) {
                return TextField(
                  controller: bloc.titleController,
                  decoration: InputDecoration(hintText: I18n.of(context).title),
                  onChanged: bloc.changeTitle,
                );
              }),
          StreamBuilder<String>(
              stream: bloc.content(context),
              builder: (context, snapshot) {
                return TextField(
                  controller: bloc.contentController,
                  decoration:
                  InputDecoration(hintText: I18n.of(context).content),
                  onChanged: bloc.changeContent,
                );
              }),
        ],
      ),
    );
  }
}
  