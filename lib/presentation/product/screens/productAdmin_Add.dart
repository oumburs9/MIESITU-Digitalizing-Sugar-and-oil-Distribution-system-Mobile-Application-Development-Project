import 'package:go_router/go_router.dart';
import 'package:miesitu/application/product/bloc/product_blocs.dart';
import 'package:miesitu/domain/product/entity/product_model.dart';
// import 'package:miesitu/presentation/product/screens/productAdmin_Edit.dart';
// import 'package:miesitu/presentation/Admin_Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';

class AdminProductAdd extends StatefulWidget {
  static const String routeName = '/adminProductadd';

  @override
  _AdminProductAddState createState() => _AdminProductAddState();
}

class _AdminProductAddState extends State<AdminProductAdd> {
  final Map<String, dynamic> _product = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ClipRect(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 169, 171, 184),
                    offset: Offset(-10.0, 0.0),
                    blurRadius: 20.0,
                    spreadRadius: 4.0),
              ]),
          padding: const EdgeInsets.only(left: 80, right: 80),
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
                    'Product Page !!',
                    style: TextStyle(color: Color(0xFF363f93), fontSize: 31),
                  ),
                  SizedBox(
                    height: height * 0.12,
                  ),
                  TextFormField(
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
                              BlocProvider.of<ProductBloc>(context).add(event);
                              GoRouter.of(context).pushNamed(adminProductadd);
                              // Navigator.of(context)
                              //     .pushNamedAndRemoveUntil(
                              //         AdminMachineries.routeName,
                              //         (route) => false);
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
      ),
    );
  }
}
