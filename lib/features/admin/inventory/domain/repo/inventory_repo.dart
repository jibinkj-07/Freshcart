import 'dart:io';

import 'package:either_dart/either.dart';

import '../../../../../core/util/error/failure.dart';
import '../../data/model/category_model.dart';
import '../../data/model/comment.dart';
import '../../data/model/product_model.dart';

abstract class InventoryRepo {
  /// PRODUCTS
  Future<Either<Failure, List<ProductModel>>> getAllProducts();

  Future<Either<Failure, ProductModel>> addProduct({
    required ProductModel product,
    required List<File> images,
    required File featuredImage,
  });

  Future<Either<Failure, bool>> deleteProduct({required String id});

  /// CATEGORY
  Future<Either<Failure, List<CategoryModel>>> getAllCategory();

  Future<Either<Failure, bool>> addCategory({required CategoryModel category});

  Future<Either<Failure, bool>> deleteCategory({required String id});

  /// COMMENTS
  Future<Either<Failure, bool>> addComment(
      {required String productId, required Comment comment});

  Future<Either<Failure, bool>> deleteComment(
      {required String productId, required String commentId});
}
