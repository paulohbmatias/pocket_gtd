import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/generated/i18n.dart';

mixin RegisterValidators {
  StreamTransformer<DateTime, String> validateDate() =>
      StreamTransformer<DateTime, String>.fromHandlers(
          handleData: (date, sink) {
            sink.add("${(date.day).toString().padLeft(2, "0")}/"
                "${(date.month).toString().padLeft(2, "0")}/${date.year}");
      });

  StreamTransformer<String, String> validateTitleFromStream(
          BuildContext context) =>
      StreamTransformer.fromHandlers(handleData: (title, sink) {
        String errorTitle = _isEmpty(context, title, S.of(context).title);
        if (errorTitle.isNotEmpty)
          sink.addError(errorTitle);
        else
          sink.add(title);
      });
  StreamTransformer<String, String> validateDescriptionFromStream(
          BuildContext context) =>
      StreamTransformer.fromHandlers(handleData: (title, sink) {
        String errorTitle = _isEmpty(context, title, S.of(context).title);
        if (errorTitle.isNotEmpty)
          sink.addError(errorTitle);
        else
          sink.add(title);
      });

  String validateTitleFromString(BuildContext context, String title) =>
      _isEmpty(context, title, S.of(context).title);

  String validateDescriptionFromString(BuildContext context, String title) =>
      _isEmpty(context, title, S.of(context).content);

  String _isEmpty(BuildContext context, String email, String prefix) {
    if (email.isEmpty)
      return S.of(context).error_cant_be_empty(prefix);
    else
      return "";
  }
}
