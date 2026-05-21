import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:point_of_service/services/dio-client.dart';
import '../screens/pos/model/product_model.dart';


class ProductService {

  

  Future<List<ProductModel>> fetchProducts(String category) async {

    final response =
    await DioClient.dio.get('/products');

    if (response.statusCode == 200) {

      final response = category == "all" ? await DioClient.dio.get('/products') : await DioClient.dio.get('/products/category/$category');

      final List productsList = response.data['products'];

      return productsList
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

    } else {
      throw Exception("Failed to load products");
    }
  }
}