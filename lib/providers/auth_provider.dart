import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';
  String _email = '';
  
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String get email => _email;

  // التحقق من حالة تسجيل الدخول عند بدء التطبيق
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _username = prefs.getString('username') ?? '';
    _email = prefs.getString('email') ?? '';
    notifyListeners();
  }

  // تسجيل الدخول
  Future<bool> login(String email, String password) async {
    // هنا يمكن إضافة التحقق من صحة بيانات تسجيل الدخول مع API
    // هذا مثال بسيط للتوضيح فقط
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _email = email;
      _username = email.split('@')[0]; // استخدام جزء من البريد الإلكتروني كاسم مستخدم مؤقت
      
      // حفظ حالة تسجيل الدخول
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', _username);
      await prefs.setString('email', _email);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  // إنشاء حساب جديد
  Future<bool> register(String username, String email, String password) async {
    // هنا يمكن إضافة التحقق من صحة بيانات التسجيل مع API
    // هذا مثال بسيط للتوضيح فقط
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _username = username;
      _email = email;
      
      // حفظ حالة تسجيل الدخول
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', _username);
      await prefs.setString('email', _email);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  // تسجيل الخروج
  Future<void> logout() async {
    _isLoggedIn = false;
    _username = '';
    _email = '';
    
    // حذف بيانات تسجيل الدخول
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    await prefs.remove('email');
    
    notifyListeners();
  }
}