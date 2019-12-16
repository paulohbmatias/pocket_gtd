import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register/register_module.dart';
import 'package:pocket_gtd/app/shared/enums/list_type_enum.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc extends BlocBase {
  BehaviorSubject<int> _page = BehaviorSubject();

  Observable<int> get page => _page.stream;

  Function(int) get changePage => _page.sink.add;

  void add(BuildContext context, ListTypeEnum type) async {
    // await Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => RegisterModule(type)
    // ));
    showModalBottomSheet(
      context: context,
      elevation: 20,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate,
                  child: RegisterModule(type));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      )
    );
  }

  @override
  void dispose() {
    _page.close();
    super.dispose();
  }
}
