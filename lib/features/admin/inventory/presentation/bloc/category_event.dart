part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class AddCategory extends CategoryEvent {
  final CategoryModel category;

  const AddCategory({required this.category});

  @override
  List<Object?> get props => [category];
}

class DeleteCategory extends CategoryEvent {
  final String categoryId;

  const DeleteCategory({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class GetAllCategory extends CategoryEvent {
  @override
  List<Object?> get props => [];
}
