import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final items = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة التسوق'),
        actions: [
          if (items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('تفريغ السلة'),
                    content: const Text('هل أنت متأكد من رغبتك في تفريغ سلة التسوق؟'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          cartProvider.clear();
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('تفريغ'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'سلة التسوق فارغة',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أضف بعض المنتجات إلى سلة التسوق',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: const Text('تصفح المنتجات'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // قائمة المنتجات في السلة
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // صورة المنتج
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // تفاصيل المنتج
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${item.price} ر.س',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // التحكم في الكمية
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      cartProvider.decreaseQuantity(item.id);
                                    },
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cartProvider.increaseQuantity(item.id);
                                    },
                                  ),
                                ],
                              ),
                              // زر الحذف
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  cartProvider.removeItem(item.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // ملخص السلة والدفع
                Container(
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
                  child: Column(
                    children: [
                      // إجمالي السلة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'المجموع:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${cartProvider.totalAmount.toStringAsFixed(2)} ر.س',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // زر الدفع
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!authProvider.isLoggedIn) {
                              // إذا لم يكن المستخدم مسجل الدخول، توجيهه إلى شاشة تسجيل الدخول
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('تسجيل الدخول مطلوب'),
                                  content: const Text(
                                      'يرجى تسجيل الدخول للمتابعة إلى الدفع'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text('إلغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text('تسجيل الدخول'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // إظهار رسالة نجاح الطلب (في تطبيق حقيقي، سيتم توجيه المستخدم إلى صفحة الدفع)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('تم تقديم طلبك بنجاح!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              // تفريغ السلة بعد تقديم الطلب
                              cartProvider.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'متابعة الدفع',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}