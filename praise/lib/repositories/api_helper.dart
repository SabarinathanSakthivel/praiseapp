import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import 'environment.dart';

ApiBaseHelper apiHelper = ApiBaseHelper();

class ApiBaseHelper {
  Future<dynamic> commonGet(String subUrl,
      {Map<String, String>? queryParams}) async {
    dynamic response;
    try {
      var url = Uri.parse(baseUrl + subUrl).replace(
        queryParameters: queryParams,
      );
      final result = await http.get(url, headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        //HttpHeaders.authorizationHeader: "${MyApp.user!.token}",
      });
      response = _returnResponse(result);
    } on SocketException catch (e) {
      log(e);
      toast('No internet connection');
    }
    return response;
  }

  Future<dynamic> commonPost(String subUrl,
      {Map<String, dynamic>? requestBody,
      Map<String, String>? queryParams}) async {
    dynamic response;
    try {
      var url = Uri.parse(baseUrl + subUrl);
      final result = await http.post(url,
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            //HttpHeaders.authorizationHeader: "${MyApp.user!.token}",
          },
          body: json.encode(requestBody));
      response = _returnResponse(result);
    } on SocketException catch (e) {
      log(e);
      toast('No internet connection');
    }
    return response;
  }

  Future<dynamic> commonPut(String subUrl,
      {Map<String, dynamic>? requestBody,
      Map<String, String>? queryParams}) async {
    dynamic response;
    try {
      var url = Uri.parse(baseUrl + subUrl);
      final result = await http.put(url,
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
            //HttpHeaders.authorizationHeader: "${MyApp.user!.token}",
          },
          body: json.encode(requestBody));
      response = _returnResponse(result);
    } on SocketException catch (e) {
      log(e);
      toast('No internet connection');
    }
    return response;
  }

  dynamic _returnResponse(http.Response response) {
    dynamic responseJson;
    switch (response.statusCode) {
      case 200:
        responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        responseJson = {'status': 400, 'message': 'Invaild request'};
        return responseJson;
      case 401:
        responseJson = {'status': 401, 'message': 'Unauthorized'};
        return responseJson;
      case 403:
        responseJson = {'status': 403, 'message': 'Forbidden'};
        return responseJson;
      case 404:
        responseJson = {'status': 404, 'message': 'Request not found'};
        return responseJson;
      case 500:
        responseJson = {'status': 500, 'message': 'Internal server error'};
        return responseJson;
      default:
        responseJson = {
          'status': 500,
          'message':
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}'
        };
        return responseJson;
    }
  }
}
