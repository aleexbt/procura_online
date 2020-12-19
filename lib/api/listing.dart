import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:procura_online/models/response_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String baseUrl = 'https://procuraonline-dev.pt/api';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
);

Dio dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());
//Options _cacheOptions = buildCacheOptions(Duration(hours: 3));

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ListingApi {
  static Future<String> getToken() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String _token = await prefs.get('token');
      return _token;
    } catch (err) {
      return null;
    }
  }

  static Future getAll() async {
    String _token = await getToken();
    dio.options.headers["Authorization"] = 'Bearer $_token';
    try {
      Response response = await dio.get(baseUrl + '/v1/listings');
      return ResponseHandler(
        statusCode: response.statusCode,
        hasError: false,
        response: response.data,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return ResponseHandler(
          statusCode: 523,
          hasError: true,
          response: null,
        );
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return ResponseHandler(
          statusCode: 524,
          hasError: true,
          response: null,
        );
      }
      if (e.response.statusCode == 404) {
        return ResponseHandler(
          statusCode: 404,
          hasError: true,
          response: null,
        );
      }
      if (e.response == null) {
        return ResponseHandler(
          statusCode: 502,
          hasError: true,
          response: null,
        );
      } else {
        return ResponseHandler(
          statusCode: e.response.statusCode,
          hasError: true,
          response: e.response.data,
        );
      }
    }
  }

  static Future getOne(String id) async {
    String _token = await getToken();
    dio.options.headers["Authorization"] = 'Bearer $_token';
    try {
      Response response = await dio.get(baseUrl + '/v1/listings/$id');
      return ResponseHandler(
        statusCode: response.statusCode,
        hasError: false,
        response: response.data,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        print('caiu aqui 1');
        return ResponseHandler(
          statusCode: 523,
          hasError: true,
          response: null,
        );
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return ResponseHandler(
          statusCode: 524,
          hasError: true,
          response: null,
        );
      }
      if (e.response.statusCode == 404) {
        return ResponseHandler(
          statusCode: 404,
          hasError: true,
          response: null,
        );
      }
      if (e.response == null) {
        return ResponseHandler(
          statusCode: 502,
          hasError: true,
          response: null,
        );
      } else {
        return ResponseHandler(
          statusCode: e.response.statusCode,
          hasError: true,
          response: e.response.data,
        );
      }
    }
  }
}
