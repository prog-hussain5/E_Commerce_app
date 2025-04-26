import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../auth/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    // إذا لم يكن المستخدم مسجل الدخول، عرض شاشة تسجيل الدخول
    if (!authProvider.isLoggedIn) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'يرجى تسجيل الدخول لعرض الملف الشخصي',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text('تسجيل الدخول'),
            ),
          ],
        ),
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // معلومات المستخدم
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  authProvider.username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  authProvider.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // قائمة الإعدادات
          const Text(
            'الإعدادات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            context,
            icon: Icons.person,
            title: 'تعديل الملف الشخصي',
            onTap: () {
              // تنفيذ إجراء تعديل الملف الشخصي
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('هذه الميزة غير متاحة حاليًا')),
              );
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.lock,
            title: 'تغيير كلمة المرور',
            onTap: () {
              // تنفيذ إجراء تغيير كلمة المرور
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('هذه الميزة غير متاحة حاليًا')),
              );
            },
          ),
          _buildSettingItem(
            context,
            icon: Icons.notifications,
            title: 'إعدادات الإشعارات',
            onTap: () {
              // تنفيذ إجراء إعدادات الإشعارات
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('هذه الميزة غير متاحة حاليًا')),
              );
            },
          ),
          _buildLanguageSelector(context),
          
          const SizedBox(height: 32),
          
          // زر تسجيل الخروج
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // تسجيل الخروج
                authProvider.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('تسجيل الخروج'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingItem(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
  
  Widget _buildLanguageSelector(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.isArabic;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(AppLocalizations.of(context)?.language ?? 'اللغة'),
        subtitle: Text(isArabic ? 'العربية' : 'English'),
        trailing: Switch(
          value: isArabic,
          onChanged: (value) {
            // تبديل اللغة بين العربية والإنجليزية
            languageProvider.setLocale(
              value ? const Locale('ar') : const Locale('en')
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(value ? 'تم تغيير اللغة إلى العربية' : 'Language changed to English')),
            );
          },
        ),
      ),
    );
  }
  }
