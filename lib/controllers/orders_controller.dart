import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/repositories/orders_repository.dart';

class OrdersController extends GetxController {
  OrdersRepository _repository = Get.put(OrdersRepository(), permanent: true);

  @override
  onInit() {
    findAll();
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
  List<Order> filteredOrders;

  void findAll() async {
    _isLoading.value = true;
    _hasError.value = false;
    _page.value = 1;
    try {
      OrdersModel orders = await _repository.findAll(page: _page.value);
      _orders.value = orders;
      filteredOrders = List.from(orders.order);
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
    OrdersModel orders = await _repository.findAll(page: _page.value);

    if (orders != null) {
      _orders.update((val) {
        val.order.addAll(orders.order);
      });
      filteredOrders.addAll(orders.order);
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

  void filterResults(String term) {
    List<Order> filtered =
        filteredOrders.where((order) => order.model.toLowerCase().contains(term.toLowerCase())).toList();
    _orders.value.order = filtered;
    _orders.refresh();
  }
}
