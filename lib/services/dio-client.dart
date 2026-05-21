import 'package:dio/dio.dart';

class DioClient {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com', // 🔁 غيره بـ API بتاعك
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
      validateStatus: (status){
        return status! < 500;
      }
    ),
  );
}