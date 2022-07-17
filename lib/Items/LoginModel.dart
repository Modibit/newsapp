class LoginResponseModel {
  int _success;
  String _message;

  LoginResponseModel(this._success, this._message);

  int get success => _success;

  String get message => _message;
}
