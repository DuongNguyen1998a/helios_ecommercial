import 'package:flutter/material.dart';

/// Models
import '../models/sub_category.dart';
import '../models/sale.dart';

/// Pages
import '../pages/main_wrapper_page.dart';
import '../pages/payment_info/payment_info_page.dart';
import '../pages/payment_management/payment_management_detail_page.dart';
import '../pages/payment_management/payment_management_page.dart';
import '../pages/payment_management/payment_method_page.dart';
import '../pages/product/product_detail_page.dart';
import '../pages/product/product_page.dart';
import '../pages/sale_management/sale_management_detail_page.dart';
import '../pages/sale_management/sale_management_page.dart';
import '../pages/setting/setting_page.dart';
import '../pages/about/about_page.dart';
import '../pages/auth/auth_page.dart';
import '../pages/contact/contact_page.dart';
import '../pages/contract_info/contract_info_page.dart';
import '../pages/contract_management/contract_management_page.dart';
import '../pages/help/help_page.dart';

class AppRoutes {
  /// define routes name
  static const String auth = '/auth';
  static const String mainWrapper = '/main';
  static const String product = 'product';
  static const String productDetail = 'product-detail';
  static const String paymentInfo = 'payment-info';
  static const String contractInfo = 'contract-info';
  static const String setting = 'setting';
  static const String contact = 'contact';
  static const String help = 'help';
  static const String about = 'about';
  static const String contractManagement = 'contract-management';
  static const String saleManagement = '/sale-management';
  static const String saleManagementDetail = '/sale-management-detail';
  static const String paymentManagement = 'payment-management';
  static const String paymentManagementDetail = 'payment-management-detail';
  static const String paymentMethod = 'payment-method';

  /// set-up routes to navigate between screens
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
      case mainWrapper:
        return MaterialPageRoute(
          builder: (_) => const MainWrapperPage(),
        );
      case contractManagement:
        return MaterialPageRoute(
          builder: (_) => const ContractManagementPage(),
        );
      // case contractManagementDetail:
      //   return MaterialPageRoute(
      //     builder: (_) => ContractManagementDetailPage(
      //       contract: settings.arguments as Contract,
      //     ),
      //   );
      case saleManagement:
        return MaterialPageRoute(
          builder: (_) => const SaleManagementPage(),
        );
      case saleManagementDetail:
        return MaterialPageRoute(
          builder: (_) =>
              SaleManagementDetailPage(sale: settings.arguments as Sale),
        );
      case productDetail:
        final obj = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(
            productId: obj['productId'],
            productPrice: obj['productPrice'],
            rating: obj['rating'],
            brandId: obj['brandId'],
          ),
        );
      case paymentInfo:
        return MaterialPageRoute(
          builder: (_) => const PaymentInfoPage(),
        );
      case contractInfo:
        return MaterialPageRoute(
          builder: (_) => const ContractInfoPage(),
        );
      case paymentManagement:
        return MaterialPageRoute(
          builder: (_) => const PaymentManagementPage(),
        );
      case paymentManagementDetail:
        return MaterialPageRoute(
          builder: (_) => PaymentManagementDetailPage(
            action: settings.arguments as String,
          ),
        );
      case paymentMethod:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethodPage(),
        );
      case product:
        return MaterialPageRoute(
          builder: (_) =>
              ProductPage(subCategory: settings.arguments as SubCategory),
        );
      case setting:
        return MaterialPageRoute(
          builder: (_) => const SettingPage(),
        );
      case contact:
        return MaterialPageRoute(
          builder: (_) => const ContactPage(),
        );
      case help:
        return MaterialPageRoute(
          builder: (_) => const HelpPage(),
        );
      case about:
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Không tìm thấy trang bạn muốn.'),
            ),
          ),
        );
    }
  }
}
