part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class AddProduct extends ProductEvent {
  final ProductModel product;
  final List<File> images;
  final File featuredImage;

  const AddProduct({
    required this.product,
    required this.images,
    required this.featuredImage,
  });

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final ProductModel product;

  const DeleteProduct({required this.product});

  @override
  List<Object?> get props => [ product];
}

class GetAllProduct extends ProductEvent {
  @override
  List<Object?> get props => [];
}
