import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("متجر فلكس الجديد"),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: "الكل"), Tab(text: "متاجر"), Tab(text: "منتجات")],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          Center(child: Text("بداية جديدة ونظيفة 🚀")),
          Center(child: Text("قائمة المتاجر")),
          Center(child: Text("قائمة المنتجات")),
        ],
      ),
    );
  }
}
