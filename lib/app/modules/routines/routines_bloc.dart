import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/modules/register_routines/register_routines_module.dart';

class RoutinesBloc extends BlocBase {

  void add(BuildContext context) async {
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
                  child: RegisterRoutinesModule());
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
