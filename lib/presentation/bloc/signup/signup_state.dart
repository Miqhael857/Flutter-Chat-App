abstract class SignUpState {
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {
  final bool isLoading;

  SignUpLoadingState({required this.isLoading});
}

class SignUpSuccessfulState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String errorMessage;

  SignUpFailureState(this.errorMessage);
}
