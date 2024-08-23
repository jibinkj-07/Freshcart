part of 'category_bloc.dart';

enum CategoryStatus {
  idle,
  loading,
  loaded,
  adding,
  added,
  deleting,
  deleted,
}

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<CategoryModel> category;
  final Failure? error;

  const CategoryState({
    this.status = CategoryStatus.idle,
    this.category = const [],
    this.error,
  });

  const CategoryState.initial() : this();

  CategoryState copyWith({
    CategoryStatus? status,
    List<CategoryModel>? category,
    Failure? error,
  }) =>
      CategoryState(
        category: category ?? this.category,
        status: status ?? this.status,
        error: error,
      );

  @override
  List<Object?> get props => [status, category, error];
}
