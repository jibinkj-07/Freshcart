import 'package:either_dart/either.dart';

import '../../../../../core/util/error/failure.dart';
import '../model/category_model.dart';
import '../model/comment.dart';
import '../model/product_model.dart';

abstract class InventoryFbDataSource {
  /// PRODUCTS
  Future<Either<Failure, List<ProductModel>>> getAllProducts();

  Future<Either<Failure, bool>> addProduct({required ProductModel product});

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