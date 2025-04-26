import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int reviewCount;
  final List<String> categories;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.categories,
    this.isFavorite = false,
  });
}

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Product> _favorites = [];
  List<String> _categories = [];
  bool _isSearchActive = false;

  List<Product> get products => _isSearchActive ? _filteredProducts : _products;
  List<Product> get favorites => _favorites;
  List<String> get categories => _categories;
  
  // البحث عن المنتجات
  void searchProducts(String query) {
    if (query.isEmpty) {
      resetSearch();
      return;
    }
    
    _isSearchActive = true;
    _filteredProducts = _products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
             product.description.toLowerCase().contains(query.toLowerCase()) ||
             product.categories.any((category) => category.toLowerCase().contains(query.toLowerCase()));
    }).toList();
    
    notifyListeners();
  }
  
  // إعادة تعيين البحث
  void resetSearch() {
    _isSearchActive = false;
    _filteredProducts = [];
    notifyListeners();
  }

  ProductProvider() {
    _loadProducts();
  }

  // تحميل المنتجات (في تطبيق حقيقي، سيتم جلب البيانات من API)
  void _loadProducts() {
    // بيانات تجريبية للمنتجات
    _products = [
      Product(
        id: '1',
        name: 'هاتف ذكي',
        description: 'هاتف ذكي بمواصفات عالية وكاميرا متطورة',
        price: 999.99,
        image: 'assets/images/placeholder.svg',
        rating: 4.5,
        reviewCount: 120,
        categories: ['إلكترونيات', 'هواتف'],
      ),
      Product(
        id: '2',
        name: 'حاسوب محمول',
        description: 'حاسوب محمول خفيف الوزن مع أداء قوي',
        price: 1299.99,
        image: 'assets/images/placeholder.svg',
        rating: 4.8,
        reviewCount: 85,
        categories: ['إلكترونيات', 'حواسيب'],
      ),
      Product(
        id: '3',
        name: 'سماعات لاسلكية',
        description: 'سماعات لاسلكية بجودة صوت عالية وعزل للضوضاء',
        price: 199.99,
        image: 'assets/images/placeholder.svg',
        rating: 4.2,
        reviewCount: 65,
        categories: ['إلكترونيات', 'صوتيات'],
      ),
      Product(
        id: '4',
        name: 'ساعة ذكية',
        description: 'ساعة ذكية لتتبع النشاط البدني والإشعارات',
        price: 249.99,
        image: 'assets/images/placeholder.svg',
        rating: 4.0,
        reviewCount: 42,
        categories: ['إلكترونيات', 'ساعات'],
      ),
      Product(
        id: '5',
        name: 'كاميرا رقمية',
        description: 'كاميرا رقمية احترافية لالتقاط صور عالية الدقة',
        price: 699.99,
        image: 'assets/images/placeholder.svg',
        rating: 4.7,
        reviewCount: 38,
        categories: ['إلكترونيات', 'كاميرات'],
      ),
    ];

    // استخراج الفئات الفريدة
    Set<String> uniqueCategories = {};
    for (var product in _products) {
      uniqueCategories.addAll(product.categories);
    }
    _categories = uniqueCategories.toList();

    notifyListeners();
  }

  // البحث عن منتج بواسطة المعرف
  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  // تصفية المنتجات حسب الفئة
  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.categories.contains(category)).toList();
  }

  // إضافة منتج إلى المفضلة أو إزالته منها
  void toggleFavorite(String productId) {
    final productIndex = _products.indexWhere((product) => product.id == productId);
    if (productIndex >= 0) {
      final product = _products[productIndex];
      final isFavorite = !product.isFavorite;
      final updatedProduct = Product(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        image: product.image,
        rating: product.rating,
        reviewCount: product.reviewCount,
        categories: product.categories,
        isFavorite: isFavorite,
      );
      _products[productIndex] = updatedProduct;

      if (isFavorite) {
        _favorites.add(updatedProduct);
      } else {
        _favorites.removeWhere((item) => item.id == productId);
      }

      notifyListeners();
    }
  }

  // تم إزالة دالة البحث المكررة هنا
}