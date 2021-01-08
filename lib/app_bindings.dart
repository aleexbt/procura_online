import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/repositories/orders_repository.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => ChatRepository(), fenix: true);
    Get.lazyPut(() => OrdersRepository(), fenix: true);
    Get.lazyPut(() => ProductRepository(), fenix: true);
    Get.lazyPut(() => VehicleRepository(), fenix: true);

    Get.put(UserController(), permanent: true);
    // Get.put(SearchController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
