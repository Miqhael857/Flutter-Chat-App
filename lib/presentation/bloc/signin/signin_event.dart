abstract class SignInEvent {
  const SignInEvent();
}


class SignInInitialEvent extends SignInEvent {
  final String email;
  final String password;

  SignInInitialEvent(this.email, this.password);
}