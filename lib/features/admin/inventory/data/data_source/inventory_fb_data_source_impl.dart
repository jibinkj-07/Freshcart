import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/config/firebase/path_mapper.dart';
import '../../../../../core/util/error/failure.dart';
import '../model/category_model.dart';
import '../model/comment.dart';
import '../model/product_model.dart';
import 'inventory_fb_data_source.dart';

class InventoryFbDataSourceImpl implements InventoryFbDataSource {
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseStorage _firebaseStorage;

  InventoryFbDataSourceImpl(this._firebaseDatabase, this._firebaseStorage);

  @override
  Future<Either<Failure, bool>> addCategory(
      {required CategoryModel category}) async {
    try {
      await _firebaseDatabase
          .ref(PathMapper.categoryPath)
          .update(category.toFirebaseJson());
      return const Right(true);
    } catch (e) {
      log("er: [addCategory][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, bool>> addComment({
    required String productId,
    required Comment comment,
  }) async {
    try {
      await _firebaseDatabase
          .ref(PathMapper.commentPath(productId))
          .update(comment.toFirebaseJson());
      return const Right(true);
    } catch (e) {
      log("er: [addComment][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, bool>> addProduct(
      {required ProductModel product}) async {
    try {
      await _firebaseDatabase
          .ref(PathMapper.productPath)
          .update(product.toFirebaseJson());
      return const Right(true);
    } catch (e) {
      log("er: [addProduct][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory({required String id}) async {
    try {
      await _firebaseDatabase.ref("${PathMapper.categoryPath}/$id").remove();
      return const Right(true);
    } catch (e) {
      log("er: [deleteCategory][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment(
      {required String productId, required String commentId}) async {
    try {
      await _firebaseDatabase
          .ref("${PathMapper.commentPath(productId)}/$commentId")
          .remove();
      return const Right(true);
    } catch (e) {
      log("er: [deleteComment][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({required String id}) async {
    try {
      await _firebaseDatabase.ref("${PathMapper.productPath}/$id").remove();
      return const Right(true);
    } catch (e) {
      log("er: [deleteProduct][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategory() async {
    try {
      List<CategoryModel> items = [];
      final result = await _firebaseDatabase.ref(PathMapper.categoryPath).get();
      if (result.exists) {
        for (final category in result.children) {
          items.add(CategoryModel.fromFirebase(category));
        }
      }
      return Right(items);
    } catch (e) {
      log("er: [getAllCategory][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      List<ProductModel> items = [];
      final result = await _firebaseDatabase.ref(PathMapper.productPath).get();
      if (result.exists) {
        final categorySnapshot =
            await _firebaseDatabase.ref(PathMapper.categoryPath).get();
        for (final product in result.children) {
          items.add(ProductModel.fromFirebase(product, categorySnapshot));
        }
      }
      return Right(items);
    } catch (e) {
      log("er: [getAllProducts][inventory_fb_data_source_impl.dart] $e");
      return Left(Failure(message: "An unexpected error occurred. Try again"));
    }
  }
}
