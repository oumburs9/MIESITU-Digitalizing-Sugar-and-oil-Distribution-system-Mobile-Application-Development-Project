// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miesitu/application/auth/states/auth_state.dart';

import 'package:miesitu/gloabl/admin_profile.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';
import 'package:miesitu/gloabl/user_profile.dart';
import 'package:miesitu/gloabl/adminhome.dart';

import 'package:miesitu/presentation/announcement/announcement.dart';
import 'package:miesitu/presentation/auth/Login_screen.dart';
import 'package:miesitu/presentation/auth/sign_up_page.dart';

import 'package:miesitu/gloabl/userhome.dart';
import 'package:miesitu/presentation/product/product.dart';

class MiesituRouter {
  late final AuthState authState;

  static final router = GoRouter(
      initialLocation: '/login',
// refreshListenable: ,
// refreshListenable : GoRouterRefreshStream(AuthBloc.stream),

      routes: <GoRoute>[
        GoRoute(
            name: loginRoute,
            path: '/login',
            pageBuilder: (context, state) =>
                const MaterialPage<void>(child: LoginScreen()),
            routes: <GoRoute>[
              GoRoute(
                  name: registerRoute,
                  path: 'signup',
                  pageBuilder: (context, state) =>
                      MaterialPage<void>(child: SignUp())),
            ]),

// User Page Routing

        GoRoute(
            name: userHomeRoute,
            path: '/userhome',
            pageBuilder: (context, state) =>
                MaterialPage<void>(child: UserHome()),
            routes: <GoRoute>[
              GoRoute(
                  name: userAnnouncement,
                  path: 'userannouncement',
                  pageBuilder: (context, state) =>
                      const MaterialPage<void>(child: AnnouncementScreen())),
              GoRoute(
                  name: userProduct,
                  path: 'userProduct',
                  pageBuilder: (context, state) =>
                      const MaterialPage<void>(child: AdminProduct())),
              GoRoute(
                name: userProfile,
                path: 'userprofile',
                pageBuilder: (context, state) =>
                    const MaterialPage<void>(child: UserProfilePage()),
              )
            ]),

// Admin Page Routes

        GoRoute(
            name: adminHomeRoute,
            path: '/adminHome',
            pageBuilder: (context, state) =>
                const MaterialPage<void>(child: AdminHome()),
            routes: <GoRoute>[
              GoRoute(
                  name: adminAnnouncementlist,
                  path: 'adminAnnounce',
                  pageBuilder: (context, state) =>
                      const MaterialPage<void>(child: AdminAnnouncements()),
                  routes: [
                    GoRoute(
                        path: 'editAnnouncement',
                        name: adminAnnouncementEdit,
                        pageBuilder: (context, state) =>
                            MaterialPage<void>(child: AdminAnnouncementEdit())),
                    GoRoute(
                        path: 'addAnnouncement',
                        name: adminAnnouncementAdd,
                        pageBuilder: (context, state) =>
                            MaterialPage<void>(child: AdminAnnouncementAdd())),
                  ]),
            ]),
        GoRoute(
          name: adminProfile,
          path: '/adminProfile',
          pageBuilder: (context, state) =>
              const MaterialPage<void>(child: AdminProfile()),
        ),
        GoRoute(
          name: adminProductList,
          path: '/adminproduct',
          pageBuilder: (context, state) =>
              const MaterialPage<void>(child: AdminProfile()),
          routes: [
            GoRoute(
                path: 'addProduct',
                name: adminProductadd,
                pageBuilder: (context, state) =>
                    MaterialPage<void>(child: AdminProductAdd())),
            GoRoute(
                path: 'editProduct',
                name: adminProductEdit,
                pageBuilder: (context, state) => MaterialPage<void>(
                    arguments: state.extra, child: AdminAnnouncementEdit())),
          ],
        ),
      ],
      redirect: (state) {
        if (state is AdminLoginSuccess) {
          return adminHomeRoute;
        }

        if (state is LoginSuccess) {
          final userhomeloc = state.namedLocation(userHomeRoute);
          return userHomeRoute;
        }

        if (state is LoggedOutState) {
          return loginRoute;
        }
        return null;
      });
}
