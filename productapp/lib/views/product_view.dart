import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: Container(
        color: Colors.pink[100],
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];

           // print("Product ${index + 1}: ${product.title}, Price: ${product.price}");

            return ListTile(
              leading: Image.network(
                product.image ?? '',
                width: 50,
                errorBuilder: (_, __, ___) => const Icon(Icons.image),
              ),
              title: Text(product.title ?? ''),
              subtitle: Text("\$${product.price?.toStringAsFixed(2)}"),
              trailing: Text(
                " ${product.rating?.rate ?? 0} (${product.rating?.count ?? 0})",
              ),
            );
          },
        ),
      ),
    );
  }
}
