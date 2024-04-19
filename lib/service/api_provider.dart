import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

enum ApiStatus { ideal, loading, success, failed }

class ApiProvider extends ChangeNotifier {
  ApiStatus? status = ApiStatus.ideal;
  late Dio _dio;
  static ApiProvider instance = ApiProvider();
  ApiProvider() {
    _dio = Dio();
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  Future<dynamic> getRequest(String endpoint) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    try {
      Response response = await _dio.get(
        endpoint,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      return ('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      return (e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return 'Unable to process request';
  }

  Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> requestBody) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    debugPrint('Request : ${json.encode(requestBody)}');
    try {
      Response response = await _dio.post(
        endpoint,
        data: json.encode(requestBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      debugPrint(e.toString());
      return ('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      debugPrint(e.toString());
      return (e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return 'Unable to process request';
  }

  Future<dynamic> putRequest(
      String endpoint, Map<String, dynamic> requestBody) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    debugPrint('Request : ${json.encode(requestBody)}');
    try {
      Response response = await _dio.put(
        endpoint,
        data: json.encode(requestBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      return ('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      return (e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return 'Unable to process request';
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint('API : $endpoint');
    try {
      Response response = await _dio.delete(
        endpoint,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      debugPrint('Response : ${response.data}');

      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      notifyListeners();
      return ('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      return (e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return 'Unable to process request';
  }
}
