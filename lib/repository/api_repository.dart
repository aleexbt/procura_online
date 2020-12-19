import 'package:get/get.dart';
import 'package:procura_online/models/listing_model.dart';

class ApiRepository extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://procuraonline-dev.pt';
    httpClient.addRequestModifier((request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
  }

  Future<ListingModel> findAll() async {
    final response = await get<ListingModel>('/api/v1/listings', decoder: (response) {
      return ListingModel.fromJson(response ?? []);
    });

    if (response.hasError) {
      print('REPOSITORY_ERROR: Error getting information from server.');
    }
    return response.body;
  }

  Future<ListingItem> findOne(String productId) async {
    final response = await get<ListingItem>('/api/v1/listings/$productId', decoder: (response) {
      return ListingItem.fromJson(response['data'] ?? null);
    });

    if (response.hasError) {
      print('REPOSITORY_ERROR: Error getting information from server.');
    }
    return response.body;
  }
}
