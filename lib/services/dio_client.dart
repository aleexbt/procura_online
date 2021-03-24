import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:procura_online/app_settings.dart';
import 'package:procura_online/utils/app_path.dart';

const _defaultConnectTimeout = 25000;
const _defaultReceiveTimeout = 6000;

Directory dir = Get.find<AppPath>().directory;
// var cacheStore = DbCacheStore(databasePath: dir.path, logStatements: kDebugMode);
//
// final cacheOptions = CacheOptions(
//   store: cacheStore,
//   policy: CachePolicy.cacheStoreNo,
//   hitCacheOnErrorExcept: [401, 403],
//   priority: CachePriority.normal,
//   maxStale: const Duration(days: 1),
// );

class DioClient {
  String token;
  Dio _dio;
  final List<Interceptor> interceptors;

  DioClient({this.token, this.interceptors}) {
    _dio = Dio();
    _dio
      ..options.baseUrl = '$kBaseUrl'
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors);
    }
    // _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    // if (kDebugMode) {
    //   _dio.interceptors.add(LogInterceptor(
    //     responseBody: true,
    //     error: true,
    //     requestHeader: false,
    //     responseHeader: false,
    //     request: false,
    //     requestBody: false,
    //   ));
    // }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
