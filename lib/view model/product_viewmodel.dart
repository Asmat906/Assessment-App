import 'package:flutter/material.dart';
import 'package:makeup_browser/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _products = [];  

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get products => _products;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();  

    try {
      _products = await _repository.fetchProducts();  
    } catch (e) {
      _errorMessage = 'Error fetching products: $e';
      print('Error in fetchProducts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
