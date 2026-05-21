import 'package:dio/dio.dart';
import 'dio-client.dart';

class AuthService {
  Future<Response> login({
    required String username,
    required String password,
  }) async {
    return await DioClient.dio.post(
      '/auth/login',
      data: {
        "username": username,
        "password": password,
      },
    );
  }

  Future<Response> register({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
  }) async {
    return await DioClient.dio.post(
      '/users/add',
      data: {
          "firstName": firstname,
          "lastName": lastname,
          "username": username,
          "password": password,
          "email": email
      },
    );
  }
}
