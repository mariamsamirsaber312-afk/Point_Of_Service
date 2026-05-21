import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:point_of_service/screens/login/model/user_model.dart';
import '../screens/pos/model/product_model.dart';

class FirebaseServices{

  late UserModel user ;
  final CollectionReference _user = FirebaseFirestore.instance.collection("Users");
  late final CollectionReference _collection ;

  FirebaseServices(this.user) {
    _collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.id.toString())
        .collection('products');
  }

  // ================================ // ✅ 3. Add User (Prevent Duplicate) // ================================
  Future<void> addUser(UserModel user) async {

    final query = await _user.doc(user.id.toString()).get();
    if (!query.exists) {
      await _user.doc(user.id.toString()).set(user.toJson());
    } else {
      print("User already exists"); }
  }

// ================================ // ✅ 1. Get All Products // ================================
Future<List<ProductModel>> getProducts() async {
  final snapshot = await _collection.get();
  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    final productData = data['product'];
    return ProductModel.fromJson(productData);
  }).toList();
}

// ================================ // ✅ 2. Get Single Product // ================================
  Future<ProductModel?> getProductById(int id) async {
  final snapshot = await _collection.where("product.id", isEqualTo: id).get();
  if (snapshot.docs.isNotEmpty) {
    final data = snapshot.docs.first.data() as Map<String, dynamic>;
    return ProductModel.fromJson(data['product']); } return null;
}

// ================================ // ✅ 3. Add Product (Prevent Duplicate) // ================================
Future<void> addProduct(ProductModel product) async {
  final query = await _collection.where("product.id", isEqualTo: product.id).get();
  if (query.docs.isEmpty) {
    await _collection.add({ "product": product.toJson(), });
  } else {
    updateProductCont(product, true);
    throw Exception("Product already exists"); }
}

// ================================ // ✅ 4. Update Product selecteCount // ================================
Future<void> updateProductCont(ProductModel product,bool increment) async {
  final query = await _collection.where("product.id", isEqualTo: product.id).get();
  if (query.docs.isNotEmpty) {
    final docId = query.docs.first.id;
    final data = query.docs.first.data() as Map<String, dynamic>;
    final selectedProduct = ProductModel.fromJson(data['product']);
    if (increment){
      await _collection.doc(docId).update({
        "product.selectedCount": selectedProduct.selectedCount += 1,
      });
    }else{
      await _collection.doc(docId).update({
        "product.selectedCount": selectedProduct.selectedCount -= 1,
      });
    }

  } else {
    throw Exception("Product not found"); }
}

// ================================ // ✅ 6. Delete Product // ================================
Future<void> deleteProduct(int id) async {
  final query = await _collection.where("product.id", isEqualTo: id).get();
  if (query.docs.isNotEmpty) {
    final docId = query.docs.first.id;
    await _collection.doc(docId).delete();
  }
}

// ================================ // ✅ 7. Realtime Stream // ================================
Stream<List<ProductModel>> streamProducts() {
  return _collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ProductModel.fromJson(data['product']); }).toList(); });
}


  // Future<void> initService() async {
  //   final user = await UserStorage.getUser(); // ✅ استني القيمة
  //
  //   if (user != null) {
  //     user1 = user ;
  //     addUser(user, user.token);
  //   } else {
  //     throw Exception("User is null");
  //   }
  // }



}