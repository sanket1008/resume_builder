import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;


import '../exception.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future callGetApiResponse(
      {required String url,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }

    return responseJson;
  }

  @override
  Future callPostApiResponse(
      {required String url,
      required body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: body,

      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }
    return responseJson;
  }

  @override
  Future callPutApiResponse(
      {required String url,
      required body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) {
    // TODO: implement callPutApiResponse
    throw UnimplementedError();
  }

  @override
  Future callDeleteApiResponse(
      {required String url,
      required body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) {
    // TODO: implement callDeleteApiResponse
    throw UnimplementedError();
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        // AppLogger.logger.d("responseJson: $responseJson");
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
        throw InternalServerError(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code${response.statusCode}');
    }
  }
}
