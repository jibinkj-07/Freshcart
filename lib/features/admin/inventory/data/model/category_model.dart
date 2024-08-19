import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 3)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;

  CategoryModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory CategoryModel.fromFirebase(DataSnapshot category) {
    final isExist = category.exists;
    return CategoryModel(
      id: isExist ? category.key.toString() : "",
      title: isExist ? category.child("title").value.toString() : "",
      description:
          isExist ? category.child("description").value.toString() : "",
    );
  }

  Map<String, dynamic> toFirebaseJson() => {
        id: {
          "title": title,
          "description": description,
        }
      };
}
