import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class StoreProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client;
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  // الدالة التي سيتم استدعاؤها عند تشغيل التطبيق
  Future<void> initConnection() async {
    // الانتظار لمدة 10 ثوانٍ قبل بدء الاتصال
    await Future.delayed(const Duration(seconds: 10));
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _supabase.from('products').select();
      _products = (data as List).map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      debugPrint("خطأ في جلب البيانات: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
