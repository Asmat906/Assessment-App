import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:makeup_browser/data/appException.dart';
import 'package:makeup_browser/data/network/baseApiServices.dart';


class NetworkApiServices extends BaseApiServices {
  // Get API Method......
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url)),
      
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    }
    return jsonResponse;
  }

 
  dynamic returnResponse(http.Response response) {
   

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return "";
      case 302:
        throw UnAuthorizedExceptions("you have no mobile data ");
      case 400:
        throw BadRequestExceptions(
            jsonDecode(response.body)["message"].toString());
      case 401:
        throw UnAuthorizedExceptions(
            jsonDecode(response.body)["message"].toString());
      case 404:
        throw NotFoundExceptions(
            jsonDecode(response.body)["message"].toString());
      case 409:
        throw ConflictingExceptions(
            jsonDecode(response.body)["message"].toString());
      case 429:
        throw TooManyRequestsExceptions(response.body);
      case 500:
        throw ServerExceptions(jsonDecode(response.body)["message"].toString());
      case 503:
        throw ServiceUnavaibleExceptions(
            jsonDecode(response.body)["message"].toString());
      case 504:
        throw TimeoutExceptions(
            jsonDecode(response.body)["message"].toString());
      default:
        throw FatchDataExceptions(
            "Please check your internet connection : ${response.statusCode}");
    }
  }

  dynamic returnFormResponse(http.StreamedResponse response) async {

    switch (response.statusCode) {
      case 200:
        dynamic responseJson =
            jsonDecode(await response.stream.bytesToString());
        return responseJson;

      case 201:
        dynamic responseJson =
            jsonDecode(await response.stream.bytesToString());
        return responseJson;

      case 204:
        return "";
      case 302:
        throw UnAuthorizedExceptions("you have no mobile data ");

      case 400:
        var data = jsonDecode(await response.stream.bytesToString());
        throw BadRequestExceptions(data['message']);

      case 401:
        var data = jsonDecode(await response.stream.bytesToString());
        throw UnAuthorizedExceptions(data['message']);

      case 404:
        var data = jsonDecode(await response.stream.bytesToString());
        throw NotFoundExceptions(data['message']);

      case 409:
        var data = jsonDecode(await response.stream.bytesToString());
        throw ConflictingExceptions(data['message']);
      case 429:
        var data = jsonDecode(await response.stream.bytesToString());
        throw TooManyRequestsExceptions(data['message']);

      case 500:
        var data = jsonDecode(await response.stream.bytesToString());
        throw ServerExceptions(data['message']);

      case 503:
        var data = jsonDecode(await response.stream.bytesToString());
        throw ServiceUnavaibleExceptions(data['message']);

      case 504:
        var data = jsonDecode(await response.stream.bytesToString());
        throw TimeoutExceptions(data['message']);

      default:
        throw FatchDataExceptions(
            "Error Occurred While Communication With Server with Status Code ${response.statusCode}");
    }
  }
}
