import 'package:go_router/go_router.dart';
import 'package:miesitu/application/product/bloc/product_bloc.dart';
import 'package:miesitu/application/product/events/product_event.dart';
import 'package:miesitu/application/product/states/product_state.dart';
import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';
import 'package:miesitu/presentation/product/screens/productAdmin_Edit.dart';
import 'package:miesitu/presentation/common/slide_edit_and_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminProduct extends StatefulWidget {
  static const routeName = '/adminProduct';

  static Product editArg = Product(
      id: "", productName: "", productPrice: "", productDescription: "");

  const AdminProduct({Key? key}) : super(key: key);

  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (_, state) {
                  if (state is ProductAdminOperationFailure) {
                    return const Text('Could not Fetch');
                  }

                  if (state is ProductAdminOperationSuccess) {
                    final products = state.product;

                    return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (_, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Dismissible(
                              background: slideRightToDelete(),
                              secondaryBackground: slideLeftToEdit(),
                              key: ValueKey<Product>(products.elementAt(index)),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              "${products.elementAt(index).productName}?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  // Navigator.pop(context, false);
                                                  BlocProvider.of<ProductBloc>(
                                                          context)
                                                      .add(ProductAdminDelete(
                                                          products
                                                              .elementAt(index)
                                                              .id!));

                                                  GoRouter.of(context).pop();
                                                  // BlocProvider.of<ProductBloc>(
                                                  //         context)
                                                  //     .add(ProductAdminLoad());

                                                  // Navigator.pop(context, false);
                                                  // Navigator.of(context)
                                                  //     .pushNamedAndRemoveUntil(
                                                  //         AdminProduct
                                                  //             .routeName,
                                                  //         (route) => false);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  return res;
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  AdminProduct.editArg =
                                      products.elementAt(index);
                                  Navigator.of(context).pushNamed(
                                      AdminProductEdit.routeName,
                                      arguments: products.elementAt(index));
                                }
                              },
                              child: ProductCard(
                                productName:
                                    products.elementAt(index).productName,
                                productPrice:
                                    products.elementAt(index).productPrice,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      GoRouter.of(context)
                                          .pushNamed(adminProductEdit);
                                    },
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "${products.elementAt(index).productName}?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    GoRouter.of(context).pop();
                                                    // Navigator.pop(
                                                    //     context, false);
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      // Navigator.pop(context);
                                                      BlocProvider.of<
                                                                  ProductBloc>(
                                                              context)
                                                          .add(
                                                              ProductAdminLoad());
                                                      BlocProvider.of<
                                                                  ProductBloc>(
                                                              context)
                                                          .add(ProductAdminDelete(
                                                              products
                                                                  .elementAt(
                                                                      index)
                                                                  .id!));
                                                      context.goNamed(
                                                          adminProductList);
                                                    });
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    color: Theme.of(context).errorColor,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }

                  return const Center(
                      child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ));
                },
              ),
            )
          ],
          // create: () => Navigator.of(context).pushNamed(
          //   AdminAnnouncementAdd.routeName,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final List<Widget>? children;
  const ProductCard(
      {Key? key,
      required this.productName,
      required this.productPrice,
      this.children})
      : super(key: key);

  // get children => null;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                productName,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              contentPadding: const EdgeInsets.all(5),
              subtitle: Text(
                productPrice,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
              ),
              trailing: Container(
                  width: width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...?children,
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
