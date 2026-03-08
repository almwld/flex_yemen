import 'package:flutter/material.dart';

class StoreProvider with ChangeNotifier {
  bool isLoading = false;
  List products = [];
  List categories = ["الكل", "عقارات", "سيارات", "خدمات", "إلكترونيات"];

  void refreshData() {
    isLoading = true;
    notifyListeners();
    // محاكاة جلب البيانات
    Future.delayed(const Duration(seconds: 1), () {
      isLoading = false;
      notifyListeners();
    });
  }
}
