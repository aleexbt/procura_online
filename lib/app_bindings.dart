import 'package:get/get.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/repositories/orders_repository.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/screens/auth/user_controller.dart';
import 'package:procura_online/screens/conversations/orders_controller.dart';
import 'package:procura_online/screens/home/home_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserRepository());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => ProductRepository());
    Get.lazyPut(() => OrdersController());
    Get.lazyPut(() => OrdersRepository());
  }
}
