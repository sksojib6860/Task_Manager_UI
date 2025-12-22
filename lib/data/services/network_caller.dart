import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_managment_app/providers/user_provider.dart';


class NetworkCaller {
  //get request
  static Future<NetworkResponse> getRequest(String uri) async {
    Uri url = Uri.parse(uri);

    _logRequest(uri);

    try {
      Response response = await get(url,headers: {
        "token": UserProvider.accessToken ?? "",
      });

      _logResponse(uri, response: response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedData.data,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "something went wrong $e",
      );
    }
  }

  //post request
  static Future<NetworkResponse> postRequest(
    String uri, {
    Map<String, dynamic>? body,
  }) async {
    Uri url = Uri.parse(uri);

    _logRequest(uri);

    try {
      Response response = await post(
        url,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "token": UserProvider.accessToken ?? "",
        },
      );

      _logResponse(uri, response: response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedData["data"],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "Something went wrong $e",
      );
    }
  }

  //log request
  static _logRequest(String url) {
    debugPrint("Requested url : $url");
  }

  //log response
  static _logResponse(String url, {Response? response}) {
    debugPrint(
      "Requested url : $url \n"
      "StatusCode : ${response?.statusCode}\n"
      "Body : ${response?.body}",
    );
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage,
  });
}
