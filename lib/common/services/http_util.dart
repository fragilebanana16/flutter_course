import 'package:dio/dio.dart';
import 'package:flutter_course/global.dart';

class HttpUtil {
  late Dio dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: "http://192.168.0.107:8080/",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: "application/json: charset=utf-8",
        responseType: ResponseType.json);
    dio = Dio(options);
  }

  Map<String, dynamic>? getAuthHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options reqOptions = options ?? Options();
    reqOptions.headers = reqOptions.headers ?? {};

    Map<String, dynamic>? authorization = getAuthHeader();
    if (authorization != null) {
      reqOptions.headers!.addAll(authorization);
    }

    var rep = await dio.post(path,
        data: data, queryParameters: queryParameters, options: reqOptions);

    return rep.data;
  }
}
