import 'package:miesitu/application/product/states/product_state.dart';
import 'package:miesitu/application/product/bloc/product_bloc.dart';
import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (_, state) {
                if (state is ProductAdminOperationFailure) {
                  return const Text('Error: Displaying Product list');
                }

                if (state is ProductAdminOperationSuccess) {
                  final product = state.product;

                  return ListView.builder(
                      itemCount: product.length.toInt(),
                      itemBuilder: (_, int index) {
                        return Container(
                            key: ValueKey<Product>(product.elementAt(index)),
                            child: SingleChildScrollView(
                              child: Container(
                                height: 230,
                                child: Stack(children: [
                                  Positioned(
                                      top: 35,
                                      left: 20,
                                      child: Material(
                                        child: Container(
                                          height: 180,
                                          width: width * 0.9,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    offset: const Offset(
                                                        -10.0, 10.0),
                                                    blurRadius: 20.0,
                                                    spreadRadius: 4.0)
                                              ]),
                                        ),
                                      )),
                                  Positioned(
                                    top: 0,
                                    left: 30,
                                    child: Card(
                                      elevation: 10,
                                      shadowColor:
                                          Colors.grey.withOpacity(0.50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        height: 180,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/food_1.jpeg"),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 60,
                                      left: 200,
                                      child: Container(
                                        height: 150,
                                        width: 160,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                product
                                                    .elementAt(index)
                                                    .productName,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF363793),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 2),
                                            Text(
                                                product
                                                    .elementAt(index)
                                                    .productPrice,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const Divider(color: Colors.black),
                                            const SizedBox(height: 5),
                                            Expanded(
                                              child: Text(
                                                  product
                                                      .elementAt(index)
                                                      .productDescription,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ))
                                ]),
                              ),
                            ));
                      });
                }

                return const Center(
                    child: SizedBox(
                  width: 55,
                  height: 55,
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                ));
              },
            ),
          )
        ],
      ),
    );
  }
}
