import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/util/error/failure.dart';
import '../../data/model/product_model.dart';
import '../../domain/repo/inventory_repo.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final InventoryRepo _inventoryRepo;

  ProductBloc(this._inventoryRepo) : super(const ProductState.initial()) {
    on<ProductEvent>((event, emit) async {
      switch (event) {
        case AddProduct():
          await _addProduct(event, emit);
          break;
        case DeleteProduct():
          await _deleteProduct(event, emit);
          break;
        case GetAllProduct():
          await _getAllProduct(event, emit);
          break;
        case UpdateProduct():
          await _updateProduct(event, emit);
          break;
      }
    });
  }

  // EVENTS
  Future<void> _addProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        error: null,
        status: ProductStatus.adding,
      ),
    );
    try {
      final result = await _inventoryRepo.addProduct(
        product: event.product,
        images: event.images,
        featuredImage: event.featuredImage,
      );
      if (result.isLeft) {
        emit(state.copyWith(status: ProductStatus.idle, error: result.left));
      } else {
        final updatedList = List<ProductModel>.from(state.products)
          ..add(result.right);
        emit(
          state.copyWith(
            status: ProductStatus.added,
            products: updatedList,
            error: null,
          ),
        );
      }
    } catch (e) {
      log("er: [_addProduct][product_bloc.dart] $e");
      emit(
        state.copyWith(
          status: ProductStatus.idle,
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  Future<void> _updateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.adding, error: null));
    try {
      final result = await _inventoryRepo.deleteProduct(product: event.product);

      if (result.isLeft) {
        emit(state.copyWith(status: ProductStatus.idle, error: result.left));
      } else {
        List<ProductModel> updatedList = List<ProductModel>.from(state.products)
          ..removeWhere((item) => item.id == event.product.id);
        final addResult = await _inventoryRepo.addProduct(
          product: event.product,
          images: event.images,
          featuredImage: event.featuredImage,
        );
        if (addResult.isLeft) {
          emit(
            state.copyWith(status: ProductStatus.idle, error: addResult.left),
          );
        } else {
          updatedList.add(addResult.right);
          emit(
            state.copyWith(
              status: ProductStatus.added,
              products: updatedList,
              error: null,
            ),
          );
        }
      }
    } catch (e) {
      log("er: [_updateProduct][product_bloc.dart] $e");
      emit(
        state.copyWith(
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  Future<void> _deleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProductStatus.deleting, error: null));
      final result = await _inventoryRepo.deleteProduct(product: event.product);
      if (result.isLeft) {
        emit(state.copyWith(status: ProductStatus.idle, error: result.left));
      } else {
        final updatedList = List<ProductModel>.from(state.products)
          ..removeWhere((item) => item.id == event.product.id);
        emit(
          state.copyWith(
            status: ProductStatus.deleted,
            products: updatedList,
            error: null,
          ),
        );
      }
    } catch (e) {
      log("er: [_deleteProduct][product_bloc.dart] $e");
      emit(
        state.copyWith(
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  Future<void> _getAllProduct(
    GetAllProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(
          const ProductState.initial().copyWith(status: ProductStatus.loading));
      final result = await _inventoryRepo.getAllProducts();
      if (result.isLeft) {
        emit(const ProductState.initial().copyWith(error: result.left));
      } else {
        emit(const ProductState.initial().copyWith(products: result.right));
      }
    } catch (e) {
      log("er: [_getAllProduct][product_bloc.dart] $e");
      emit(
        const ProductState.initial().copyWith(
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  @override
  void onEvent(ProductEvent event) {
    super.onEvent(event);
    log("ProductEvent dispatched: $event");
  }
}
