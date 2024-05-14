class SignInState {
  final String userName;
  final String password;

  const SignInState({this.userName = "", this.password = ""});

  SignInState copyWith({String? userName, String? password}) {
    return SignInState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}
