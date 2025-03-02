import 'package:equatable/equatable.dart';

class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnclickSignupEvent extends SignupEvent {
  final Function(String)? onFailure;
  OnclickSignupEvent({this.onFailure});
  @override
  List<Object?> get props => [onFailure];
}

class InitializeSignupEvent extends SignupEvent {
  @override
  List<Object?> get props => [];
}

class ClearSignUpDataEvent extends SignupEvent {}
