import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

import 'auth/login_screen.dart';
import 'cart/cart_screen.dart';
import 'product/product_details_screen.dart';
import 'product/product_list_screen.dart';
import 'profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [];
  
  @override
  void initState() {
    super.initState();
    // سيتم تهيئة الشاشات في didChangeDependencies
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // تهيئة الشاشات
    _screens.clear();
    _screens.addAll([
      _buildHomeContent(),
      const ProductListScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر إلكتروني'),
        actions: [
          // زر تبديل الوضع المظلم/الفاتح
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          // زر سلة التسوق مع شارة عدد العناصر
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Text(
              '${cartProvider.itemCount}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2; // الانتقال إلى شاشة سلة التسوق
                });
              },
            ),
          ),
          // زر تسجيل الدخول/الخروج
          IconButton(
            icon: Icon(authProvider.isLoggedIn ? Icons.logout : Icons.login),
            onPressed: () {
              if (authProvider.isLoggedIn) {
                // تسجيل الخروج
                authProvider.logout();
              } else {
                // الانتقال إلى شاشة تسجيل الدخول
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'المنتجات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final products = productProvider.products;
        final categories = productProvider.categories;
        
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // بانر ترحيبي
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'مرحباً بك في متجرنا الإلكتروني',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تسوق أحدث المنتجات بأفضل الأسعار',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 1; // الانتقال إلى شاشة المنتجات
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                          child: const Text('تسوق الآن'),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // الفئات
                Text(
                  'الفئات',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProductListScreen(
                                category: categories[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.category,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                categories[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // المنتجات المميزة
                Text(
                  'منتجات مميزة',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length > 4 ? 4 : products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(productId: product.id),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // صورة المنتج
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 60,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                            // تفاصيل المنتج
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${product.price} ر.س',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // التقييم
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${product.rating}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      // زر إضافة إلى السلة
                                      InkWell(
                                        onTap: () {
                                          Provider.of<CartProvider>(context, listen: false).addItem(
                                            product.id,
                                            product.name,
                                            product.price,
                                            product.image,
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('تمت إضافة ${product.name} إلى السلة'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.add_shopping_cart,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 16),
                
                // زر عرض جميع المنتجات
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1; // الانتقال إلى شاشة المنتجات
                      });
                    },
                    child: const Text('عرض جميع المنتجات'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}