import 'package:equatable/equatable.dart';

class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object?> get props => [];
}

class SubmitSigninEvent extends SigninEvent {
  final Function(String)? onFailure;
  const SubmitSigninEvent({this.onFailure});
  @override
  List<Object?> get props => [onFailure];
}

class SigninInitializeEvent extends SigninEvent {}

class ClearSignInDataEvent extends SigninEvent {}
