abstract class AuthEvent {}

class Login extends AuthEvent {
  String email;
  String password;

  Login({ this.email, this.password });
}

class Logout extends AuthEvent {}
