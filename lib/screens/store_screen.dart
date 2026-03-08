import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/store_provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("متجر فلكس يمن"),
        centerTitle: true,
        actions: [
          if (storeProvider.isLoading)
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            )
        ],
      ),
      body: storeProvider.products.isEmpty && !storeProvider.isLoading
          ? const Center(child: Text("لا توجد منتجات حالياً، جاري التحديث..."))
          : RefreshIndicator(
              onRefresh: () => storeProvider.fetchProducts(),
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: storeProvider.products.length,
                itemBuilder: (context, i) {
                  final product = storeProvider.products[i];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // كاش الصور هنا
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[900],
                              child: const Center(child: Icon(Icons.image, color: Colors.white24)),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[900],
                              child: const Center(child: Icon(Icons.broken_image, color: Colors.amber)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                product.storeName,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${product.price} ر.ي",
                                    style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 12),
                                        Text(" ${product.rating}", style: const TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
