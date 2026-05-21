import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/services/product_service.dart';
import '../../../services/firebase_services.dart';
import '../../../services/user_storage.dart';
import '../../login/model/user_model.dart';
import '../model/product_model.dart';



class PosController extends GetxController{

   late FirebaseServices service ;

  RxList<String> categories = <String>[].obs;
  RxInt selectedIndex = 0.obs;

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  var errorMessage = ''.obs;


  final ProductService _service = ProductService();
  Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    fetchProducts();
    loadUserData();
  }

  void loadCategories() {
    categories.value = [
      "all",
      "beauty",
      "furniture",
      "groceries",
    ];
  }

  Future<void> loadUserData() async {
    user.value = await UserStorage.getUser();
    if (user.value != null) {
      service = FirebaseServices(user.value!);
    }
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
  }

  bool isSelected(int index) {
    return selectedIndex.value == index;
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await _service.fetchProducts(categories[selectedIndex.value]);
      products.value = result;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void showAddSnackbar(ProductModel product) {
    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 5),

      titleText: const Text(
        "Are you sure to add this item to payment list ?",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),


        mainButton: TextButton(
            onPressed: () {},
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // add logic
                      // addItemToFirebase(product);
                      service.addProduct(product);
                    },
                    child: const Text("Add"),
                  ),
                ]
            )
        )
    );
  }

  //add item to shopping cart
  // Future<void> addItemToFirebase(ProductModel product) async {
  //   final collection = FirebaseFirestore.instance.collection("products");
  //
  //   // 1️⃣ تحقق لو المنتج موجود بالفعل
  //   final querySnapshot = await collection
  //       .where("product.id", isEqualTo: product.id)
  //       .get();
  //
  //   if (querySnapshot.docs.isNotEmpty) {
  //     // المنتج موجود بالفعل
  //     print("Product already exists in Firestore");
  //
  //     service.updateProductCont(product, true);
  //     return;
  //   }
  //   service.addProduct(product);
  // }
}