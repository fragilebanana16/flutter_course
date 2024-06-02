import 'package:dio/dio.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/global.dart';

class HttpUtil {
  late Dio dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: AppConstants.SERVER_API_URL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: "application/json: charset=utf-8",
        responseType: ResponseType.json);
    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        ErrorEntity errInfo = createErrorEntity(error);
        print(errInfo.toString());
      },
    ));
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

    var rsp = await dio.post(path,
        data: data, queryParameters: queryParameters, options: reqOptions);

    return rsp;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") {
      return "Exception";
    }

    return "Exception code $code, $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "connectionTimeout");
    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "sendTimeout");
    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "receiveTimeout");
    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "badCertificate");
    case DioExceptionType.badResponse:
      return ErrorEntity(code: -1, message: "badResponse");
    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "cancel");
    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "connectionError");
    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "unknown");
  }
}
