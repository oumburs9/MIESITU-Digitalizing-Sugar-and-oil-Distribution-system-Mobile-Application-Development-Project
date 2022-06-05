import 'dart:convert';

import 'package:http/http.dart' as http;

<<<<<<< HEAD
import 'package:labpract/domain/product/entity/product_model.dart';
=======
import 'package:miesitu/domain/product/entity/product_model.dart';
>>>>>>> f1942a148f6737ce258d15325cd8de66c71659fe

class ProductDataProvider {
  // final productUrl = 'https://6295158f63b5d108c199b161.mockapi.io/api/products';
  final productUrl = 'http://127.0.0.1:7000/api/products/';

  Future<Product> createPro(Product product) async {
    final response = await http.post(
      Uri.parse(productUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'product_name': product.productName,
        'product_price': product.productPrice,
        'product_description': product.productDescription,
      }),
    );
    if (response.statusCode == 201) {
      print("Successful creation of a product");
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Product>> fetchAllProduct() async {
    final response = await http.get(Uri.parse('$productUrl/'));

    if (response.statusCode == 200) {
      print("Successfully fetched product: ${response.body}");
      final products = jsonDecode(response.body) as List;
      return products.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<Product> updatePro(String id, Product product) async {
    final http.Response response = await http.put(
      Uri.parse('$productUrl/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'id': Product.id,
        'product_name': product.productName,
        'product_price': product.productPrice,
        'product_description': product.productDescription,
      }),
    );
    if (response.statusCode == 200) {
      print("Successful updation of a product");
      return Product.fromJson(jsonDecode(response.body));
    }
    print("Unsuccessful updation of a product");
    return Product(
        id: "", productName: "", productPrice: "", productDescription: "");
  }

  Future<http.Response> deletePro(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$productUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
    // if (response.statusCode != 200) {
    //   // print(response.body);
    //   throw ('Failed to delete product!.');
    // }
  }
}
