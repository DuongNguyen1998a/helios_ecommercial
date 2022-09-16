import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 650) {
      return true;
    }
    else {
      return false;
    }
  }
}