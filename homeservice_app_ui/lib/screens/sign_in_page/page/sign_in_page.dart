import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/screens/forgot_password/page/forgot_password_page.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_state.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/widget/sign_in_content.dart';
import 'package:homeservice_app_ui/screens/sign_up_page/page/sign_up_page.dart';
import 'package:homeservice_app_ui/screens/tab_bar/pages/tab_bar_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SignInBloc> _buildBody(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (BuildContext context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        buildWhen: (_, currState) => currState is SignInInitial,
        builder: (context, state) {
          return const SignInContent();
        },
        listenWhen: (_, currState) =>
            currState is NextForgotPasswordPageState ||
            currState is NextSignUpPageState ||
            currState is NextTabBarState,
        listener: (context, state) {
          if (state is NextForgotPasswordPageState) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
          } else if (state is NextSignUpPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SignUpPage()));
          } else if (state is NextTabBarState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const TabBarPage()));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
