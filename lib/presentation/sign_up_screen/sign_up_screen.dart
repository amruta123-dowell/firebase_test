import 'package:firebase_test/core/utils/navigator_service.dart';
import 'package:firebase_test/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_routes.dart';
import '../../widgets/snackbar_widget.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/textfield_widget.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_event.dart';
import 'bloc/signup_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignupBloc()..add(InitializeSignupEvent());
      },
      child: SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create an Account",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFieldWidget(
                  tecController:
                      state.emailController ?? TextEditingController(),
                  title: "Email",
                  errorText: state.emailError,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  tecController:
                      state.passController ?? TextEditingController(),
                  title: "Password",
                  errorText: state.passwordError,
                ),
                const SizedBox(
                  height: 30,
                ),
                SubmitButton(onClickButton: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  context
                      .read<SignupBloc>()
                      .add(OnclickSignupEvent(onFailure: (msg) {
                    showCustomSnackBar(context: context, message: msg);
                  }));
                }),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do you already have an account? "),
                    InkWell(
                        onTap: () {
                          context
                              .read<SignupBloc>()
                              .add(ClearSignUpDataEvent());
                          NavigatorClass().pushNamed(AppRoutes.signInScreen);
                        },
                        child: const Text("Sign in"))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
