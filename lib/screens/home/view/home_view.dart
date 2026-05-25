import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_service/constants/figma_size.dart';
import 'package:point_of_service/screens/home/controller/home_controller.dart';
import 'package:point_of_service/screens/pos/view/pos_view.dart';
import 'package:point_of_service/screens/summary/view/summary_view.dart';
import 'package:point_of_service/themes/app_color.dart';
import 'package:point_of_service/themes/app_text_style.dart';
import '../../summary/controller/summary_controller.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});

   final controller = Get.put(HomeController());
   //list of main screen in right side
   final List<Widget> screens = [PosView(),SummaryView()];

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      appBar: AppBar(backgroundColor: controller.appBarColor,),
        drawer: Drawer(
          width: FigmaSize.width(context, 500),
          child: Container(
            color:  AppColor.primaryBG,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title of sidelist
                 Padding(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Text(
                    'LOGO',
                    style: AppTextStyle.homeLogo(context),

                  ),
                ),
                // POS item (active)
                _buildMenuItem(context,Icons.add_chart_rounded, 'POS', 0),
                // Summary item
                _buildMenuItem(context,Icons.shopping_cart, 'Summary', 1)
              ],
            ),
          ),
        ),
        //----------main page (change depend on side menu choose)
        body:
        // screens[controller.selectedIndex.value]
        IndexedStack(
          index: controller.selectedIndex.value,
          children: screens,
        )
      // ,


    ));
  }


  //method take icon , title , index of side bar item and return list title(content od side bar)
  Widget _buildMenuItem(BuildContext context,IconData icon,String title,int index){

    return Obx(() {

      bool isSelected = controller.selectedIndex.value == index;

      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          height: FigmaSize.width(context, 100),
          decoration: BoxDecoration(
              color: isSelected ? AppColor.selectedBtnBG : Colors.transparent,
              borderRadius: BorderRadius.circular(isSelected ? 10 : 0),
          ),

          child: ListTile(
            leading: Icon(icon, color: AppColor.textSecondary, size: 24,),
            title:  AutoSizeText(
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: isSelected ? AppTextStyle.sideBarText(
                      context, FontWeight.w700) : AppTextStyle.sideBarText(
                      context, FontWeight.w400)
              ),

            onTap: () async{

                if (index == 1) {
                  await Get.find<SummaryController>().fetchProducts();
                }

                controller.selectedIndex.value = index;
                Get.back();
              },
          ),
        ),
      );
    });
  }
}
