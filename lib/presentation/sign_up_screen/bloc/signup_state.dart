import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupState extends Equatable {
  final TextEditingController? emailController;
  final TextEditingController? passController;
  final TextEditingController? usernameController;
  final String? emailError;
  final String? passwordError;
  final UserCredential? userData;
  final String? errorMessage;

  const SignupState(
      {this.emailController,
      this.passController,
      this.usernameController,
      this.emailError,
      this.passwordError,
      this.userData,
      this.errorMessage});

  @override
  List<Object?> get props => [
        emailController,
        passController,
        usernameController,
        emailError,
        passwordError,
        userData,
        errorMessage,
      ];

  SignupState copyWith(
      {TextEditingController? emailController,
      TextEditingController? passwordController,
      TextEditingController? usernameController,
      String? emailError,
      String? passwordError,
      UserCredential? userData,
      String? error}) {
    return SignupState(
        emailController: emailController ?? this.emailController,
        passController: passwordController ?? passController,
        usernameController: usernameController ?? this.usernameController,
        emailError: emailError ?? this.emailError,
        passwordError: passwordError ?? this.emailError,
        userData: userData ?? this.userData,
        errorMessage: error ?? errorMessage);
  }
}
