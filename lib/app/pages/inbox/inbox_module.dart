import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_bloc.dart';
import 'package:pocket_gtd/app/pages/inbox/inbox_page.dart';

class InboxModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => InboxBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => InboxPage();

  static Inject get to => Inject<InboxModule>.of();
}
