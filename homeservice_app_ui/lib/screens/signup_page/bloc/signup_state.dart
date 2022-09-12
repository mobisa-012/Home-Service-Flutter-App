part of 'signup_bloc.dart';
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpButtonEnabledChangedState extends SignUpState {
  final bool isEnabled;

  SignUpButtonEnabledChangedState({required this.isEnabled});
}

class LoadingState extends SignUpState {}

class NextTabBarPageState extends SignUpState {}

class ErrorState extends SignUpState {
  final String message;

  ErrorState ({required this.message});
}

class ShowErrorState extends SignUpState {}

class NextSignInPageState extends SignUpState {}
