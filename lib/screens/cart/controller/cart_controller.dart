import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:point_of_service/screens/pos/model/product_model.dart';

class CartController extends GetxController {
  var products = <ProductModel>[].obs;

  void addProduct(ProductModel product) {
    products.add(product);
  }
}