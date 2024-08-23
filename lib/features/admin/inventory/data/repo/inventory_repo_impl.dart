import 'package:either_dart/either.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../../../core/util/error/failure.dart';
import '../../domain/repo/inventory_repo.dart';
import '../data_source/inventory_fb_data_source.dart';
import '../model/category_model.dart';
import '../model/comment.dart';
import '../model/product_model.dart';
import 'dart:io';

class InventoryRepoImpl implements InventoryRepo {
  final InventoryFbDataSource _inventoryFbDataSource;

  InventoryRepoImpl(this._inventoryFbDataSource);

  @override
  Future<Either<Failure, bool>> addCategory(
      {required CategoryModel category}) async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.addCategory(category: category);
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> addComment(
      {required String productId, required Comment comment}) async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.addComment(
          productId: productId, comment: comment);
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> addProduct({
    required ProductModel product,
    required List<File> images,
    required File featuredImage,
  }) async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.addProduct(
        product: product,
        images: images,
        featuredImage: featuredImage,
      );
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory({required String id}) async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.deleteCategory(id: id);
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment(
      {required String productId, required String commentId}) async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.deleteComment(
        productId: productId,
        commentId: commentId,
      );
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({required String id}) async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.deleteProduct(id: id);
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategory() async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.getAllCategory();
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    if (await InternetConnection().hasInternetAccess) {
      return await _inventoryFbDataSource.getAllProducts();
    } else {
      return Left(Failure(message: "Check your internet connection"));
    }
  }
}
