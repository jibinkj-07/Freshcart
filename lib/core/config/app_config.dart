import 'package:flutter/material.dart';

sealed class AppConfig {
  static String appName = "Freshcart";
  static Color appColor = Colors.amber;
  static String fontFamily = "Poppins";
  static String priceSymbol = "₹";

  static String priceFormat<T>(T price) {
    if (price is double) {
      return "₹ ${price.toStringAsFixed(2)}";
    } else {
      return "₹ $price";
    }
  }
}
