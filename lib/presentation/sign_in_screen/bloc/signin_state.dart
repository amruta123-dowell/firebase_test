import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class SigninState extends Equatable {
  final TextEditingController? emailController;
  final TextEditingController? passController;
  final String? emailError;
  final String? passwordError;
  final UserCredential? userData;
  const SigninState(
      {this.emailController,
      this.passController,
      this.emailError,
      this.passwordError,
      this.userData});

  @override
  List<Object?> get props =>
      [emailController, passController, emailError, passwordError, userData];

  SigninState copyWith(
      {TextEditingController? emailController,
      TextEditingController? passController,
      String? emailError,
      String? passwordError,
      UserCredential? userData}) {
    return SigninState(
        emailController: emailController ?? this.emailController,
        passController: passController ?? this.passController,
        emailError: emailError ?? this.emailError,
        passwordError: passwordError ?? this.passwordError,
        userData: userData ?? this.userData);
  }
}
