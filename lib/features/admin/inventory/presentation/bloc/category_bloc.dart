import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/util/error/failure.dart';
import '../../data/model/category_model.dart';
import '../../domain/repo/inventory_repo.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final InventoryRepo _inventoryRepo;

  CategoryBloc(this._inventoryRepo) : super(const CategoryState.initial()) {
    on<CategoryEvent>((event, emit) async {
      switch (event) {
        case AddCategory():
          await _addCategory(event, emit);
          break;
        case DeleteCategory():
          await _deleteCategory(event, emit);
          break;
        case GetAllCategory():
          await _getAllCategory(event, emit);
          break;
      }
    });
  }

  // EVENTS
  Future<void> _addCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CategoryStatus.adding, error: null));
      final result = await _inventoryRepo.addCategory(category: event.category);
      if (result.isLeft) {
        emit(state.copyWith(status: CategoryStatus.idle, error: result.left));
      } else {
        final updatedList = List<CategoryModel>.from(state.category)
          ..add(event.category);
        emit(
          state.copyWith(
            status: CategoryStatus.added,
            category: updatedList,
            error: null,
          ),
        );
      }
    } catch (e) {
      log("er: [_addCategory][category_bloc.dart] $e");
      emit(
        state.copyWith(
          status: CategoryStatus.idle,
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  Future<void> _deleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CategoryStatus.deleting, error: null));
      final result = await _inventoryRepo.deleteCategory(id: event.categoryId);
      if (result.isLeft) {
        emit(state.copyWith(status: CategoryStatus.idle, error: result.left));
      } else {
        final updatedList = List<CategoryModel>.from(state.category)
          ..removeWhere((item) => item.id == event.categoryId);
        emit(
          state.copyWith(
            status: CategoryStatus.deleted,
            category: updatedList,
            error: null,
          ),
        );
      }
    } catch (e) {
      log("er: [_deleteCategory][category_bloc.dart] $e");
      emit(
        state.copyWith(
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  Future<void> _getAllCategory(
    GetAllCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(const CategoryState.initial().copyWith(status: CategoryStatus.loading));
      final result = await _inventoryRepo.getAllCategory();
      if (result.isLeft) {
        emit(const CategoryState.initial().copyWith(error: result.left));
      } else {
        emit(const CategoryState.initial().copyWith(category: result.right));
      }
    } catch (e) {
      log("er: [_getAllCategory][category_bloc.dart] $e");
      emit(
        const CategoryState.initial().copyWith(
          error: Failure(message: "An unexpected failure occurred."),
        ),
      );
    }
  }

  @override
  void onEvent(CategoryEvent event) {
    super.onEvent(event);
    log("CategoryEvent dispatched: $event");
  }
}
