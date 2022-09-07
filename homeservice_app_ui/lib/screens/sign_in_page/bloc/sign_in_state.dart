abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {}

class SignInButtonEnableChangedState extends SignInState {
  final bool isEnabled;

  SignInButtonEnableChangedState({required this.isEnabled});
}

class LoadingState extends SignInState {}

class NextTabBarState extends SignInState {}

class ErrorState extends SignInState {
  final String message;

  ErrorState ({required this.message});
}

class ShowErrorState extends SignInState {} 

class NextForgotPasswordPageState extends SignInState {} 

class NextSignUpPageState extends SignInState {}
