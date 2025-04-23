import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';

// فئة Product مستوردة بالفعل من ملف product_provider

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  
  const ProductDetailsScreen({super.key, this.productId = ''});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.products.firstWhere(
      (product) => product.id == productId,
      orElse: () => Product(
        id: '',
        name: AppLocalizations.of(context)!.productNotFound,
        description: AppLocalizations.of(context)!.productNotFound,
        price: 0,
        image: '',
        categories: [],
      ),
    );

    if (product.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.productDetails),
        ),
        body: Center(
          child: Text(AppLocalizations.of(context)!.productNotFound),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // اسم المنتج والسعر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${product.price} ${Localizations.localeOf(context).languageCode == 'ar' ? 'ر.س' : 'SAR'}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // التقييم
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${product.reviewCount} ${AppLocalizations.of(context)!.review})',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // وصف المنتج
              Text(
                AppLocalizations.of(context)!.description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              
              const SizedBox(height: 24),
              
              // الفئات
              Text(
                AppLocalizations.of(context)!.categories,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: product.categories.map((category) {
                  return Chip(
                    label: Text(category),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).addItem(
              product.id,
              product.name,
              product.price,
              product.image,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.addedToCart(product.name)
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.addToCart,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}