abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpInitialEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  const SignUpInitialEvent(this.name, this.email, this.password);
}
