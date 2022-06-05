import 'package:go_router/go_router.dart';
import 'package:miesitu/application/product/events/product_event.dart';
import 'package:miesitu/application/product/bloc/product_bloc.dart';
import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:miesitu/domain/product/entity/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';

class AdminProductEdit extends StatefulWidget {
  static const String routeName = '/adminProductedit';

  final Product product;
  AdminProductEdit({required this.product});

  @override
  _AdminProductEditState createState() => _AdminProductEditState();
}

class _AdminProductEditState extends State<AdminProductEdit> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _product = {};

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 50, right: 50),

            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.08,
                    ),
                    const Text(
                      'Wel Come To ',
                      style: TextStyle(color: Color(0xFF363f93), fontSize: 31),
                    ),
                    const Text(
                      'Product Edit page !!',
                      style: TextStyle(color: Color(0xFF363f93), fontSize: 31),
                    ),
                    SizedBox(
                      height: height * 0.12,
                    ),
                    TextFormField(
                        initialValue: widget.product.productName,
                        decoration: const InputDecoration(
                          labelText: "Enter the product name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter the  product name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _product["product_name"] = value;
                          });
                        }),
                    SizedBox(height: height * 0.06),
                    TextFormField(
                      initialValue: widget.product.productPrice,
                      decoration: const InputDecoration(
                        labelText: 'Enter the product price',
                        border: OutlineInputBorder(),
                      ),
                      // keyboardType: TextInputType.url,
                      onSaved: (value) {
                        setState(() {
                          _product["product_price"] = value;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.06),
                    TextFormField(
                        initialValue: widget.product.productDescription,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: "Enter the Product description",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter  the  description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _product["product_description"] = value;
                          });
                        }),
                    SizedBox(height: height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.blue.withOpacity(0.04);
                                  }
                                  if (states.contains(MaterialState.focused) ||
                                      states.contains(MaterialState.pressed)) {
                                    return Colors.blue.withOpacity(0.12);
                                  }
                                  return null; // Defer to the widget's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form != null && form.validate()) {
                                form.save();
                                final ProductEvent event = ProductAdminCreate(
                                  Product(
                                    id: '',
                                    productName: _product["product_name"],
                                    productPrice: _product["product_price"],
                                    productDescription:
                                        _product["product_description"],
                                  ),
                                );
                                BlocProvider.of<ProductBloc>(context)
                                    .add(event);
                                GoRouter.of(context).goNamed(adminProductadd);

    
                              }
                            },
                            child: const Text('Save',
                                style: TextStyle(
                                    color: Color(0xFF363f93),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))
                      ],
                    )
                  ],
                )),

          ),
        )));
  }
}
