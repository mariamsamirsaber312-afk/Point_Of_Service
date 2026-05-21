import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _tokenKey = 'access_token';

  /// Save token
  // static Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_tokenKey, token);
  // }

  /// Get token
  // static Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tokenKey);
  // }

  // /// Check login
  // static Future<bool> isLoggedIn() async {
  //   return await getToken() != null;
  // }
  //
  // /// Logout
  // static Future<void> clearToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_tokenKey);
  // }
}
