import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductAdminLoading extends ProductState {}

class ProductAdminOperationSuccess extends ProductState {
  final Iterable<Product> product;

  ProductAdminOperationSuccess([this.product = const []]);

  @override
  List<Object> get props => [
        product,
      ];
}

class ProductAdminOperationFailure extends ProductState {}

// class ProductAdminOperationCreated extends ProductState {}

// class ProductAdminDeleted extends ProductState {}
