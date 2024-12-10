import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:makeup_browser/data/network/networkApiServices.dart';
import 'package:makeup_browser/res/appUrl.dart';

class ProductRepository {
   NetworkApiServices networkApiService = NetworkApiServices();
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
   
      final response = await http.get(Uri.parse(AppUrls.productUrl));
// final response = await networkApiService.getApi(AppUrls.productUrl);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['products'] != null) {
          return List<Map<String, dynamic>>.from(jsonResponse['products']);
        } else {
          throw Exception('Products not found');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchProducts: $e');
      throw Exception('Error fetching products: $e');
    }
  }
}
