// ignore_for_file: avoid_print

import 'package:miesitu/infrastructure/product/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miesitu/application/product/events/product_event.dart';
import 'package:miesitu/application/product/states/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository})
      : super(ProductAdminLoading()) {
    on<ProductAdminLoad>((event, emit) async {
      emit(ProductAdminLoading());
      try {
        final productAdmins = await productRepository.fetchAllProduct();
        print("Successfully listed");
        emit(ProductAdminOperationSuccess(
          productAdmins,
        ));
      } catch (_) {
        emit(ProductAdminOperationFailure());
      }
    });

    on<ProductAdminCreate>((event, emit) async {
      // emit(ProductAdminLoading());
      try {
        print("create Product ");
        await productRepository.createPro(event.product);
        print("Successfully listed");
        emit(ProductAdminOperationSuccess());
      } catch (_) {
        print("create failed");
        emit(ProductAdminOperationFailure());
      }
    });
    on<ProductAdminUpdate>((event, emit) async {
      try {
        await productRepository.updatePro(
          event.product.id!,
          event.product,
        );
        final productAdmins = await productRepository.fetchAllProduct();
        print("Successfully updated and listed");
        emit(ProductAdminOperationSuccess(
          productAdmins,
        ));
      } catch (_) {
        emit(ProductAdminOperationFailure());
      }
    });
    on<ProductAdminDelete>((event, emit) async {
      try {
        await productRepository.deletePro(event.id);
        final productAdmins = await productRepository.fetchAllProduct();
        print("Successfully deleted and listed");
        emit(ProductAdminOperationSuccess(productAdmins));
      } catch (_) {
        print(" deletion failed");
        emit(ProductAdminOperationFailure());
      }
    });
  }
}
