import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/add_cart_model.dart';
import '../models/order_detail.dart';
import '../utils/constants.dart';
import '../utils/functions.dart';

class AppServices {
  Dio dio = Dio();
  String baseUrl =
      'https://api.heliostech.vn/api/';

  AppServices() {
    dio = Dio(
      BaseOptions(
        // connectTimeout: 10000,
        // receiveTimeout: 10000,
        baseUrl: baseUrl,
      ),
    );

    /// Logging
    addInterceptors();
  }

  /// Logging function
  addInterceptors() {
    return dio
      ..interceptors.add(
        DioLoggingInterceptor(
          level: Level.body,
          compact: false,
        ),
      );
  }

  Future<Response> fetchHomeBanners() async {
    try {
      final response = await dio.get(
        'productimage/getlistadv',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchHomeBanners()');
      return e.response!;
    }
  }

  Future<Response> fetchHomeProducts() async {
    try {
      final response = await dio.get(
        'product/getlisttopsale',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchHomeProducts()');
      return e.response!;
    }
  }

  Future<Response> fetchMainCategory() async {
    try {
      dio.options.headers = {'page': 1, 'limit': 100};

      final response = await dio.get(
        'productcategory/getproductcategorySearch',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchMainCategory()');
      return e.response!;
    }
  }

  Future<Response> fetchSubCategoryByMainCategoryId(int mainCategoryId) async {
    try {
      dio.options.headers = {'page': 1, 'limit': 100};

      final response = await dio.get(
        'producttype/getproducttypebycateid/$mainCategoryId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchSubCategoryByMainCategoryId()');
      return e.response!;
    }
  }

  Future<Response> fetchProductDetailById(int productId) async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        userId = data['customerID'];
      }

      final response = await dio.get(
        'product/getproducreturn?productID=$productId&customerID=$userId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchProductDetailById()');
      return e.response!;
    }
  }

  Future<Response> fetchProducts(int productTypeId) async {
    try {
      final response = await dio.get(
        'product/getlistwithinfo?productTypeID=$productTypeId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchProducts()');
      return e.response!;
    }
  }

  Future<Response> login(String username, String password) async {
    try {
      final data = json.encode({
        'UserName': username,
        'PassWord': password,
      });
      final response = await dio.post(
        'customer/login',
        data: data,
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service login()');
      return e.response!;
    }
  }

  Future<Response> fetchFavProducts() async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
      }

      dio.options.headers = {'Authorization': token};

      final response = await dio.get(
        'product/getlistfavorite/$userId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchFavProducts()');
      return e.response!;
    }
  }

  Future<Response> addFavoriteProduct(int productId, int brandId) async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
      }

      dio.options.headers = {'Authorization': token};

      final bodyData = json.encode({
        'ProductID': productId,
        'CustomerID': userId,
        'BrandID': brandId,
      });

      final response = await dio.post(
        'favorproduct/change',
        data: bodyData,
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service addFavoriteProduct()');
      return e.response!;
    }
  }

  Future<Response> addToCart(List<AddCartModel> carts) async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
      }

      dio.options.headers = {'Authorization': token};

      final bodyData = json.encode({
        'ShoppingCartCode': userId.toString(),
        'DateOrder': Functions.formatYYYYMMDD(DateTime.now()),
        'CustomerID': userId.toString(),
        'vTotalAmount': 0,
        'TotalAmountv': 0,
        'TotalAmountDiscount': 0,
        'AmountDelivery': 0,
        'TotalAmountDebt': 0,
        'Description': '',
        'Status': 0,
        'UserCreate': userId.toString(),
        'DateCreate': Functions.formatYYYYMMDD(DateTime.now()),
        'UserUpdate': userId.toString(),
        'DateUpdate': Functions.formatYYYYMMDD(DateTime.now()),
        'lstDetail': carts.map((e) => e.toJson()).toList(),
      });

      final response = await dio.post(
        'shoppingcart/create',
        data: bodyData,
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service addToCart()');
      return e.response!;
    }
  }

  Future<Response> fetchCarts() async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
      }

      dio.options.headers = {'Authorization': token};

      final response = await dio.get(
        'shoppingcart/getlist?customerID=$userId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchCarts()');
      return e.response!;
    }
  }

  Future<Response> createOrder(
    List<OrderDetail> orderDetails,
    int shoppingCartId,
    String address,
    int transportMethod,
    String phone,
  ) async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;
      String fullName = '';

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
        fullName = data['customerName'];
      }

      dio.options.headers = {'Authorization': token};

      final bodyData = json.encode({
        'OrderCode': '$userId${Functions.currentStringDateTime()}',
        'DateOrder': Functions.formatYYYYMMDD(DateTime.now()),
        'ShoppingCartID': shoppingCartId,
        'SectionID': 0,
        'DeliveryStaffID': 0,
        'CustomerID': userId,
        'UserReceive': fullName,
        'AddressReceive': address,
        'PhoneReceive': phone,
        'vTotalAmount': 0,
        'TotalAmountv': 0,
        'TotalAmountDiscount': 0,
        'AmountDelivery': 0,
        'TotalAmountDebt': 0,
        'Description': '',
        'Status': 0,
        'UserCreate': userId,
        'DateCreate': Functions.formatYYYYMMDD(DateTime.now()),
        'UserUpdate': userId,
        'DateUpdate': Functions.formatYYYYMMDD(DateTime.now()),
        'FormDelivery': transportMethod,
        'lstDetail': orderDetails.map((e) => e.toJson()).toList(),
      });

      final response = await dio.post(
        'order/create',
        data: bodyData,
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service createOrder()');
      return e.response!;
    }
  }

  Future<Response> fetchSalesByUserId() async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
      }

      dio.options.headers = {'Authorization': token};

      final response = await dio.get(
        'order/getlistwithusernameandetail/$userId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchSalesByUserId()');
      return e.response!;
    }
  }

  Future<Response> fetchContractByUserId() async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      Map<String, dynamic> data = {};
      String token = '';
      int userId = 0;

      if (userInformation != null) {
        data = json.decode(userInformation) as Map<String, dynamic>;
        token = 'Bearer ${data['token'] ?? ''}';
        userId = data['customerID'];
      }

      dio.options.headers = {'Authorization': token};

      final response = await dio.get(
        'contract/getlistwithdetailbyuserid/$userId',
      );

      return response;
    } on DioError catch (e) {
      debugPrint('Error service fetchContractByUserId()');
      return e.response!;
    }
  }

  Future<Response> fetchRegions(int parentId) async {
    try {

      dio.options.headers = {'ParentID': parentId};

      final response = await dio.get(
        'region/getbyparent',
      );
      return response;
    }
    on DioError catch (e) {
      debugPrint('Error service fetchRegions()');
      return e.response!;
    }
  }

  Future<Response> fetchUserApproves(int orderId) async {
    try {

      dio.options.headers = {'orderId': orderId};

      final response = await dio.get(
        'orderapproves/getlist',
      );
      return response;
    }
    on DioError catch (e) {
      debugPrint('Error service fetchUserApproves()');
      return e.response!;
    }
  }
}
