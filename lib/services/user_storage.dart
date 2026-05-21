import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class UserStorage {
  static const String _userKey = 'user_data';
  static final storage = FlutterSecureStorage();

  /// Save user
  static Future<void> saveUser(UserModel user,String token) async {
    await storage.write(key: 'token', value: token);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _userKey,
      jsonEncode(user.toJson()),
    );

  }

  /// Get user
  static Future<UserModel?> getUser() async {
    UserModel user;
    String? token = await storage.read(key: 'token');
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_userKey);

    if (data == null) return null;
    user = UserModel.fromJson(jsonDecode(data));
    print("@@@@@@@@@@@@@@@@@@@");
    print(token);
    return user;
  }

  /// Clear user (logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }


  /// Check login
  static Future<bool> isLoggedIn() async {
    return await getUser()!= null;
  }

  // /// Logout
  // static Future<void> clearToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_tokenKey);
  // }

}
