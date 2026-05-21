import 'package:get/get.dart';
import 'package:point_of_service/services/firebase_services.dart';
import 'package:point_of_service/services/user_storage.dart';

import '../../pos/model/product_model.dart';

class SummaryController extends GetxController{

  late FirebaseServices service;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxDouble productsPrice =1.0.obs;
  var isLoading = true.obs;
  late RxInt quantity ;

  RxMap<int, int> quantities = <int, int>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initService();

  }


  Future<List<ProductModel>> fetchProducts() async {

    try {

      products.value = await service.getProducts();
      allProductPrice();

      isLoading.value = false;
      return products;
    } catch (e) {
      isLoading.value=false;
      print('Error fetching products: $e');
      return [];
    }
  }

  void increment(ProductModel product) {
    service.updateProductCont(product, true);
    fetchProducts();
  }

  void decrement(ProductModel product) {
    service.updateProductCont(product, false);
    fetchProducts();
  }

  void allProductPrice(){
    productsPrice.value = 0;
    for (int i = 0;i< products.length;i++){
      print(productsPrice.value);
      productsPrice.value += products[i].price * products[i].selectedCount;
    }
    print(productsPrice.value);
  }

Future<void> initService() async {
  final user = await UserStorage.getUser(); // ✅ استني القيمة

  if (user != null) {
    print("JESUS");
    service = FirebaseServices(user);
    fetchProducts();
  } else {
    throw Exception("User is null");
  }
}


}