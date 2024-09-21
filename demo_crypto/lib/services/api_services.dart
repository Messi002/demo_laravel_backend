import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:demo_crypto/services/global_response_model.dart';
import 'package:demo_crypto/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retry/retry.dart';

class Method {
  static const get = 'get';
  static const post = 'post';
  static const update = 'update';
  static const delete = 'delete';
}

class ApiClient extends GetxService {
  final SharedPreferences sharedPreferences;
  final Logger logger = Logger(); // Logger instance

  String token = '';
  String tokenType = '';

  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);

    // Check connectivity
    if (await AppUtils.checkConnectivity()) {
      return const ResponseModel(
        isSuccess: false,
        message: "No Internet Connection",
        statusCode: 503,
        responseJson: '',
      );
    }

    http.Response response;

    try {
      // Performing a request with retry logic
      response = await retry(
        () => _makeHttpRequest(
                url, method, params, passHeader, isOnlyAcceptType)
            .timeout(const Duration(seconds: 10)), // Timeout after 10 seconds
        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: 3,
        onRetry: (e) {
          logger.w('Retrying due to: $e');
        },
      );

      // Logging details
      _logRequestDetails(uri, params, response);

      // Handle response based on status code
      return _handleResponse(response);
    } on SocketException {
      return const ResponseModel(
        isSuccess: false,
        message: "No Internet Connection",
        statusCode: 503,
        responseJson: '',
      );
    } on FormatException {
      return const ResponseModel(
        isSuccess: false,
        message: 'Bad Response',
        statusCode: 400,
        responseJson: '',
      );
    } on TimeoutException {
      return const ResponseModel(
        isSuccess: false,
        message: 'Request Timeout',
        statusCode: 408,
        responseJson: '',
      );
    } catch (e) {
      // logger.e('Unhandled exception: $e');
      log('Unhandled exception: $e');
      return const ResponseModel(
        isSuccess: false,
        message: 'Something went wrong',
        statusCode: 499,
        responseJson: '',
      );
    }
  }

  Future<http.Response> _makeHttpRequest(
    Uri url,
    String method,
    Map<String, dynamic>? params,
    bool passHeader,
    bool isOnlyAcceptType,
  ) async {
    final headers = _buildHeaders(passHeader, isOnlyAcceptType);
    switch (method) {
      case Method.post:
        return await http.post(url, body: params, headers: headers);
      case Method.delete:
        return await http.delete(url, headers: headers);
      case Method.update:
        return await http.put(url, body: params, headers: headers);
      case Method.get:
        return await http.get(url, headers: headers);
      //ignore the default part
      default:
        return await http.get(url, headers: headers);
    }
  }

  Map<String, String>? _buildHeaders(bool passHeader, bool isOnlyAcceptType) {
    if (!passHeader) return null;
    if (isOnlyAcceptType) {
      return {"Accept": "application/json"};
    } else {
      return {
        "Accept": "application/json",
        "Authorization": "$tokenType $token",
      };
    }
  }

  ResponseModel _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200 || 204 || 201:
        return _handleSuccessResponse(response);
      case 404 || 401:
        //TODO:navigate to login page
        // Get.offAllNamed(RouteHelper.login);
        return ResponseModel(
          isSuccess: false,
          message: 'Something went wrong',
          statusCode: 404,
          responseJson: response.body,
        );
      case 500:
        return ResponseModel(
          isSuccess: false,
          message: 'Server error',
          statusCode: 500,
          responseJson: response.body,
        );
      default:
        return ResponseModel(
          isSuccess: false,
          message: 'Something went wrong',
          statusCode: response.statusCode,
          responseJson: response.body,
        );
    }
  }

  ResponseModel _handleSuccessResponse(http.Response response) {
    try {
      return ResponseModel(
        isSuccess: true,
        message: 'Success',
        statusCode: 200,
        responseJson: response.body,
      );
    } catch (e) {
      logger.e('Error parsing response: $e');
      return ResponseModel(
        isSuccess: false,
        message: 'Success, but failed to parse response',
        statusCode: 200,
        responseJson: response.body,
      );
    }
  }

  void _logRequestDetails(
      String uri, Map<String, dynamic>? params, http.Response response) {
    // logger.i('----Request Details:----');
    // logger.i('URL: $uri');
    // logger.i('Params: $params');
    // logger.i('Status Code: ${response.statusCode}');
    // logger.i('Response Body: ${response.body}');

    log('----Request Details:----');
    log('URL: $uri');
    log('Params: $params');
    log('Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');
  }
}
