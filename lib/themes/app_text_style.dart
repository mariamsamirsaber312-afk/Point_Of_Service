import 'package:flutter/material.dart';
import 'app_color.dart';
import 'package:point_of_service/constants/figma_size.dart';


class AppTextStyle{
  //  Headlines
  static TextStyle headlineLarge(BuildContext context) {
    return customText(context, size: 48, color: AppColor.textSecondary, fontWeight: FontWeight.w600);
  }
  static TextStyle textFieldStyle(BuildContext context) {
    return customText(context, size: 34, color: AppColor.textField,fontWeight: FontWeight.w400);
  }
  static TextStyle searchTextFieldStyle(BuildContext context) {
    return customText(context, size: 24, color: AppColor.searchTextField,fontWeight: FontWeight.w400);
  }

  static TextStyle splash(
      BuildContext context, {
        FontWeight fontWeight = FontWeight.w400,
      }) {
    return customText(
      context,
      size: 64,
      color: AppColor.textSecondary,
      fontWeight: fontWeight,
    );
  }

  static TextStyle loginHelloWorld(BuildContext context) {
    return customText(context, size: 30, color: AppColor.textPrimary,fontWeight: FontWeight.w700);
  }
  static TextStyle loginWelcomeLine(BuildContext context) {
    return customText(context, size: 24, color: AppColor.textPrimary);
  }
  static TextStyle loginBtn(BuildContext context) {
    return customText(context, size: 24, color: AppColor.textSecondary);
  }
  //Home 
  static TextStyle homeLogo(BuildContext context) {
    return customText(context, size: 32, color: AppColor.textSecondary,fontWeight: FontWeight.w700);
  }
  static TextStyle sideBarText(BuildContext context,FontWeight fontWeight) {
    return customText(context, size: 15, color: AppColor.textSecondary,fontWeight: fontWeight);
  }
  //pos
  static TextStyle posName(BuildContext context){
    return customText(context, size: 20, color: AppColor.textPrimary,fontWeight: FontWeight.w700);
  }
  static TextStyle posAddress(BuildContext context){
    return customText(context, size: 18, color: AppColor.posAddress,fontWeight: FontWeight.w400);
  }
  static TextStyle userName(BuildContext context){
    return customText(context, size: 20, color: AppColor.posAddress,fontWeight: FontWeight.w700);
  }
  static TextStyle  userRole(BuildContext context){
    return customText(context, size: 15, color: AppColor.posAddress,fontWeight: FontWeight.w400);
  }

  static TextStyle  productTitle(BuildContext context){
    return customText(context, size: 14, color: AppColor.posAddress,fontWeight: FontWeight.w500);
  }
  static TextStyle  productPrice(BuildContext context){
    return customText(context, size: 14, color: AppColor.posAddress,fontWeight: FontWeight.w400);
  }
  static TextStyle  paymentMethodTitle(BuildContext context){
    return customText(context, size: 20, color: AppColor.posAddress,fontWeight: FontWeight.w700);
  }
  static TextStyle  totalCount(BuildContext context){
    return customText(context, size: 24, color: AppColor.posAddress,fontWeight: FontWeight.w700);
  }
  static TextStyle  cashAndChange(BuildContext context){
    return customText(context, size: 15, color: AppColor.posAddress,fontWeight: FontWeight.w700);
  }

  static TextStyle customText(
      BuildContext context, {
        required double size,
        required Color color,
        FontWeight fontWeight = FontWeight.w400,
        double? height,                             //line height
      }) {
    return TextStyle(
      fontSize: FigmaSize.font(context, size),
      color: color,
      fontWeight: fontWeight,
      height: height
    );
  }

}

class AppInputDecoration {
  static InputDecoration loginTextField(BuildContext context,String hint,IconData? icon){
    return textField(context: context, hint: hint,icon: icon,borderRadius: 10);
  }
  static InputDecoration searchTextField(BuildContext context){
    return textField(context: context, hint: "Search ...",icon: Icons.search,fillColor: AppColor.searchBarBG,borderRadius: 10);
  }
  static InputDecoration cashAndChange(BuildContext context,String hint){
    return textField(context: context, hint: hint,fillColor: AppColor.paymentViewBG,borderRadius: 8);
  }
  static InputDecoration textField({
    required BuildContext context,
    required String hint,
    IconData? icon,
    IconData? suffixIcon,
    Color? fillColor = null,
    double? borderRadius = 0,
  }) {
    return InputDecoration(
      filled: fillColor !=null ?true:false,
      fillColor: fillColor !=null? fillColor:null,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius!),borderSide: BorderSide.none),
      prefixIcon: icon != null ? Icon(icon,size: FigmaSize.font(context, 24),) : null,

