import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../service/api_service.dart';

class ProductController extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();

      // for (var p in _products) {
      //   print("Loaded: ${p.title} - \$${p.price}");
      // }

    } catch (e) {
      debugPrint('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
