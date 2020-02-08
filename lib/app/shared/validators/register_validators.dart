import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pocket_gtd/generated/i18n.dart';

mixin RegisterValidators {
  StreamTransformer<DateTime, String> validateDate() =>
      StreamTransformer<DateTime, String>.fromHandlers(handleData: (date, sink) {
        if(date != null)
          sink.add(transformDate(date));
        else
          sink.add("");
      });
  StreamTransformer<DateTime, String> validateTime() =>
      StreamTransformer<DateTime, String>.fromHandlers(handleData: (date, sink) {
        if(date != null)
          sink.add("${date.hour}:${date.minute}");
        else
          sink.add("");
      });
  String transformDate(DateTime date) => "${(date.day).toString().padLeft(2, "0")}/"
      "${(date.month).toString().padLeft(2, "0")}/${date.year} ${(date.hour).toString().padLeft(2, "0")}:${(date.minute).toString().padLeft(2, "0")}";

  StreamTransformer<String, String> validateTitleFromStream(BuildContext context) =>
      StreamTransformer.fromHandlers(handleData: (title, sink) {
        String errorTitle = _isEmpty(context, title, I18n.of(context).title);
        if (errorTitle.isNotEmpty)
          sink.addError(errorTitle);
        else
          sink.add(title);
      });
  StreamTransformer<String, String> validateDescriptionFromStream(BuildContext context) =>
      StreamTransformer.fromHandlers(handleData: (title, sink) {
        String errorTitle = _isEmpty(context, title, I18n.of(context).title);
        if (errorTitle.isNotEmpty)
          sink.addError(errorTitle);
        else
          sink.add(title);
      });

  String validateTitleFromString(BuildContext context, String title) => _isEmpty(context, title, I18n.of(context).title);

  String validateDescriptionFromString(BuildContext context, String title) =>
      _isEmpty(context, title, I18n.of(context).content);

  String _isEmpty(BuildContext context, String email, String prefix) {
    if (email.isEmpty)
      return I18n.of(context).error_cant_be_empty(prefix);
    else
      return "";
  }
}
