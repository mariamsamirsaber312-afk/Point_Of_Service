import 'package:flutter/material.dart';
import 'package:point_of_service/screens/pos/model/product_model.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';
import '../../product_image_slider/view/product_image_slider.dart';
import '../../product_image_slider/view/product_image_slider.dart';

class ItemDetailsView extends StatelessWidget {
  final ProductModel item;
  const ItemDetailsView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.paymentViewBG,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 70),
            child: Column(
              children: [
                //[1]order number
                Text('Orders #34562',style: AppTextStyle.paymentMethodTitle(context),),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [

                      //itemImage
                      ProductImagesSlider(images: item.images,productId: item.id.toString(),),

                      //item name and price
                      Column(
                        children: [
                          Text("Spicy seasoned seafood noodles",style: AppTextStyle.productTitle(context),),
                          Text("Rp 20.000",style: AppTextStyle.productPrice(context),)
                        ],
                      ),
                      //three button - count +
                      IconButton(onPressed: (){}, icon: Icon(Icons.minimize_rounded,color: AppColor.posAddress,),style: AppButtonStyle.plus_minus(context),),
                      ElevatedButton(onPressed: (){}, child: Text('1',style: AppTextStyle.productPrice(context),),style: AppButtonStyle.plus_minus(context),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add,color: AppColor.posAddress,),style: AppButtonStyle.plus_minus(context),)
                    ]
                  ),
                ),
                
                //total price
                Text('20.0',textAlign: TextAlign.end,style: AppTextStyle.productTitle(context),),

                Row(
                  children: [
                    Text('Jangan pakai Micin',style: AppTextStyle.productPrice(context),),IconButton(onPressed: (){}, icon: Icon(Icons.delete_outlined,color: Colors.red,))
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
