import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/screens/onboarding/bloc/onboarding_bloc.dart';
import 'package:homeservice_app_ui/screens/onboarding/bloc/onboarding_state.dart';
import 'package:homeservice_app_ui/screens/onboarding/widgets/onboarding_content.dart';
import 'package:homeservice_app_ui/screens/sign_up_page/page/sign_up_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<OnboardingBloc> _buildContext(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (_, currState) => currState is NextScreenState,
        listener: (context, state) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return const SignUpPage();
          }));
        },
        buildWhen: (_, currState) => currState is OnboardingInitial,
        builder: (context, state) {
          return const OnboardingContent();
        },
      ),
    );
  }
}
