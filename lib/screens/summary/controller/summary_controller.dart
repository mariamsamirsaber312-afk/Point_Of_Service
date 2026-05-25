import 'package:get/get.dart';
import 'package:point_of_service/services/firebase_services.dart';
import 'package:point_of_service/services/user_storage.dart';
import '../../pos/model/product_model.dart';

class SummaryController extends GetxController{

  late FirebaseServices service;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxDouble productsPrice =1.0.obs;
  RxDouble subtotal =1.0.obs;
  RxDouble services =1.0.obs;
  RxDouble tax =1.0.obs;
  RxDouble total =1.0.obs;
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
    subtotal.value = 0 ;
    services.value = 0 ;
    tax.value = 0;
    total.value = 0 ;
    for (int i = 0;i< products.length;i++){
      productsPrice.value += products[i].price * products[i].selectedCount;
    }

     subtotal.value = productsPrice.value;
     services.value = subtotal * 0.01;
     tax.value = (subtotal.value + services.value) * 0.11;
     total.value = subtotal.value + services.value + tax.value;

  }

Future<void> initService() async {
  final user = await UserStorage.getUser(); // ✅ استني القيمة

  if (user != null) {
    service = FirebaseServices(user);
    fetchProducts();
  } else {
    throw Exception("User is null");
  }
}


}