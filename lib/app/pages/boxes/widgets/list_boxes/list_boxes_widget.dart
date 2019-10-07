import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/boxes/boxes_module.dart';
import 'package:pocket_gtd/app/pages/boxes/widgets/card_box/card_box_widget.dart';
import 'package:pocket_gtd/app/pages/boxes/widgets/list_boxes/list_boxes_bloc.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/generated/i18n.dart';

class ListBoxesWidget extends StatefulWidget {
  @override
  _ListBoxesWidgetState createState() => _ListBoxesWidgetState();
}

class _ListBoxesWidgetState extends State<ListBoxesWidget> {
  final bloc = BoxesModule.to.bloc<ListBoxesBloc>();
  Future<Stream<List<BoxModel>>> listBoxes;

  @override
  void initState() {
    listBoxes = bloc.listenBoxes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<BoxModel>>>(
      future: listBoxes,
      builder: (context, snapshot){
        return snapshot.hasData ? StreamBuilder<List<BoxModel>>(
            stream: bloc.boxes,
            initialData: <BoxModel>[],
            builder: (context, snapshot) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: ListView(
                  children: snapshot.data.map((box) {
                    return FutureBuilder<int>(
                        future: bloc.getBoxLength(box.idLocal),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) box.length = snapshot.data;
                          return snapshot.hasData ? Dismissible(
                            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                            confirmDismiss: (dismissible) async {
                              bool result;
                              await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(S.of(context).confirm_delete_box
                                    ),
                                    content: Text(S.of(context).this_box_contains(snapshot.data.toString())),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            result = false;
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("No")),
                                      FlatButton(
                                          onPressed: () {
                                            result = true;
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Yes")),
                                    ],
                                  ));
                              return result;
                            },
                            onDismissed: (dismissible) async {
                              await bloc.removeBox(box);
                            },
                            background: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            dragStartBehavior: DragStartBehavior.start,
                            direction: DismissDirection.endToStart,
                            child: CardBoxWidget(box),
                          ) : Container();
                        }
                    );
                  }).toList(),
                ),
              );
            }) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
