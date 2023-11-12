import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/**
 * This manages the session within the app.
 * It should be able to handle the following:
 * * Store the user's access token using local storage
 * * Checks if the user access token is still valid
 * * Retreives user's access token from local storage
 */
class SessionService {
  final _storage = FlutterSecureStorage();
  final KEY_ACCESS_TOKEN = 'accessToken';
  final KEY_REFRESH_TOKEN = 'refreshToken';
  final KEY_EXPIRY_DATE = 'expiryDate';

  // stores given access token using secure storage
  Future<void> storeAccessToken(String accessToken, String refreshToken, DateTime expiryDate) async {
    await _storage.write(key: KEY_ACCESS_TOKEN, value: accessToken);
    await _storage.write(key: KEY_REFRESH_TOKEN, value: refreshToken);
    await _storage.write(key: KEY_EXPIRY_DATE, value: expiryDate.toString());
  }

  // checks if the user's access token is still valid
  Future<bool> isAccessTokenValid() async {
    final expiryDate = await _storage.read(key: 'expiryDate');
    if (expiryDate == null) {
      return false;
    }
    final expiryDateTime = DateTime.parse(expiryDate);
    return expiryDateTime.isAfter(DateTime.now());
  }

  Future<void> exchangeCodeForAccessToken(String s) async {
    await storeAccessToken('accessToken', 'refreshToken', DateTime.now().add(Duration(days: 1)));
  }

  Future<void> resetSession() async {
    await _storage.delete(key: KEY_ACCESS_TOKEN);
    await _storage.delete(key: KEY_REFRESH_TOKEN);
    await _storage.delete(key: KEY_EXPIRY_DATE);
  }
}