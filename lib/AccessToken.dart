import 'Account.dart';

class AccessToken {
  String _accessToken;
  String _refreshToken;
  Account _account;

  AccessToken(this._accessToken, this._refreshToken, this._account);

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  Account get account => _account;
}