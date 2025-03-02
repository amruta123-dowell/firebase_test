part of 'home_bloc.dart';

class HomeState extends Equatable {
  final TextEditingController? taskController;
  final TextEditingController? descriptionController;
  final TextEditingController? dateController; // Add this line
  final String? taskFieldError;
  final String? dateFieldError;
  final String? descriptionError;
  final bool? isEdit;
  final String? date;
  final int? selectedTaskIndex;
  final List<Map<String, dynamic>>? taskList;
  const HomeState(
      {this.isEdit,
      this.taskController,
      this.descriptionController,
      this.taskFieldError,
      this.dateFieldError,
      this.date,
      this.dateController,
      this.taskList,
      this.descriptionError,
      this.selectedTaskIndex});

  HomeState copyWith(
      {TextEditingController? taskController,
      bool? isEdit,
      TextEditingController? descriptionController,
      String? dateFieldError,
      String? taskFieldError,
      String? date,
      TextEditingController? dateController,
      List<Map<String, dynamic>>? taskList,
      String? descriptionError,
      int? selectedTaskIndex}) {
    return HomeState(
        taskController: taskController ?? this.taskController,
        isEdit: isEdit ?? this.isEdit,
        descriptionController:
            descriptionController ?? this.descriptionController,
        dateFieldError: dateFieldError ?? this.dateFieldError,
        taskFieldError: taskFieldError ?? this.taskFieldError,
        date: date ?? this.date,
        dateController: dateController ?? this.dateController,
        taskList: taskList ?? this.taskList,
        descriptionError: descriptionError ?? this.descriptionError,
        selectedTaskIndex: selectedTaskIndex ?? this.selectedTaskIndex);
  }

  @override
  List<Object?> get props => [
        isEdit,
        taskController,
        dateController,
        descriptionController,
        taskFieldError,
        isEdit,
        dateFieldError,
        descriptionError,
        taskList,
        selectedTaskIndex
      ];
}
