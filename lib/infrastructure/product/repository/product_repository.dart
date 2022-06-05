import 'package:miesitu/infrastructure/product/data_provider/product_provider.dart';
import 'package:miesitu/domain/product/entity/product_model.dart';

abstract class Re {}

class ProductRepository extends Re {
  final ProductDataProvider dataProvider;
  ProductRepository({required this.dataProvider});

  Future<Product> createPro(Product product) async {
    return dataProvider.createPro(product);
  }

  Future<void> updatePro(String id, Product product) async {
    dataProvider.updatePro(id, product);
  }

  Future<List<Product>> fetchAllProduct() async {
    return dataProvider.fetchAllProduct();
  }

  Future<void> deletePro(String id) async {
    dataProvider.deletePro(id);
  }
}
