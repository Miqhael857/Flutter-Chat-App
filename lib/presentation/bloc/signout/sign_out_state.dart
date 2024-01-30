abstract class SignOutState {}

class SignOutInitialState extends SignOutState {}

class SignOutLoadingState extends SignOutState {
  final bool isLoading;

  SignOutLoadingState({required this.isLoading});
}

class SignOutSuccessfulState extends SignOutState {}

class SignOutFailureState extends SignOutState {
  final String errorMessage;

  SignOutFailureState(this.errorMessage);
}
