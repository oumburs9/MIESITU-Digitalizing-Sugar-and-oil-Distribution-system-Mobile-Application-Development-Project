import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labpract/application/announcement/bloc/announcement_bloc.dart';

import 'package:labpract/application/auth/bloc/auth_bloc.dart';

import 'package:labpract/gloabl/routes.dart';
import 'package:labpract/infrastructure/announcement/data_provider/announcement_provider.dart';
import 'package:labpract/infrastructure/announcement/repository/announcement_repository.dart';
import 'package:labpract/infrastructure/auth/repository/auth_repository.dart';
import 'package:labpract/infrastructure/product/data_provider/product_provider.dart';
import 'package:labpract/infrastructure/product/repository/product_repository.dart';

import 'application/announcement/bloc/announcement_blocs.dart';
import 'application/product/bloc/product_blocs.dart';

void main() {
  runApp(MyHomePage(title: "Miesitu"));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rotr = MiesituRouter.router;
  AuthRepository? repo;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: AnnouncementRepository(
                dataProvider: AnnouncementDataProvider()),
          ),
          RepositoryProvider.value(
              value: ProductRepository(
            dataProvider: ProductDataProvider(),
          ))
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: AuthBloc(AuthRepository()),
            ),
            BlocProvider.value(
                value: AnnouncementBloc(
                    announcementRepository: AnnouncementRepository(
                        dataProvider: AnnouncementDataProvider()))
                  ..add(const AnnouncementAdminLoad())),
            BlocProvider.value(
                value: ProductBloc(
                    productRepository: ProductRepository(
              dataProvider: ProductDataProvider(),
            ))
                  ..add(const ProductAdminLoad())),
          ],
          child: MaterialApp.router(
            routerDelegate: rotr.routerDelegate,
            routeInformationParser: rotr.routeInformationParser,
          ),
        ),
      )),
    );
  }
}
