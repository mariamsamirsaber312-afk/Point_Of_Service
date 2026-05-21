import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:point_of_service/screens/home/view/home_view.dart';
import 'package:point_of_service/screens/item_details/view/item_details_view.dart';
import 'package:point_of_service/screens/login/view/login_view.dart';
import 'package:point_of_service/screens/payment_method/view/payment_method_view.dart';
import 'package:point_of_service/screens/pos/view/pos_view.dart';
import 'package:point_of_service/screens/register/view/register_view.dart';
import 'package:point_of_service/screens/splash/view/splash_view.dart';

class AppRoutes{
  static List<GetPage> routes = [
    GetPage(name: '/splash', page: () =>  SplashView()),
    GetPage(name: '/login', page: () =>  LoginView()),
    GetPage(name: '/register', page: ()=>RegisterView()),
    GetPage(name: '/home', page: () =>  HomeView()),
    GetPage(name: '/pos', page: () =>  PosView()),
    GetPage(name: '/payment',page: () => PaymentMethodView()),
  ];
}