import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../../../core/config/firebase/path_mapper.dart';
import '../../../../../core/util/error/failure.dart';

sealed class AccountHelper {
  static Map<String, String> faqMap = {
    "What is your return policy?":
        "You can return items within 7 days of purchase.",
    "How can I track my order?":
        "Go to 'My Orders' and select the order to view tracking details.",
    "What payment methods do you accept?":
        "We accept credit cards, debit cards, PayPal, and more.",
    "Can I cancel my order?":
        "Yes, you can cancel your order within 2 hours of placing it.",
    "How long does delivery take?":
        "Delivery typically takes 3-5 business days.",
    "Is it safe to shop online?":
        "Yes, we use secure encryption to protect your information.",
    "How do I change my shipping address?":
        "You can update your address in the 'Account Settings' section.",
    "Do you ship internationally?":
        "Yes, we offer international shipping to select countries.",
    "What should I do if I receive a damaged item?":
        "Contact our support team immediately for assistance.",
    "Can I exchange an item?":
        "Yes, exchanges are allowed within 7 days of purchase.",
  };

  static String bugReportTitle =
      "If you came across a bug or issue in this app, please report it to our support team with as much detail as possible. This helps us understand and address the problem effectively.";

  static Future<Either<Failure, bool>> reportBug({
    required String userId,
    required String bug,
    File? image,
  }) async {
    if (!await InternetConnection().hasInternetAccess) {
      return Left(Failure(message: "Check your network connection"));
    }
    try {
      final time = DateTime.now();
      String uploadedUrl = '';
      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref('Bug Report/${time.millisecondsSinceEpoch}/$userId.jpg');
        await ref.putFile(image).whenComplete(
          () async {
            final url = await ref.getDownloadURL();
            uploadedUrl = url;
          },
        );
      }
      await FirebaseDatabase.instance
          .ref(PathMapper.reportPath(userId))
          .child('${time.millisecondsSinceEpoch}')
          .set(
        {
          'time': time.millisecondsSinceEpoch,
          'report': bug,
          'imageUrl': uploadedUrl,
        },
      );
      return const Right(true);
    } catch (e) {
      log("er:[reportBug][account_helper.dart] $e");
      return Left(Failure(message: 'Something went wrong. Try again'));
    }
  }
}
