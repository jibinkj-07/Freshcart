part of 'product_bloc.dart';

enum ProductStatus {
  idle,
  loading,
  loaded,
  adding,
  added,
  deleting,
  deleted,
}

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductModel> products;
  final Failure? error;

  const ProductState({
    this.status = ProductStatus.idle,
    this.products = const [],
    this.error,
  });

  const ProductState.initial() : this();

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
    Failure? error,
  }) =>
      ProductState(
        status: status ?? this.status,
        products: products ?? this.products,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, products, error];
}
