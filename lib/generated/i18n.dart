import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "Task"
  String get task => "Task";
  /// "Project"
  String get project => "Project";
  /// "Event"
  String get event => "Event";
  /// "Register"
  String get register => "Register";
  /// "Reference"
  String get reference => "Reference";
  /// "Cancel"
  String get cancel => "Cancel";
  /// "Save"
  String get save => "Save";
  /// "Remove"
  String get remove => "Remove";
  /// "Move"
  String get move => "Move";
  /// "Edit"
  String get edit => "Edit";
  /// "Analyze"
  String get analyze => "Analyze";
  /// "Update"
  String get update => "Update";
  /// "Create box"
  String get create_box => "Create box";
  /// "Boxes"
  String get boxes => "Boxes";
  /// "Title"
  String get title => "Title";
  /// "Content"
  String get content => "Content";
  /// "Register task"
  String get register_task => "Register task";
  /// "Register reference"
  String get register_reference => "Register reference";
  /// "Deadline"
  String get deadline => "Deadline";
  /// "Deadline"
  String get test => "Deadline";
  /// "${prefix} can't be empty"
  String error_cant_be_empty(String prefix) => "${prefix} can't be empty";
  /// "Do you really want to delete this box?"
  String get confirm_delete_box => "Do you really want to delete this box?";
  /// "Do you really want to delete the task ${task}?"
  String confirm_delete_task(String task) => "Do you really want to delete the task ${task}?";
  /// "This box contains ${numberFiles} files"
  String this_box_contains(String numberFiles) => "This box contains ${numberFiles} files";
  /// "Files: ${numberFiles}"
  String files_x(String numberFiles) => "Files: ${numberFiles}";
  /// "Inbox"
  String get inbox => "Inbox";
  /// "Inbox for tasks"
  String get inbox_for_tasks => "Inbox for tasks";
  /// "Next actions"
  String get next_actions => "Next actions";
  /// "Next actions to perform"
  String get next_actions_to_perform => "Next actions to perform";
  /// "One day/Maybe"
  String get one_day_maybe => "One day/Maybe";
  /// "Actions that may be done someday"
  String get actions_may_be_done_someday => "Actions that may be done someday";
  /// "References"
  String get references => "References";
  /// "References for future consultations"
  String get references_for_future_consultations => "References for future consultations";
  /// "Scheduled"
  String get scheduled => "Scheduled";
  /// "Actions to perform at a specific time"
  String get actions_to_perform_at_a_specific_time => "Actions to perform at a specific time";
  /// "Waiting"
  String get waiting => "Waiting";
  /// "Waiting for others"
  String get waiting_for_others => "Waiting for others";
  /// "Done"
  String get done => "Done";
  /// "completed tasks"
  String get completed_tasks => "completed tasks";
  /// "Projects"
  String get projects => "Projects";
  /// "This box contains your personal projects."
  String get this_box_contains_your_personal_projects => "This box contains your personal projects.";
  /// "Task Marked Completed"
  String get task_marked_completed => "Task Marked Completed";
  /// "Here you will add tasks, projects, and references that have not yet been reviewed."
  String get app_pages_inbox_empty_box => "Here you will add tasks, projects, and references that have not yet been reviewed.";
  /// "Here are the next actions you should take."
  String get app_pages_next_actions_empty_box => "Here are the next actions you should take.";
  /// "Empty box"
  String get app_pages_boxes_empty_box => "Empty box";
  /// "Is it actionable?"
  String get app_pages_analyze_actionable_title => "Is it actionable?";
  /// "Is this actionable? That is, is it something that can be performed and do you have all the resources to perform?"
  String get app_pages_analyze_actionable_content => "Is this actionable? That is, is it something that can be performed and do you have all the resources to perform?";
  /// "Yes"
  String get yes => "Yes";
  /// "No"
  String get no => "No";
  /// "Move action \"${task}\" to"
  String app_pages_analyze_choice_not_actionable_title(String task) => "Move action \"${task}\" to";
  /// "Trash"
  String get trash => "Trash";
  /// "Who will accomplish this task?"
  String get app_pages_analyze_delegate_title => "Who will accomplish this task?";
  /// "Name"
  String get name => "Name";
  /// "So do it now!"
  String get app_pages_analyze_do_title => "So do it now!";
  /// "Schedule"
  String get schedule => "Schedule";
  /// "Does it take less than two minutes?"
  String get app_pages_analyze_two_minutes_title => "Does it take less than two minutes?";
  /// "Does this action take less than two minutes?"
  String get app_pages_analyze_two_minutes_content => "Does this action take less than two minutes?";
  /// "Who will accomplish this task?"
  String get app_pages_analyze_who_is_going_to_do_title => "Who will accomplish this task?";
  /// "Who will be responsible for performing the task?"
  String get app_pages_analyze_who_is_going_to_do_content => "Who will be responsible for performing the task?";
  /// "Someone else"
  String get someone_else => "Someone else";
  /// "Me"
  String get me => "Me";
  /// "Does this action need more than one step to complete?"
  String get app_pages_analyze_are_project_title => "Does this action need more than one step to complete?";
  /// "Do you want to move \"${task}\" to Projects?"
  String app_pages_analyze_move_to_project_title(String task) => "Do you want to move \"${task}\" to Projects?";
  /// "If an action needs more than one step to complete, then it is a project."
  String get app_pages_analyze_move_to_project_content => "If an action needs more than one step to complete, then it is a project.";
  /// "Move to Projects"
  String get move_to_projects => "Move to Projects";
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_pt_BR extends I18n {
  const _I18n_pt_BR();

  /// "Tarefa"
  @override
  String get task => "Tarefa";
  /// "Projeto"
  @override
  String get project => "Projeto";
  /// "Eventos"
  @override
  String get event => "Eventos";
  /// "Registrar"
  @override
  String get register => "Registrar";
  /// "Referência"
  @override
  String get reference => "Referência";
  /// "Cancelar"
  @override
  String get cancel => "Cancelar";
  /// "Salvar"
  @override
  String get save => "Salvar";
  /// "Remover"
  @override
  String get remove => "Remover";
  /// "Mover"
  @override
  String get move => "Mover";
  /// "Editar"
  @override
  String get edit => "Editar";
  /// "Analisar"
  @override
  String get analyze => "Analisar";
  /// "Atualização"
  @override
  String get update => "Atualização";
  /// "Criar caixa"
  @override
  String get create_box => "Criar caixa";
  /// "Caixas"
  @override
  String get boxes => "Caixas";
  /// "Título"
  @override
  String get title => "Título";
  /// "Conteúdo"
  @override
  String get content => "Conteúdo";
  /// "Registar tarefa"
  @override
  String get register_task => "Registar tarefa";
  /// "Registo referência"
  @override
  String get register_reference => "Registo referência";
  /// "Prazo"
  @override
  String get deadline => "Prazo";
  /// "Prazo"
  @override
  String get test => "Prazo";
  /// "{prefixo} não pode ser vazio"
  @override
  String error_cant_be_empty(String prefix) => "{prefixo} não pode ser vazio";
  /// "Você realmente quer eliminar esta caixa?"
  @override
  String get confirm_delete_box => "Você realmente quer eliminar esta caixa?";
  /// "Você realmente deseja excluir a tarefa {tarefa}?"
  @override
  String confirm_delete_task(String task) => "Você realmente deseja excluir a tarefa {tarefa}?";
  /// "Esta caixa contém ${numberFiles} arquivos"
  @override
  String this_box_contains(String numberFiles) => "Esta caixa contém ${numberFiles} arquivos";
  /// "Arquivos: ${numberFiles}"
  @override
  String files_x(String numberFiles) => "Arquivos: ${numberFiles}";
  /// "Caixa de entrada"
  @override
  String get inbox => "Caixa de entrada";
  /// "Caixa de entrada para as tarefas"
  @override
  String get inbox_for_tasks => "Caixa de entrada para as tarefas";
  /// "Próximas ações"
  @override
  String get next_actions => "Próximas ações";
  /// "Próximas acções a realizar"
  @override
  String get next_actions_to_perform => "Próximas acções a realizar";
  /// "Um dia/Talvez"
  @override
  String get one_day_maybe => "Um dia/Talvez";
  /// "Ações que pode ser feito, algum dia."
  @override
  String get actions_may_be_done_someday => "Ações que pode ser feito, algum dia.";
  /// "Referências"
  @override
  String get references => "Referências";
  /// "Referências para futuras consultas"
  @override
  String get references_for_future_consultations => "Referências para futuras consultas";
  /// "Agendadas"
  @override
  String get scheduled => "Agendadas";
  /// "Acções a executar em uma hora específica"
  @override
  String get actions_to_perform_at_a_specific_time => "Acções a executar em uma hora específica";
  /// "Em espera"
  @override
  String get waiting => "Em espera";
  /// "Espera para que outros"
  @override
  String get waiting_for_others => "Espera para que outros";
  /// "Feito"
  @override
  String get done => "Feito";
  /// "tarefas concluídas"
  @override
  String get completed_tasks => "tarefas concluídas";
  /// "Projetos"
  @override
  String get projects => "Projetos";
  /// "Esta caixa contém seus projetos pessoais."
  @override
  String get this_box_contains_your_personal_projects => "Esta caixa contém seus projetos pessoais.";
  /// "Tarefas Marcadas Como Concluídas"
  @override
  String get task_marked_completed => "Tarefas Marcadas Como Concluídas";
  /// "Aqui você vai adicionar as tarefas, projetos e referências que ainda não foram analisadas"
  @override
  String get app_pages_inbox_empty_box => "Aqui você vai adicionar as tarefas, projetos e referências que ainda não foram analisadas";
  /// "Aqui ficam as próximas ações que você deve realizar"
  @override
  String get app_pages_next_actions_empty_box => "Aqui ficam as próximas ações que você deve realizar";
  /// "Caixa vazia"
  @override
  String get app_pages_boxes_empty_box => "Caixa vazia";
  /// "É passível de ação?"
  @override
  String get app_pages_analyze_actionable_title => "É passível de ação?";
  /// "Isso é passível de ação? Ou seja, é algo que pode ser executado e você tem todos os recursos para executar?"
  @override
  String get app_pages_analyze_actionable_content => "Isso é passível de ação? Ou seja, é algo que pode ser executado e você tem todos os recursos para executar?";
  /// "Sim"
  @override
  String get yes => "Sim";
  /// "Não"
  @override
  String get no => "Não";
  /// "Mover ação \"${task}\" para"
  @override
  String app_pages_analyze_choice_not_actionable_title(String task) => "Mover ação \"${task}\" para";
  /// "Lixeira"
  @override
  String get trash => "Lixeira";
  /// "Quem vai realizar essa ação?"
  @override
  String get app_pages_analyze_delegate_title => "Quem vai realizar essa ação?";
  /// "Nome"
  @override
  String get name => "Nome";
  /// "Então faça agora!"
  @override
  String get app_pages_analyze_do_title => "Então faça agora!";
  /// "Agende"
  @override
  String get schedule => "Agende";
  /// "Isso leva menos que dois minutos?"
  @override
  String get app_pages_analyze_two_minutes_title => "Isso leva menos que dois minutos?";
  /// "Essa ação pode ser feita em menos de dois minutos?"
  @override
  String get app_pages_analyze_two_minutes_content => "Essa ação pode ser feita em menos de dois minutos?";
  /// "Quem vai realizar essa ação?"
  @override
  String get app_pages_analyze_who_is_going_to_do_title => "Quem vai realizar essa ação?";
  /// "Quem será responsável pela realização da tarefa?"
  @override
  String get app_pages_analyze_who_is_going_to_do_content => "Quem será responsável pela realização da tarefa?";
  /// "Outra pessoa"
  @override
  String get someone_else => "Outra pessoa";
  /// "Eu"
  @override
  String get me => "Eu";
  /// "Essa ação precisa de mais de um passo para ser realizada?"
  @override
  String get app_pages_analyze_are_project_title => "Essa ação precisa de mais de um passo para ser realizada?";
  /// "Você deseja mover \"${task}\" para Projetos?"
  @override
  String app_pages_analyze_move_to_project_title(String task) => "Você deseja mover \"${task}\" para Projetos?";
  /// "Se uma ação precisa de mais de um passo para ser completada, então ela é um projeto"
  @override
  String get app_pages_analyze_move_to_project_content => "Se uma ação precisa de mais de um passo para ser completada, então ela é um projeto";
  /// "Mover para projetos"
  @override
  String get move_to_projects => "Mover para projetos";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", "US"),
      Locale("pt", "BR")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("pt_BR" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_pt_BR());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("pt" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_pt_BR());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}