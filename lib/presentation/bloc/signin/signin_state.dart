abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {
  final bool isLoading;

  SignInLoadingState({required this.isLoading});
}

class SignInSuccessfulState extends SignInState {}

class SignInFailureState extends SignInState {
  final String errorMessage;

  SignInFailureState(this.errorMessage);
}
