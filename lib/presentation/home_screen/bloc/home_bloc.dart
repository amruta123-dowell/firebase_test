import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_test/core/utils/navigator_service.dart';
import 'package:firebase_test/data/apiClient/api_provider.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/validators.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeGetAllTaskEvent>(_allTaskEvent);
    on<HomeAddTaskEvent>(_addTaskEvent);
    on<HomeEditTaskEvent>(_editTaskEvent);
    on<HomeDeleteTaskEvent>(_deleteTaskEvent);
    on<HomeInitialEvent>(_initialization);
    on<ClearDataEvent>(_clearData);
    on<OnselectedContainerEvent>(_selectedTaskEvent);
  }

  final ApiProvider _apiProvider = ApiProvider();
  Future<void> _allTaskEvent(
      HomeGetAllTaskEvent event, Emitter<HomeState> emit) async {
    try {
      var response = await _apiProvider.getTasks();
      log(response.data.toString());
      emit(state.copyWith(taskList: response.data));
      print(response);
    } catch (error) {
      print(error);
    }

    emit(state.copyWith(isEdit: false));
  }

  Future<void> _addTaskEvent(
      HomeAddTaskEvent event, Emitter<HomeState> emit) async {
    if (!validateFields(emit)) {
      return;
    }
    try {
      var response = await _apiProvider.addTask(
          date: state.dateController?.text ?? "",
          taskName: state.taskController?.text ?? '',
          description: state.descriptionController?.text ?? '');

      emit(state.copyWith(isEdit: false));
      add(HomeGetAllTaskEvent());

      add(ClearDataEvent());
      NavigatorClass().pop();
      event.onAddSuccess?.call("The task is created Successfully.");
    } catch (error) {
      print(error);
      add(ClearDataEvent());
      NavigatorClass().pop();
      event.onAddFailure?.call("Unable to create Task");
    }
  }

  FutureOr<void> _editTaskEvent(
      HomeEditTaskEvent event, Emitter<HomeState> emit) async {
    String selectedTaskId =
        state.taskList?[state.selectedTaskIndex ?? -1]["id"];
    emit(state.copyWith(isEdit: true));
    if (!validateFields(emit)) {
      return;
    }
    try {
      var response = _apiProvider.updateTask(
          taskId: selectedTaskId,
          taskName: state.taskController?.text ?? '',
          description: state.descriptionController?.text ?? "",
          date: state.dateController?.text ?? "");
      //  emit(state.copyWith(isEdit: true));
      NavigatorClass().pop();
      add(ClearDataEvent());
      add(HomeGetAllTaskEvent());
      event.onEditSuccess?.call("Task is edited successfully");
    } catch (error) {
      NavigatorClass().pop();
      add(ClearDataEvent());
      event.onEditFailure?.call("Unable to Edit the task");
      print(error);
    }
    emit(state.copyWith(isEdit: false));
  }

  FutureOr<void> _deleteTaskEvent(
      HomeDeleteTaskEvent event, Emitter<HomeState> emit) async {
    try {
      int selectedIndex = state.selectedTaskIndex ?? -1;
      if (selectedIndex != -1) {
        String taskId = await state.taskList?[selectedIndex]["id"];
        var response = await _apiProvider.deleteTask(taskId: taskId);
        add(HomeGetAllTaskEvent());
        event.onDeleteSuccess?.call("Task is deleted Successfully");
      }
      NavigatorClass().pop();
      add(ClearDataEvent());
      add(HomeGetAllTaskEvent());
    } catch (error) {
      print(error);
      NavigatorClass().pop();
      add(ClearDataEvent());
      event.onDeleteFailure?.call("Unable to delete the task");
    }
    emit(state.copyWith(isEdit: false));
  }

  FutureOr<void> _initialization(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        taskController: TextEditingController(),
        dateController: TextEditingController(),
        descriptionController: TextEditingController(),
        isEdit: false));
    add(HomeGetAllTaskEvent());
  }

// To clear the fields
  FutureOr<void> _clearData(
      ClearDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        taskController: TextEditingController(),
        dateController: TextEditingController(),
        descriptionController: TextEditingController(),
        isEdit: false,
        dateFieldError: '',
        descriptionError: '',
        taskFieldError: '',
        selectedTaskIndex: -1));
  }

  FutureOr<void> _selectedTaskEvent(
      OnselectedContainerEvent event, Emitter<HomeState> emit) async {
    var dateController = TextEditingController(
        text: state.taskList?[event.selectedIndex]["date"]);
    var taskController = TextEditingController(
        text: state.taskList?[event.selectedIndex]["task"]);
    var descriptionController = TextEditingController(
        text: state.taskList?[event.selectedIndex]["description"]);
    emit(state.copyWith(
        selectedTaskIndex: event.selectedIndex,
        dateController: dateController,
        taskController: taskController,
        descriptionController: descriptionController));

    // Implement your logic here
  }

  bool validateFields(Emitter<HomeState> emit) {
    String dateFieldValidation = _dateValidation;
    String descriptionValidation = _descriptionValidation;
    String taskValidation = _taskValidation;

    if (taskValidation.isEmpty && state.isEdit != true) {
      Map<String, dynamic>? duplicateTask = (state.taskList ?? [])
          .firstWhereOrNull((ele) => ele["task"] == state.taskController?.text);
      taskValidation =
          duplicateTask != null ? "Task is already exist" : taskValidation;
    }
    emit(state.copyWith(
        descriptionError: descriptionValidation,
        dateFieldError: dateFieldValidation,
        taskFieldError: taskValidation));
    if (state.dateFieldError?.isEmpty == true &&
        state.descriptionError?.isEmpty == true &&
        state.taskFieldError?.isEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  String get _dateValidation {
    String? error = Validators().validateText(state.dateController?.text ?? '');
    return error ?? '';
  }

  String get _descriptionValidation {
    String? error =
        Validators().validateText(state.descriptionController?.text ?? "");
    return error ?? '';
  }

  String get _taskValidation {
    String? error = Validators().validateText(state.taskController?.text ?? "");
    return error ?? '';
  }
}
