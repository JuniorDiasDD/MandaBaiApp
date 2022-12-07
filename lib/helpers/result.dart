class LoginResult {
  late bool success;
  late String? errorMessage;

  LoginResult(this.success, {this.errorMessage});
}

class SetResult extends LoginResult {
  String? verifyCode;
  SetResult(this.success, {this.verifyCode, this.errorMessage}) : super(success, errorMessage: errorMessage);

  @override
  String? errorMessage;

  @override
  bool success;
}