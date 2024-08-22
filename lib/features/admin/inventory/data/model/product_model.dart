import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'category_model.dart';
import 'comment.dart';

part 'product_model.g.dart';

@HiveType(typeId: 5)
class ProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final double salePrice;
  @HiveField(7)
  final List<Comment> comments;
  @HiveField(8)
  final List<String> images;
  @HiveField(9)
  final String featuredImage;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
    required this.salePrice,
    required this.comments,
    required this.images,
    required this.featuredImage,
  });

  // Method to calculate discount percentage
  int get discountPercentage {
    if (price > 0 && salePrice < price) {
      return (((price - salePrice) / price) * 100).round();
    } else {
      return 0;
    }
  }

  factory ProductModel.fromFirebase(
      DataSnapshot product, DataSnapshot categorySnapshot) {
    final comments = product.child("comments").exists
        ? product.child("comments").value as List<dynamic>
        : [];
    final images = product.child("images").exists
        ? product.child("images").value as List<dynamic>
        : [];
    final categoryId = product.child("category_id").value.toString();
    return ProductModel(
      id: product.key.toString(),
      name: product.child("name").value.toString(),
      description: product.child("description").value.toString(),
      quantity: int.parse(product.child("quantity").value.toString()),
      category: CategoryModel.fromFirebase(categorySnapshot.child(categoryId)),
      price: double.parse(product.child("price").value.toString()),
      salePrice: double.parse(product.child("sale_price").value.toString()),
      comments: comments
          .map((data) => Comment.fromFirebase(data as DataSnapshot))
          .toList(),
      images: images.map((image) => image.toString()).toList(),
      featuredImage: product.child("featured_image").value.toString(),
    );
  }

  Map<String, dynamic> toFirebaseJson(
    List<String> urls,
    String featuredImageUrl,
  ) =>
      {
        id: {
          "name": name,
          "description": description,
          "quantity": quantity,
          "price": price,
          "sale_price": salePrice,
          "category_id": category.id,
          "comments": comments.map((item) => item.toFirebaseJson()).toList(),
          "images": urls,
          "featured_image": featuredImageUrl,
        }
      };
}
