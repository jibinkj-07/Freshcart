import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/config/firebase/path_mapper.dart';
import '../../../inventory/data/model/product_model.dart';
import '../widget/shop_status.dart';

sealed class HomeHelper {
  static final _firebaseRef = FirebaseDatabase.instance;
  static StreamSubscription? _shopStatusSubscription;

  static listenShopStatus({required ValueNotifier<Status> status}) {
    _shopStatusSubscription =
        _firebaseRef.ref(PathMapper.shopStatusPath).onValue.listen((event) {
      if (event.snapshot.exists) {
        if (event.snapshot.value.toString().toLowerCase() == "open") {
          status.value = Status.open;
        } else {
          status.value = Status.closed;
        }
      }
    });
  }

  static Future<void> toggleShopStatus(Status status) async {
    try {
      await _firebaseRef.ref(PathMapper.shopPath).update({
        "status": status == Status.open ? "Open" : "Closed",
      });
    } catch (e) {
      log("er [toggleShopStatus][home_helper.dart] $e");
    }
  }

  static void disposeShopStatusListener() {
    if (_shopStatusSubscription != null) {
      _shopStatusSubscription!.cancel();
    }
  }

  static int outOfStockProductsCount(List<ProductModel> products) =>
      products.where((item) => item.quantity < 1).length;
}
