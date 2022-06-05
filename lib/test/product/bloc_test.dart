import 'package:labpract/application/product/bloc/product_blocs.dart';
import 'package:labpract/domain/product/entity/product_model.dart';
import 'package:labpract/infrastructure/product/repository/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  MockProductRepository productRepository = MockProductRepository();

  final product = Product(
      id: "1",
      productName: "Oumer oil",
      productPrice: 25.toString(),
      productDescription: "Wonderful oil");
  Future<List<Product>> createProducts() async {
    return [
      Product(
          id: "1",
          productName: "Oumer oil",
          productPrice: 25.toString(),
          productDescription: "Wonderful oil")
    ];
  }

  Future<Product> createProduct() async {
    return Product( id: "1",
          productName: "Oumer oil",
          productPrice: 25.toString(),
          productDescription: "Wonderful oil");
  }

  ;

  setUp(() {
    productRepository = MockProductRepository();
    // productBloc =
    //     productBloc(productRepository: productRepository);
  });

  blocTest<ProductBloc, ProductState>(
      'emits [productLoading,productAdminOperationSuccess] when successful',
      build: () {
        when(() => productRepository.fetchAllProduct())
            .thenAnswer((invocation) => createProducts());
        return ProductBloc(productRepository: productRepository);
      },
      act: (bloc) => bloc.add(ProductAdminLoad()),
      expect: () {
        return [ProductAdminLoading(), isA<ProductAdminOperationSuccess>()];
      });

  blocTest<ProductBloc, ProductState>(
      'emits [productLoading,productAdminOperationFailure] when unsuccessful',
      build: () {
        return ProductBloc(productRepository: productRepository);
      },
      act: (bloc) => bloc.add(ProductAdminLoad()),
      expect: () {
        return [ProductAdminLoading(), ProductAdminOperationFailure()];
      });

  blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading,ProductAdminOperationSuccess] when successful',
      build: () {
        when(() => productRepository.createPro(product))
            .thenAnswer((invocation) => createProduct());
        when(() => productRepository.fetchAllProduct())
            .thenAnswer((invocation) => createProducts());
        return ProductBloc(productRepository: productRepository);
      },
      act: (bloc) => bloc.add(ProductAdminCreate(product)),
      expect: () {
        return [isA<ProductAdminOperationSuccess>()];
      });

  blocTest<ProductBloc, ProductState>(
      'emits [ProductAdminOperationSuccess] when successful',
      build: () {
        when(() => productRepository.updatePro("1", product))
            .thenAnswer((invocation) => createProduct());
        when(() => productRepository.fetchAllProduct())
            .thenAnswer((invocation) => createProducts());
        return ProductBloc(productRepository: productRepository);
      },
      act: (bloc) => bloc.add(ProductAdminUpdate(product)),
      expect: () {
        return [isA<ProductAdminOperationSuccess>()];
      });

  blocTest<ProductBloc, ProductState>(
      'emits [productAdminOperationSuccess] when successful',
      build: () {
        when(() => productRepository.deletePro("1"))
            .thenAnswer((invocation) => createProduct());
        when(() => productRepository.fetchAllProduct())
            .thenAnswer((invocation) => createProducts());
        return ProductBloc(productRepository: productRepository);
      },
      act: (bloc) => bloc.add(ProductAdminDelete("1")),
      expect: () {
        return [isA<ProductAdminOperationSuccess>()];
      });
}
