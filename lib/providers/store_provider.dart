import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class StoreProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client;
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> initConnection() async {
    await loadFromCache(); // تحميل الكاش أولاً فوراً
    await Future.delayed(const Duration(seconds: 10)); // انتظار 10 ثوانٍ
    await fetchProducts(); // جلب الجديد من الأونلاين
  }

  // حفظ في ذاكرة الهاتف
  Future<void> saveToCache(List data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_products', jsonEncode(data));
  }

  // تحميل من ذاكرة الهاتف
  Future<void> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_products');
    if (cached != null) {
      final List decoded = jsonDecode(cached);
      _products = decoded.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _supabase.from('products').select();
      _products = (data as List).map((json) => Product.fromJson(json)).toList();
      await saveToCache(data); // تحديث الكاش بالبيانات الجديدة
    } catch (e) {
      debugPrint("Offline mode or Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
