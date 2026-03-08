import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' hide CarouselController;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: _buildSearchField(),
            backgroundColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildAdsSlider(),
                _buildCategoriesRow(),
                _buildSectionTitle("عروض حصرية 🔥"),
              ],
            ),
          ),
          _buildOffersGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchField() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(12)),
    child: const TextField(textAlign: TextAlign.right, decoration: InputDecoration(hintText: "ابحث عن طلبك...", border: InputBorder.none, icon: Icon(Icons.search, color: Color(0xFFFFD700)))),
  );

  Widget _buildAdsSlider() => CarouselSlider(
    options: CarouselOptions(height: 160, autoPlay: true, enlargeCenterPage: true),
    items: List.generate(5, (i) => Container(margin: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(15)), child: Center(child: Text("إعلان ${i+1}")))),
  );

  Widget _buildCategoriesRow() => SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, i) => Column(children: [
        Container(width: 60, height: 60, margin: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Color(0xFFFFD700), shape: BoxShape.circle), child: const Icon(Icons.category, color: Colors.black)),
        Text("قسم ${i+1}", style: const TextStyle(fontSize: 10))
      ]),
    ),
  );

  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.all(15), child: Align(alignment: Alignment.centerRight, child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))));

  Widget _buildOffersGrid() => SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    delegate: SliverChildBuilderDelegate((context, i) => Card(child: Center(child: Text("عرض $i"))), childCount: 4),
  );
}
