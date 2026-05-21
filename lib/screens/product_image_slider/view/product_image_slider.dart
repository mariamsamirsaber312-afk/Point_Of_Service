import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/constants/figma_size.dart';

import '../controller/product_image_slider_controller.dart';

class ProductImagesSlider extends StatelessWidget {
  final List<String> images;
  final String productId;

  const ProductImagesSlider({
    super.key,
    required this.images,
    required this.productId,
  });


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(
      ProductImageController(),
      tag: productId,
    );

    return Column(
      children: [

        //images
        SizedBox(
            height: min(FigmaSize.width(context, 120),60),
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: controller.changeIndex,
              itemBuilder: (context, index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.contain,
                );
              },
            ),
          ),


         const SizedBox(height: 4),

        /// 🔹 Dots Indicator
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: controller.currentIndex.value == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: controller.currentIndex.value == index
                    ? Colors.black
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )),
      ],
    );
  }
}