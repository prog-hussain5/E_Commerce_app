import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // تحميل سلة التسوق من التخزين المحلي
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      _items = decodedData.map((item) => CartItem.fromJson(item)).toList();
      notifyListeners();
    }
  }

  // حفظ سلة التسوق في التخزين المحلي
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = json.encode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartData);
  }

  // إضافة منتج إلى سلة التسوق
  void addItem(String productId, String name, double price, String image) {
    final existingIndex = _items.indexWhere((item) => item.id == productId);

    if (existingIndex >= 0) {
      // إذا كان المنتج موجودًا بالفعل، زيادة الكمية
      _items[existingIndex].quantity += 1;
    } else {
      // إضافة منتج جديد
      _items.add(
        CartItem(
          id: productId,
          name: name,
          price: price,
          image: image,
        ),
      );
    }
    saveCart();
    notifyListeners();
  }

  // إزالة منتج من سلة التسوق
  void removeItem(String productId) {
    _items.removeWhere((item) => item.id == productId);
    saveCart();
    notifyListeners();
  }

  // تقليل كمية منتج
  void decreaseQuantity(String productId) {
    final existingIndex = _items.indexWhere((item) => item.id == productId);

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity -= 1;
      } else {
        _items.removeAt(existingIndex);
      }
      saveCart();
      notifyListeners();
    }
  }

  // زيادة كمية منتج
  void increaseQuantity(String productId) {
    final existingIndex = _items.indexWhere((item) => item.id == productId);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
      saveCart();
      notifyListeners();
    }
  }

  // تفريغ سلة التسوق
  void clear() {
    _items = [];
    saveCart();
    notifyListeners();
  }
}