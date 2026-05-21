import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:point_of_service/constants/figma_size.dart';
import 'package:point_of_service/screens/pos/model/product_model.dart';
import 'package:point_of_service/screens/product_image_slider/view/product_image_slider.dart';
import 'package:point_of_service/screens/summary/controller/summary_controller.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';
import 'package:point_of_service/themes/dotted_line.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SummaryController());
    
    controller.onInit();
    return Scaffold(
      backgroundColor: AppColor.paymentViewBG,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //[1]order number
              Text('Orders #34562',style: AppTextStyle.userName(context),),
              //[2]list view for selected product
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.products.isEmpty) {
                  return Center(child: Text('No products found'));
                }

                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            //[1]row for product details
                            Row(
                              children: [
                                SizedBox(
                                  width: FigmaSize.width(context, 150), height: min(132, 72),
                                    child: ProductImagesSlider(images: product.images, productId: product.id.toString())),
                                Expanded(child: Column(children: [Text(product.title,style: AppTextStyle.productTitle(context),),Text(product.price.toString(),style: AppTextStyle.productPrice(context),)],)),

                                Row(
                                  children: [
                                    buildBtn(context,Icons.remove, () => controller.decrement(product)),

                                    buildQty(context,controller,product),

                                    buildBtn(context,Icons.add, () => controller.increment(product)),
                                  ],
                                )
                              ],
                            ),
                            //[2]total price for product quantity
                            Container(width: double.infinity,padding: const EdgeInsets.only(top: 10),child: Text(("Rp  ${product.price * product.selectedCount}"),style: AppTextStyle.productTitle(context),textAlign: TextAlign.right,)),
                            //[3]row for title and button to delete
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Container(alignment: Alignment.centerLeft,height: FigmaSize.height(context, 50),color: Colors.white,child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Jangan pakai Micin',style: AppTextStyle.productPrice(context),),
                                  ))),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 0),
                                    child: IconButton(onPressed: (){controller.service.deleteProduct(product.id);controller.fetchProducts();}, icon: Icon(Icons.delete_outline),style: AppButtonStyle.deleteBtn(context),),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }),
            ]
          ),
        ),

      ),
      bottomNavigationBar: Obx(() {
            final subtotal = controller.productsPrice.value;
            final service = subtotal * 0.01;
            final tax = (subtotal + service) * 0.11;
            final total = subtotal + service + tax;

            return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColor.paymentViewBG,
                ),
                child: SafeArea(
                    child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRow(context, 'Subtotal', "Rp ${subtotal.toStringAsFixed(2)}"),
                buildRow(context, 'Discount', "0%"),
                buildRow(context, 'Service charge', "Rp ${service.toStringAsFixed(2)}"),
                buildRow(context, 'PPN', "11%"),

                SizedBox(height: 8),
                DashedLine(),
                SizedBox(height: 8),

                buildRow(
                  context,
                  'Total',
                  "Rp ${total.toStringAsFixed(2)}",
                  isTotal: true,
                ),
                ElevatedButton(onPressed: (){Get.offAllNamed('/payment');}, child: Text('Checkout'),style: AppButtonStyle.checkoutBtn(context),),
              ],
                    ))
            );
          }),

    );
  }


  Widget buildBtn(BuildContext context,IconData icon, VoidCallback onTap) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 4),

      child: IconButton(
        style: AppButtonStyle.plus_minus(context),
        icon: Icon(icon, size: 18),
        onPressed: onTap,
      ),
    );
  }

  Widget buildQty(BuildContext context,controller,ProductModel product) {
    return Container(
      width: 40,
      height: 40,
      color: AppColor.secondaryBG,
      alignment: Alignment.center,
      child: Text(
        (product.selectedCount).toString(),
        style: AppTextStyle.productPrice(context),
      ),
    );
  }
  Widget totalPriceDetail(BuildContext context,String title,RxString detail){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title,style: AppTextStyle.productPrice(context),),Obx((){ return Text(detail.value);})],
    );

  }

  Widget buildRow(
      BuildContext context,
      String title,
      String value, {
        bool isTotal = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isTotal
                ? AppTextStyle.productTitle(context)
                : AppTextStyle.productPrice(context),
          ),
          Text(
            value,
            style: isTotal
                ? AppTextStyle.productTitle(context)
                : AppTextStyle.productPrice(context),
          ),
        ],
      ),
    );
  }
}
