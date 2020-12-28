import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/user_repository.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(SearchController(), permanent: true);
    Get.put(ProductRepository(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
