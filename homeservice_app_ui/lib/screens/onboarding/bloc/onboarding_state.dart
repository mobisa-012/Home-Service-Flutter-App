abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class NextScreenState extends OnboardingState {}

class PageChangedState extends OnboardingState {
  final int counter;
  PageChangedState({required this.counter});
}
