import 'dart:convert';

import 'package:helios_ecommercial/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Functions {
  static String formatDDMMYYYY(String dateInput) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateInput));
  }

  static String formatYYYYMMDD(DateTime dateInput) {
    return DateFormat('yyyy-MM-dd').format(dateInput);
  }

  static String formatCurrency(int inputValue) {
    return NumberFormat('#,##0', 'en_US').format(inputValue).toString();
  }

  static String currentStringDateTime() {
    return DateFormat('ddMMyyyyHHmmss').format(DateTime.now());
  }

  static Future<bool> checkLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

    if (userInformation != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<int> getUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

    if (userInformation != null) {
      final data = json.decode(userInformation) as Map<String, dynamic>;
      return data['customerID'];
    } else {
      return 0;
    }
  }
}
