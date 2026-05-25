import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:point_of_service/constants/figma_size.dart';
import 'package:point_of_service/screens/pos/controller/pos_controller.dart';
import 'package:point_of_service/themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../product_image_slider/view/product_image_slider.dart';

class PosView extends StatelessWidget {
   PosView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(PosController());

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
        
            //[1]pos name ,address and user info
             Padding(
               padding:  EdgeInsets.only(left: 20,right: 20,top: 0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   // Left Side (pos name and address)
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         "Point of service name",
                         style: AppTextStyle.posName(context)
                       ),
        
                       Padding(
                         padding:  EdgeInsets.only(top: 5),
                         child: Row(
                           children: [
                             Icon(Icons.location_on_outlined,size: FigmaSize.font(context, 18),color: AppColor.textPrimary,),
                             Text(
                               "Jl TB Simatupang, Kav 25, Alamanda Tower",
                               style: AppTextStyle.posAddress(context),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
        
                   // Right Side(user image,name and role)
                   Obx(() {
                     if (controller.user.value == null) {
                       return Padding(
                         padding: const EdgeInsets.only(right: 0),
                         child: Row(
                           children: [
                             CircleAvatar(
                               radius: FigmaSize.width(context, 48),
                               backgroundImage: AssetImage("assets/images/2.png"),
                             ),

                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("User Name", style: AppTextStyle.userName(context)),
                                 Text("Role", style: AppTextStyle.userRole(context)),
                               ],
                             ),
                           ],
                         ),
                       );
                     }

                     return  Padding(
                       padding: const EdgeInsets.only(right: 0),
                       child: Row(
                         children: [
                           CircleAvatar(
                             radius: FigmaSize.width(context, 48),
                             backgroundImage: NetworkImage(controller.user.value!.image),
                           ),
                           SizedBox(width: 5,),

                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(controller.user.value!.name, style: AppTextStyle.userName(context)),
                               Text(controller.user.value!.role, style: AppTextStyle.userRole(context)),
                             ],
                           ),
                         ],
                       ),
                     );
                   })

                 ],
               ),
             ),
        
            //[2]search bar and scan button
            Padding(
              padding:  EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
        
                  // Search Field
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: AppInputDecoration.searchTextField(context),
                        style: AppTextStyle.searchTextFieldStyle(context),
                      ),
                    ),
                  ),
        
                  // Scan Button
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.qr_code_scanner),
                        label: Text("Scan"),
                        style: AppButtonStyle.scanBtn(context),
                        ),
                      ),
                  ),
        
                ],
              ),
            ),
        
            //[3]category list
            Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: List.generate(
                          controller.categories.length, (index)
                        {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: controller.isSelected(index) ? AppButtonStyle.categoryBtnSelected(context) : AppButtonStyle.categoryBtn(context),
                                onPressed: (){
                                  controller.selectCategory(index);
                                  controller.fetchProducts();
                                },
                                child: Text(controller.categories[index]),
                              ),
                            );
                            },
                        ),
                      ),
                    ),
                  ),
            ),
            //category item
        
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }


                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemCount: controller.products.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return GestureDetector(
                        onTap: () {
                          controller.showAddSnackbar(product); // called when tapped
                        },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: FigmaSize.width(context, 146),
                          height: FigmaSize.width(context, 197),
                          padding: EdgeInsets.all(12),
                          decoration: AppDecoration.circularImageDecoration(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProductImagesSlider(images: product.images,productId: product.id.toString(),),
                              SizedBox(height: 1),
                              Text(
                                product.title,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.productTitle(context),
                              ),
                              SizedBox(height: 1),
                              Text("Rp ${product.price}",style: AppTextStyle.productPrice(context),),
                              SizedBox(height: 1),
                              Text("${product.stock} Bowls available",style: AppTextStyle.productPrice(context),),
                            ],
                          ),
                        ),
                      ),
                    );
                    },
                );
              })
          ],
        ),
      ),
    );
  }
}
