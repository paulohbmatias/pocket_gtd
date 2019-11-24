import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get actions_may_be_done_someday => "Actions that may be done someday";
  String get actions_to_perform_at_a_specific_time => "Actions to perform at a specific time";
  String get analyze => "Analyze";
  String get app_pages_boxes_empty_box => "Empty box";
  String get app_pages_inbox_empty_box => "Here you will add tasks, projects, and references that have not yet been reviewed.";
  String get app_pages_next_actions_empty_box => "Here are the next actions you should take.";
  String get boxes => "Boxes";
  String get cancel => "Cancel";
  String get completed_tasks => "completed tasks";
  String get confirm_delete_box => "Do you really want to delete this box?";
  String get content => "Content";
  String get create_box => "Create box";
  String get deadline => "Deadline";
  String get done => "Done";
  String get edit => "Edit";
  String get event => "Event";
  String get inbox => "Inbox";
  String get inbox_for_tasks => "Inbox for tasks";
  String get move => "Move";
  String get next_actions => "Next actions";
  String get next_actions_to_perform => "Next actions to perform";
  String get one_day_maybe => "One day/Maybe";
  String get project => "Project";
  String get projects => "Projects";
  String get reference => "Reference";
  String get references => "References";
  String get references_for_future_consultations => "References for future consultations";
  String get register => "Register";
  String get register_reference => "Register reference";
  String get register_task => "Register task";
  String get remove => "Remove";
  String get save => "Save";
  String get scheduled => "Scheduled";
  String get task => "Task";
  String get task_marked_completed => "Task Marked Completed";
  String get test => "Deadline";
  String get this_box_contains_your_personal_projects => "This box contains your personal projects.";
  String get title => "Title";
  String get update => "Update";
  String get waiting => "Waiting";
  String get waiting_for_others => "Waiting for others";
  String confirm_delete_task(String task) => "Do you really want to delete the task $task?";
  String error_cant_be_empty(String prefix) => "$prefix can't be empty";
  String files_x(String numberFiles) => "Files: $numberFiles";
  String this_box_contains(String numberFiles) => "This box contains $numberFiles files";
}

class $en extends S {
  const $en();
}

class $pt_BR extends S {
  const $pt_BR();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get cancel => "Cancelar";
  @override
  String get app_pages_next_actions_empty_box => "Aqui ficam as próximas ações que você deve realizar";
  @override
  String get projects => "Projetos";
  @override
  String get references => "Referências";
  @override
  String get waiting => "Em espera";
  @override
  String get register_task => "Registar tarefa";
  @override
  String get scheduled => "Agendado";
  @override
  String get save => "Salvar";
  @override
  String get project => "Projeto";
  @override
  String get update => "Atualização";
  @override
  String get title => "Título";
  @override
  String get remove => "Remover";
  @override
  String get content => "Conteúdo";
  @override
  String get reference => "Referência";
  @override
  String get references_for_future_consultations => "Referências para futuras consultas";
  @override
  String get inbox_for_tasks => "Caixa de entrada para as tarefas";
  @override
  String get actions_may_be_done_someday => "Ações que pode ser feito, algum dia.";
  @override
  String get register_reference => "Registo referência";
  @override
  String get app_pages_boxes_empty_box => "Caixa vazia";
  @override
  String get event => "Eventos";
  @override
  String get deadline => "Prazo";
  @override
  String get boxes => "Caixas";
  @override
  String get actions_to_perform_at_a_specific_time => "Acções a executar em uma hora específica";
  @override
  String get move => "Mover";
  @override
  String get this_box_contains_your_personal_projects => "Esta caixa contém seus projetos pessoais.";
  @override
  String get test => "Prazo";
  @override
  String get edit => "Editar";
  @override
  String get confirm_delete_box => "Você realmente quer eliminar esta caixa?";
  @override
  String get one_day_maybe => "Um dia\/Talvez";
  @override
  String get waiting_for_others => "Espera para que outros";
  @override
  String get create_box => "Criar caixa";
  @override
  String get completed_tasks => "tarefas concluídas";
  @override
  String get done => "Feito";
  @override
  String get app_pages_inbox_empty_box => "Aqui você vai adicionar as tarefas, projetos e referências que ainda não foram analisadas";
  @override
  String get task_marked_completed => "Tarefas Marcadas Como Concluídas";
  @override
  String get task => "Tarefa";
  @override
  String get analyze => "Analisar";
  @override
  String get next_actions_to_perform => "Próximas acções a realizar";
  @override
  String get inbox => "Caixa de entrada";
  @override
  String get register => "Registrar";
  @override
  String get next_actions => "Próximas ações";
  @override
  String confirm_delete_task(String tarefa) => "Você realmente deseja excluir a tarefa $tarefa?";
  @override
  String this_box_contains(String numberFiles) => "Esta caixa contém $numberFiles arquivos";
  @override
  String files_x(String numberFiles) => "Arquivos: $numberFiles";
  @override
  String error_cant_be_empty(String prefixo) => "$prefixo não pode ser vazio";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("pt", "BR"),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "pt_BR":
          S.current = const $pt_BR();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
