import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/repositories/orders_repository.dart';
import 'package:procura_online/screens/auth/user_controller.dart';

class OrdersController extends GetxController {
  OrdersRepository _repository = Get.find();
  UserController _userController = Get.find();

  @override
  onInit() {
    getOrders();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxInt _page = 1.obs;
  Rx<OrdersModel> _orders = OrdersModel().obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  int get page => _page.value;
  OrdersModel get orders => _orders.value;
  int get totalOrders => _orders.value.order?.length ?? 0;
  bool get isLastPage => false;

  void getOrders() async {
    print('getting new orders');
    _isLoading.value = true;
    _hasError.value = false;
    _page.value = 1;
    try {
      OrdersModel orders = await _repository.getOrders(_userController.token, page: _page.value);
      _orders.value = orders;
    } on DioError catch (err) {
      _hasError.value = true;
      print(err);
    } finally {
      _isLoading.value = false;
    }
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _page.value = _page.value + 1;
    OrdersModel orders = await _repository.getOrders(_userController.token, page: _page.value);

    if (orders != null) {
      _orders.update((val) {
        val.order.addAll(orders.order);
      });
    }
    _isLoadingMore.value = false;
  }

  void resetState() {
    _isLoading.value = false;
    _isLoadingMore.value = false;
    _hasError.value = false;
    _page.value = 1;
    _orders.value = OrdersModel();
  }
}