      hintStyle: TextStyle(
        // fontSize: FigmaSize.font(context, 34),
        color: AppColor.textField,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
        // prefixIconConstraints: BoxConstraints(
        //   minWidth: 40,
        //   minHeight: 40,
        // ),

        contentPadding: EdgeInsets.symmetric(vertical: 18),

      suffixIcon: suffixIcon != null
          ? Icon(
        suffixIcon,
        size: FigmaSize.font(context, 24),
      )
          : null,

    );
  }
}

class AppButtonStyle {
  static ButtonStyle loginBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.primaryBG,borderRadius: 16,size: Size(double.infinity,FigmaSize.width(context, 57)));
  }
  static ButtonStyle scanBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.searchBarBG,textColor: AppColor.textPrimary,borderColor: AppColor.primaryBG,borderRadius: 10,size: Size(100,50));
  }
  static ButtonStyle menuBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.secondaryBG,textColor: AppColor.posAddress,borderColor: AppColor.primaryBG,borderRadius: 5,size: Size(110,31));
  }
  static ButtonStyle menuBtnSelected(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.primaryBG,textColor: AppColor.textSecondary,borderColor: AppColor.primaryBG,borderRadius: 5,size: Size(110,31));
  }
  static ButtonStyle categoryBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.secondaryBG,textColor: AppColor.posAddress,borderColor: AppColor.posAddress,borderRadius: 5,size: Size(110,40));
  }
  static ButtonStyle categoryBtnSelected(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.primaryBG,textColor: AppColor.textSecondary,borderColor: AppColor.primaryBG,borderRadius: 5,size: Size(110,40));
  }
  static ButtonStyle keyBoardNumberBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.paymentViewBG,textColor: AppColor.posAddress,borderColor: AppColor.keyboardBtnBorder,borderRadius: 0,size: Size(95,64));
  }
  static ButtonStyle keyBoardSymbolBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.primaryBG,textColor: Colors.white,borderColor: AppColor.keyboardBtnBorder,borderRadius: 0,size: Size(95,64));
  }
  static ButtonStyle keyBoardEmptyBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.paymentViewBG,textColor: AppColor.posAddress,borderColor: Colors.transparent,borderRadius: 0,size: Size(95,64));
  }
  static ButtonStyle payBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.primaryBG,borderRadius: 16,size: Size(double.infinity,80));
  }
  static ButtonStyle plus_minus(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.secondaryBG,borderRadius: 5,size: Size(37,32),padding: EdgeInsets.zero);
  }
  static ButtonStyle deleteBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.secondaryBG,borderRadius: 5,size: Size(50,50),padding: EdgeInsets.zero,textColor: Colors.red);
  }
  static ButtonStyle checkoutBtn(BuildContext context ){
    return elevatedButton(context,bgColor: AppColor.primaryBG,borderRadius: 8,size: Size(double.infinity, 50),padding: EdgeInsets.zero,textColor: AppColor.textSecondary);
  }

  static ButtonStyle elevatedButton
      (
      BuildContext context,
      {
        Color? bgColor,
        Color? textColor,
        Color? borderColor,
        double? borderRadius = 16,
        required Size size,
        EdgeInsetsGeometry? padding
  })
  {
    return ElevatedButton.styleFrom(
      padding: padding,
      backgroundColor: bgColor,
      foregroundColor: textColor,
      minimumSize: Size(
        FigmaSize.width(context, size.width),
        FigmaSize.width(context, size.height),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius!,),
        side: BorderSide(color: borderColor ?? Colors.transparent,width: 1),
      ),
      elevation: 0,

    );
  }
}

class AppDecoration{
  static BoxDecoration circularImageDecoration(BuildContext context,
  {
    double radius = 30
  }
      ){
    return BoxDecoration
      (
      borderRadius: BorderRadius.circular(20),
      shape: BoxShape.rectangle,
      color: AppColor.secondaryBG,
      boxShadow: [BoxShadow(
        color: Colors.grey,
      blurRadius: 5,
      offset: Offset(4, 4)
    )]


    );

}
}