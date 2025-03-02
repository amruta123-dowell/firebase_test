part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetAllTaskEvent extends HomeEvent {}

class HomeAddTaskEvent extends HomeEvent {
  final Function(String)? onAddSuccess;
  final Function(String)? onAddFailure;
  const HomeAddTaskEvent({this.onAddFailure, this.onAddSuccess});
}

class HomeEditTaskEvent extends HomeEvent {
  final Function(String)? onEditSuccess;
  final Function(String)? onEditFailure;

  const HomeEditTaskEvent({this.onEditSuccess, this.onEditFailure});
}

class HomeDeleteTaskEvent extends HomeEvent {
  final Function(String)? onDeleteSuccess;
  final Function(String)? onDeleteFailure;

  const HomeDeleteTaskEvent({this.onDeleteSuccess, this.onDeleteFailure});
}

class HomeInitialEvent extends HomeEvent {}

class ClearDataEvent extends HomeEvent {}

class OnselectedContainerEvent extends HomeEvent {
  final int selectedIndex;
  const OnselectedContainerEvent({required this.selectedIndex});
  @override
  // TODO: implement props
  List<Object> get props => [this.selectedIndex];
}
