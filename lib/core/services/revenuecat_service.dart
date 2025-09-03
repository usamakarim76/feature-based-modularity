import 'dart:io';
import 'package:clean_architecture/core/constants/app_logs.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesService {
  final log = AppLogger(className: 'PurchasesService');

  // final _entitlementID = 'premium';

  final String _appleApiKey = '';
  final String _googleApiKey = '';
  final List<String> _iosIdentifiers = [
    "turnie_premium_yearly",
    "turnie_premium_monthly",
  ];

  final List<String> _androidIdentifiers = [
    'yearly_premium',
    'monthly_premium',
  ];
  late PurchasesConfiguration _configuration;

  Future init({required String userId}) async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);
      if (Platform.isIOS) {
        _configuration = PurchasesConfiguration(_appleApiKey);
      } else {
        _configuration = PurchasesConfiguration(_googleApiKey);
      }
      await Purchases.configure(_configuration);
      await login(userId);
      log.debug("Purchases configured User data: ${await getCustomerInfo()}");
      return this;
    } on Exception {
      rethrow;
    }
  }

  Future<List<StoreProduct>> fetchProducts() async {
    List<String> productIdentifiers = Platform.isIOS
        ? _iosIdentifiers
        : _androidIdentifiers;
    try {
      return await Purchases.getProducts(productIdentifiers);
      // return products;
    } on Exception {
      rethrow;
    }
  }

  Future<CustomerInfo> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } on Exception {
      rethrow;
    }
  }

  Future<PurchaseResult> purchaseProduct(StoreProduct product) async {
    try {
      return await Purchases.purchaseStoreProduct(product);
    } on Exception {
      rethrow;
    }
  }

  Future<CustomerInfo> restorePurchases() async {
    try {
      return await Purchases.restorePurchases();
    } on Exception {
      rethrow;
    }
  }

  Future<LogInResult> login(String userId) async {
    try {
      return await Purchases.logIn(userId);
    } on Exception {
      rethrow;
    }
  }

  Future<CustomerInfo> logout() async {
    try {
      return await Purchases.logOut();
    } on Exception {
      rethrow;
    }
  }
}
