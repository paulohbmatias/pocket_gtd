import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppBarWidget extends AppBar {
  final Observable<int> pageStream;
  final int initialPage;
  final int page;

  AppBarWidget(this.pageStream, this.initialPage, this.page);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      builder: (context, snapshot) {
        return null;
      },
    );
  }
}
