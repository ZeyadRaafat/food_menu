import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reco_genie/views/screens/home.dart';
import 'package:reco_genie/views/screens/login.dart';
import 'package:reco_genie/views/screens/register.dart';

class AppRouter {
  static final List<GetPage> routes =[
    GetPage(name: '/home', page: ()=> HomeScreen()),
    GetPage(name: '/login', page: ()=> LoginScreen()),
    GetPage(name: '/register', page: ()=> SignupScreen()),
  ];
}